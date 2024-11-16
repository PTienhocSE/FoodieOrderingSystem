/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

/**
 *
 * @author phuct
 */
import model.OrderDTO;
import model.OrderItemDTO;
import model.Account;
import model.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Order;
import model.Product;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import model.Shop;
import model.ShopRevenue;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public OrderDTO createOrder(int orderID, String paymentID, Account account, List<CartItem> cartItems, String paymentOption,
            String address, String paymentStatus, String deliveryStatus, String deliveryOption, String timePickupString, String phone) throws Exception {
        Date timePickup = null;

        try {
            if (timePickupString != null && !timePickupString.isEmpty()) {
                timePickup = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(timePickupString);
            }
        } catch (ParseException e) {
            e.printStackTrace();
            throw new Exception("Invalid time format: " + timePickupString, e);
        }

        java.util.Date createdDate = new java.util.Date();

        String insertOrderSql = "INSERT INTO [Order] (OrderID, PaymentID, UserID, PaymentStatus, DeliveryStatus, Address, CreatedDate, TotalAmount, PaymentOption, DeliveryOption, TimePickup, Phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String insertOrderItemSql = "INSERT INTO OrderItem (OrderID, ProductID, Quantity, TotalPrice) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        OrderDTO order = null;

        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            double totalAmount = 0;
            for (CartItem item : cartItems) {
                totalAmount += item.getQuantity() * item.getProduct().getPrice();
            }

            // Ghi đơn hàng vào cơ sở dữ liệu
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSql)) {
                ps.setInt(1, orderID);
                ps.setString(2, paymentID);
                ps.setInt(3, account.getUserID());
                ps.setString(4, paymentStatus);
                ps.setString(5, deliveryStatus);
                ps.setString(6, address);
                ps.setTimestamp(7, new java.sql.Timestamp(createdDate.getTime()));
                ps.setDouble(8, totalAmount); // Đảm bảo tổng tiền đã được cập nhật
                ps.setString(9, paymentOption);
                ps.setString(10, deliveryOption);
                ps.setTimestamp(11, timePickup != null ? new java.sql.Timestamp(timePickup.getTime()) : null);
                ps.setString(12, phone);

                ps.executeUpdate();
            }

            // Ghi các mục đơn hàng vào cơ sở dữ liệu
            for (CartItem item : cartItems) {
                try (PreparedStatement ps = conn.prepareStatement(insertOrderItemSql)) {
                    ps.setInt(1, orderID);
                    ps.setInt(2, item.getProduct().getProductId());
                    ps.setInt(3, item.getQuantity());
                    ps.setDouble(4, item.getQuantity() * item.getProduct().getPrice());
                    ps.executeUpdate();
                }
            }

            conn.commit();
            order = new OrderDTO(orderID, account, totalAmount, paymentOption, paymentStatus, deliveryStatus, address, createdDate.toString(), phone);

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return order;
    }

    public void updateOrderTotalAmount(int orderID, double totalAmount) throws SQLException, Exception {
        String sql = "UPDATE [Order] SET TotalAmount = ? WHERE OrderID = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        }
    }

    public List<OrderDTO> getOrderInfo() {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT o.OrderID, u.UserName, o.Address, o.CreatedDate, o.TotalAmount, o.PaymentOption "
                + "FROM [Order] o INNER JOIN Users u ON o.UserID = u.UserID";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account(rs.getString(2));
                list.add(new OrderDTO(rs.getInt(1), account, rs.getString(3), rs.getTimestamp(4), rs.getDouble(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the connection
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<OrderItemDTO> getOrderItems(int orderId) {
        List<OrderItemDTO> list = new ArrayList<>();
        String sql = "SELECT oi.ProductID, p.ProductName, oi.Quantity, oi.TotalPrice "
                + "FROM OrderItem oi INNER JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE oi.OrderID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(rs.getInt(1), rs.getString(2));
                list.add(new OrderItemDTO(orderId, product, rs.getInt(3), rs.getDouble(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the connection
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public OrderDTO getLatestOrder(int userId) {
        OrderDTO latestOrder = null;
        String sql = "SELECT TOP 1 * FROM [Order] WHERE UserID = ? ORDER BY CreatedDate DESC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                latestOrder = new OrderDTO();
                latestOrder.setOrderId(rs.getInt("OrderID"));
                latestOrder.setUser(new Account());
                latestOrder.getUser().setUserID(userId);
                latestOrder.setAddress(rs.getString("Address"));
                latestOrder.setCreatedDate(rs.getTimestamp("CreatedDate"));
                latestOrder.setTotalAmount(rs.getDouble("TotalAmount"));
                latestOrder.setPaymentOption(rs.getString("PaymentOption"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return latestOrder;
    }

    public void updateOrderPaymentStatus(String paymentID, String status) throws Exception {
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("UPDATE [Order] SET PaymentStatus = ? WHERE PaymentID = ?")) {

            ps.setString(1, status);
            ps.setString(2, paymentID);
            int updatedRows = ps.executeUpdate();

            if (updatedRows == 0) {
                System.out.println("No order found with PaymentID: " + paymentID);
            } else {
                System.out.println("Updated PaymentID: " + paymentID + " to status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void updateOrderPaymentStatusByOrderID(int orderID, String status) throws Exception {
        String sql = "UPDATE [Order] SET DeliveryStatus = ? WHERE OrderID = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderID);
            int updatedRows = ps.executeUpdate();

            if (updatedRows == 0) {
                System.out.println("No order found with OrderID: " + orderID);
            } else {
                System.out.println("Updated OrderID: " + orderID + " to status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderDeliveryStatus(String paymentID, String status) throws Exception {
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("UPDATE [Order] SET DeliveryStatus = ? WHERE PaymentID = ?")) {

            ps.setString(1, status);
            ps.setString(2, paymentID);
            int updatedRows = ps.executeUpdate();

            if (updatedRows == 0) {
                System.out.println("No order found with PaymentID: " + paymentID);
            } else {
                System.out.println("Updated PaymentID: " + paymentID + " to status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void updateRefundStatus(String paymentID, int status) throws Exception {
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("UPDATE [Order] SET isRefund = ? WHERE PaymentID = ?")) {

            ps.setInt(1, status);
            ps.setString(2, paymentID);
            int updatedRows = ps.executeUpdate();

            if (updatedRows == 0) {
                System.out.println("No order found with PaymentID: " + paymentID);
            } else {
                System.out.println("Updated PaymentID: " + paymentID + " to status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    private DBContext dbContext;

    public OrderDAO() {
        dbContext = new DBContext();
    }

    public List<Order> getOrderListByUserID(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM [Order] WHERE UserID = ? ORDER BY CreatedDate DESC";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getString("PaymentStatus"),
                        rs.getString("DeliveryStatus"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("DeliveryOption"),
                        rs.getTimestamp("TimePickup"),
                        rs.getDouble("TotalAmount"),
                        rs.getInt("DiscountID"),
                        rs.getString("PaymentOption"),
                        rs.getInt("isRefund"),
                        rs.getString("Phone")
                );
                orders.add(order);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No orders found for the user");
        return null;
    }

    public Integer getShopIDByPaymentID(String paymentID) {
        String query = "SELECT DISTINCT p.ShopID "
                + "FROM [Order] o "
                + "JOIN [OrderItem] oi ON o.OrderID = oi.OrderID "
                + "JOIN [Product] p ON oi.ProductID = p.ProductID "
                + "WHERE o.PaymentID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, paymentID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ShopID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No shop found for the payment ID");
        return null;
    }

    public List<Order> getOrderListByShopID(int shopId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT DISTINCT o.* "
                + "FROM [Order] o "
                + "JOIN OrderItems oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ? "
                + "ORDER BY o.CreatedDate DESC";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getString("PaymentStatus"),
                        rs.getString("DeliveryStatus"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("DeliveryOption"),
                        rs.getTimestamp("TimePickup"),
                        rs.getDouble("TotalAmount"),
                        rs.getInt("DiscountID"),
                        rs.getString("PaymentOption"),
                        rs.getInt("isRefund"),
                        rs.getString("Phone")
                );
                orders.add(order);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No orders found for the shop");
        return null;
    }

    public List<Order> getOrderListByShopIDAndStatus(int shopId, String status) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT DISTINCT o.* "
                + "FROM [Order] o "
                + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ? AND o.DeliveryStatus = ? AND o.PaymentStatus LIKE 'PAID'"
                + "ORDER BY o.CreatedDate DESC";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getString("PaymentStatus"),
                        rs.getString("DeliveryStatus"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("DeliveryOption"),
                        rs.getTimestamp("TimePickup"),
                        rs.getDouble("TotalAmount"),
                        rs.getInt("DiscountID"),
                        rs.getString("PaymentOption"),
                        rs.getInt("isRefund"),
                        rs.getString("Phone")
                );
                orders.add(order);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No orders found for the shop with the specified status");
        return null;
    }

    public List<Order> getRecentOrdersByShopID(int shopId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT TOP 5 o.* " // Nếu bạn dùng MySQL, thay "TOP 5" bằng "LIMIT 5"
                + "FROM [Order] o "
                + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ? AND o.PaymentStatus LIKE 'PAID' "
                + "ORDER BY o.CreatedDate DESC";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getString("PaymentStatus"),
                        rs.getString("DeliveryStatus"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("DeliveryOption"),
                        rs.getTimestamp("TimePickup"),
                        rs.getDouble("TotalAmount"),
                        rs.getInt("DiscountID"),
                        rs.getString("PaymentOption"),
                        rs.getInt("isRefund"),
                        rs.getString("Phone")
                );
                orders.add(order);
            }
            return orders;
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No recent orders found for the shop");
        return null;
    }

    public List<Double> getMonthlyAmount() {
        List<Double> monthlyAmounts = new ArrayList<>();
        String query = "SELECT SUM(o.TotalAmount) AS TotalAmount, MONTH(o.CreatedDate) AS Month "
                + "FROM [Order] o "
                + "WHERE YEAR(o.CreatedDate) = YEAR(GETDATE()) "
                + "GROUP BY MONTH(o.CreatedDate) "
                + "ORDER BY MONTH(o.CreatedDate)";

        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                monthlyAmounts.add(rs.getDouble("TotalAmount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return monthlyAmounts;
    }

    public double getTotalMoneyByMonth(int shopId, int month) throws Exception {
        double totalAmount = 0.0;
        String query = "SELECT SUM(o.TotalAmount) AS TotalAmount "
                + "FROM [Order] o "
                + "WHERE o.ShopID = ? AND MONTH(o.CreatedDate) = ? AND YEAR(o.CreatedDate) = YEAR(GETDATE())";

        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, shopId);
            ps.setInt(2, month);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalAmount = rs.getDouble("TotalAmount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalAmount;
    }

    public int getOrderCountByShopID(int shopId) {
        String query = "SELECT COUNT(DISTINCT o.OrderID) AS OrderCount "
                + "FROM [Order] o "
                + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ? AND o.PaymentStatus LIKE 'PAID' ";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("OrderCount"); // Return the order count
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No orders found for the shop");
        return 0; // If no orders are found
    }

    public double getTotalMoneyToday() {
        String query = "SELECT SUM(o.TotalAmount) AS TotalToday "
                + "FROM [Order] o "
                + "WHERE CAST(o.CreatedDate AS DATE) = CAST(GETDATE() AS DATE) "
                + "AND o.PaymentStatus LIKE 'PAID' "
                + "AND o.isRefund = 0"; // Removed the extra AND
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("TotalToday");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getTotalMoneyThisMonth() {
        String query = "SELECT SUM(o.TotalAmount) AS TotalThisMonth "
                + "FROM [Order] o "
                + "WHERE MONTH(o.CreatedDate) = MONTH(GETDATE()) "
                + "AND YEAR(o.CreatedDate) = YEAR(GETDATE()) "
                + "AND o.PaymentStatus LIKE 'PAID' "
                + "AND o.isRefund = 0";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("TotalThisMonth");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getTotalMoneyYesterday() {
        String query = "SELECT SUM(o.TotalAmount) AS TotalYesterday "
                + "FROM [Order] o "
                + "WHERE CAST(o.CreatedDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) "
                + "AND o.PaymentStatus LIKE 'PAID'"
                + "AND o.isRefund = 0";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("TotalYesterday");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getTotalMoneyLastMonth() {
        String query = "SELECT SUM(o.TotalAmount) AS TotalLastMonth "
                + "FROM [Order] o "
                + "WHERE MONTH(o.CreatedDate) = MONTH(DATEADD(MONTH, -1, GETDATE())) "
                + "AND YEAR(o.CreatedDate) = YEAR(DATEADD(MONTH, -1, GETDATE())) "
                + "AND o.PaymentStatus LIKE 'PAID' "
                + "AND o.isRefund = 0";  // Lọc các đơn hàng không bị hoàn trả
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("TotalLastMonth");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public Order getOrderByOrderID(int orderId) {
        String query = "SELECT * FROM [Order] WHERE OrderID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getString("PaymentStatus"),
                        rs.getString("DeliveryStatus"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("DeliveryOption"),
                        rs.getTimestamp("TimePickup"),
                        rs.getDouble("TotalAmount"),
                        rs.getInt("DiscountID"),
                        rs.getString("PaymentOption"),
                        rs.getInt("isRefund"),
                        rs.getString("Phone")
                );
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No order found with the specified OrderID");
        return null;
    }

    public int getUserIDByOrderID(int orderId) {
        int UserId = 0;
        String query = "SELECT UserID FROM [Order] WHERE OrderID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserId = rs.getInt("UserID");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No order found with the specified OrderID");
        return UserId;
    }

    public int getTotalByOrderID(int orderId) {
        int TotalAmount = 0;
        String query = "SELECT TotalAmount FROM [Order] WHERE OrderID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TotalAmount = rs.getInt("TotalAmount");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No order found with the specified OrderID");
        return TotalAmount;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE [Order] SET DeliveryStatus = ? WHERE OrderID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getPaymentIDByOrderID(int orderId) {
        String paymentID = null;
        String sql = "SELECT PaymentID FROM [Order] WHERE OrderID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                paymentID = rs.getString("PaymentID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return paymentID;
    }

    public int getOrderIDByPaymentID(String paymentID) {
        int orderID = 0;
        String sql = "SELECT OrderID FROM [Order] WHERE PaymentID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, paymentID);
            rs = ps.executeQuery();

            if (rs.next()) {
                orderID = rs.getInt("OrderID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return orderID;
    }

    public String getEmailByOrderID(int orderID) {
        String email = null;
        String sql = "SELECT Email FROM Users WHERE UserID = (SELECT UserID FROM [Order] WHERE OrderID = ?)";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("Email");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return email;
    }
    
        public String getEmailByUserID(int userID) {
        String email = null;
        String sql = "SELECT Email FROM Users WHERE UserID = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("Email");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return email;
    }

    public String getDeliveryStatusByOrderID(int orderId) {
        String deliveryStatus = null;
        String sql = "SELECT DeliveryStatus FROM [Order] WHERE OrderID = ?";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                deliveryStatus = rs.getString("DeliveryStatus");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return deliveryStatus;
    }

    // Admin function - getRevenue
    public double getRevenue() {
        double revenue = 0;
        String sql = "SELECT SUM(TotalAmount) AS Revenue FROM [Order] WHERE DeliveryStatus = 'COMPLETED' AND isRefund = 0";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("Revenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenue;
    }

    // Admin function - Statistics Chart
    public Map<String, Object> getOrderData() {
        Map<String, Object> data = new HashMap<>();
        List<Integer> orderCounts = new ArrayList<>();
        List<Double> revenues = new ArrayList<>();
        List<String> monthYears = new ArrayList<>();

        String sql = "SELECT YEAR(CreatedDate) AS Year, MONTH(CreatedDate) AS Month, COUNT(OrderID) AS OrderCount, SUM(TotalAmount) AS TotalRevenue "
                + "FROM [ordering_system].[dbo].[Order] "
                + "WHERE DeliveryStatus = 'COMPLETED' AND isRefund = 0 "
                + "GROUP BY YEAR(CreatedDate), MONTH(CreatedDate) "
                + "ORDER BY Year ASC, Month ASC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet resultSet = ps.executeQuery();

            // Thêm kết quả truy vấn vào các danh sách
            while (resultSet.next()) {
                int year = resultSet.getInt("Year");
                int month = resultSet.getInt("Month");
                int orderCount = resultSet.getInt("OrderCount");
                double totalRevenue = resultSet.getDouble("TotalRevenue");

                // Tạo định dạng Month-Year để dễ hiển thị
                monthYears.add(month + "/" + year);
                orderCounts.add(orderCount);
                revenues.add(totalRevenue);
            }

            resultSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        data.put("months", monthYears);
        data.put("orderCounts", orderCounts);
        data.put("revenues", revenues);
        return data;
    }

    // Function to get monthly revenue change percentage
    public String getMonthlyRevenueChangePercentage() {
        String result = "";
        String sql = "SELECT YEAR(CreatedDate) AS Year, MONTH(CreatedDate) AS Month, SUM(TotalAmount) AS TotalRevenue "
                + "FROM [Order] "
                + "WHERE DeliveryStatus = 'COMPLETED' AND isRefund = 0 "
                + "GROUP BY YEAR(CreatedDate), MONTH(CreatedDate) "
                + "ORDER BY Year DESC, Month DESC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            Double currentMonthRevenue = null;
            Double previousMonthRevenue = null;

            if (rs.next()) {
                currentMonthRevenue = rs.getDouble("TotalRevenue");
            }
            if (rs.next()) {
                previousMonthRevenue = rs.getDouble("TotalRevenue");
            }

            if (currentMonthRevenue != null && previousMonthRevenue != null && previousMonthRevenue != 0) {
                double percentageChange = ((currentMonthRevenue - previousMonthRevenue) / previousMonthRevenue) * 100;
                if (percentageChange > 0) {
                    result = "Increased " + String.format("%.2f", percentageChange) + "%than last month";
                } else {
                    result = "Decreased " + String.format("%.2f", Math.abs(percentageChange)) + "% than last month ";
                }
            } else {
                result = "Not enough data to comapare";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // admin- getRevenueByShop
    public List<ShopRevenue> getRevenueByShop() {
        String query = """
            SELECT 
                s.ShopID,
                s.Name AS ShopName,
                u.FullName AS ShopOwner,
                COALESCE(SUM(CASE WHEN o.PaymentOption = 'VNPay' THEN o.TotalAmount END), 0) AS VNPayRevenue,
                COALESCE(SUM(CASE WHEN o.PaymentOption = 'COD' THEN o.TotalAmount END), 0) AS CODRevenue,
                COALESCE(SUM(o.TotalAmount), 0) AS TotalRevenue
            FROM 
                Shop s
            JOIN 
                Users u ON s.ShopID = u.ShopID AND u.Role = 2 -- Chỉ lấy user là chủ cửa hàng
            JOIN 
                Product p ON s.ShopID = p.ShopID
            JOIN 
                OrderItem oi ON p.ProductID = oi.ProductID
            JOIN 
                [Order] o ON oi.OrderID = o.OrderID
            WHERE 
                o.isRefund = 0 AND o.DeliveryStatus = 'COMPLETED'
            GROUP BY 
                s.ShopID, s.Name, u.FullName;
            """;

        List<ShopRevenue> revenueList = new ArrayList<>();

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int shopID = rs.getInt("ShopID");
                String shopName = rs.getString("ShopName");
                String shopOwner = rs.getString("ShopOwner");
                double vnPayRevenue = rs.getDouble("VNPayRevenue");
                double codRevenue = rs.getDouble("CODRevenue");
                double totalRevenue = rs.getDouble("TotalRevenue");

                ShopRevenue revenue = new ShopRevenue(shopID, shopName, shopOwner, vnPayRevenue, codRevenue, totalRevenue);
                revenueList.add(revenue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenueList;
    }

    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
        Map<String, Object> data = orderDAO.getOrderData();
        for (Map.Entry<String, Object> set : data.entrySet()) {
            System.out.println(set.getKey() + " = " + set.getValue());
        }

        String revenueChange = orderDAO.getMonthlyRevenueChangePercentage();
        System.out.println(revenueChange);

        System.out.println("/n");
        List<ShopRevenue> shops = orderDAO.getRevenueByShop();
        for (ShopRevenue s : shops) {
            System.out.println(s.toString());
        }
    }
    
    
    public List<Order> getPagedOrderListByShopIDAndStatus(int shopId, String status, int page, int size) {
    List<Order> orders = new ArrayList<>();
    String query = "SELECT DISTINCT o.* "
            + "FROM [Order] o "
            + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
            + "JOIN Product p ON oi.ProductID = p.ProductID "
            + "WHERE p.ShopID = ? AND o.DeliveryStatus = ? AND o.PaymentStatus LIKE 'PAID' "
            + "ORDER BY o.CreatedDate DESC "
            + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; 

    try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
        ps.setInt(1, shopId);
        ps.setString(2, status);
        ps.setInt(3, (page - 1) * size); 
        ps.setInt(4, size); 
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Order order = new Order(
                    rs.getInt("OrderID"),
                    rs.getInt("UserID"),
                    rs.getString("PaymentStatus"),
                    rs.getString("DeliveryStatus"),
                    rs.getString("Address"),
                    rs.getDate("CreatedDate"),
                    rs.getString("DeliveryOption"),
                    rs.getTimestamp("TimePickup"),
                    rs.getDouble("TotalAmount"),
                    rs.getInt("DiscountID"),
                    rs.getString("PaymentOption"),
                    rs.getInt("isRefund"),
                    rs.getString("Phone")
            );
            orders.add(order);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return orders;
}
    
    public int getOrderCountByShopIDAndStatus(int shopId, String status) {
    String query = "SELECT COUNT(DISTINCT o.OrderID) AS Total "
            + "FROM [Order] o "
            + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
            + "JOIN Product p ON oi.ProductID = p.ProductID "
            + "WHERE p.ShopID = ? AND o.DeliveryStatus = ? AND o.PaymentStatus LIKE 'PAID'";

    try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
        ps.setInt(1, shopId);
        ps.setString(2, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("Total");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0; // Nếu có lỗi, trả về 0
}



}
