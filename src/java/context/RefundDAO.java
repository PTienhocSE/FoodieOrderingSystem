/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

/**
 *
 * @author phuct
 */
import java.math.BigDecimal;
import model.Refund;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class RefundDAO {

    private DBContext connection;

    public RefundDAO() {
        connection = new DBContext();
    }

    public boolean addRefund(Refund refund) throws Exception {
        String sql = "INSERT INTO Refund (OrderId, RefundReason, RefundAmount, RefundStatus, RefundOption) VALUES (?, ?, ?, ?. ?)";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refund.getOrderId());
            statement.setString(2, refund.getRefundReason());
            statement.setBigDecimal(3, refund.getRefundAmount());
            statement.setString(4, refund.getRefundStatus());
            statement.setInt(5, refund.getRefundOption());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getOrderIdByRefundId(int refundId) throws Exception {
        String sql = "SELECT OrderId FROM Refund WHERE RefundId = ?";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refundId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("OrderId");
                } else {
                    throw new Exception("Refund not found for the given RefundId");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error while fetching OrderId by RefundId");
        }
    }

    public int getrefundOptionByRefundId(int refundId) throws Exception {
        String sql = "SELECT RefundOption FROM Refund WHERE RefundId = ?";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refundId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("RefundOption");
                } else {
                    throw new Exception("Refund not found for the given RefundOption");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error while fetching OrderId by RefundId");
        }
    }

    public Order getOrderByRefundId(int refundId) {
        String query = "SELECT o.* FROM [Order] o JOIN Refund r ON o.OrderID = r.OrderId WHERE r.RefundId = ?";
        try (Connection con = connection.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, refundId);
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
        System.out.println("No order found for the specified RefundID");
        return null;
    }

    public boolean updateRefundStatusAndAmount(int refundId, String newStatus, String amountString) throws Exception {
        String sql = "UPDATE Refund SET RefundStatus = ?, RefundAmount = ? WHERE RefundID = ?";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setString(1, newStatus);

            BigDecimal newAmount = new BigDecimal(amountString);
            statement.setBigDecimal(2, newAmount);

            statement.setInt(3, refundId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addRefundRequest(Refund refund) throws Exception {
        String sql = "INSERT INTO Refund (OrderId, RefundReason, RefundAmount, RefundStatus, RefundReasonImg, RefundOption) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refund.getOrderId());
            statement.setString(2, refund.getRefundReason());
            statement.setBigDecimal(3, refund.getRefundAmount());
            statement.setString(4, refund.getRefundStatus());
            statement.setString(5, refund.getRefundReasonImg());
            statement.setInt(6, refund.getRefundOption());
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Refund> getRefundsByShopIdAndStatus(int shopId, String refundStatus) throws SQLException, Exception {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "       o.DeliveryStatus, "
                + "       o.PaymentStatus, "
                + "       o.isRefund "
                + "FROM Refund r "
                + "JOIN [Order] o ON r.OrderId = o.OrderID "
                + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ?"
                + "  AND r.RefundStatus = ? "
                + "  AND o.DeliveryStatus = 'COMPLETED' "
                + "  AND o.PaymentStatus LIKE 'PAID' "
                + "ORDER BY o.CreatedDate DESC;";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, shopId);
            statement.setString(2, refundStatus);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Refund refund = new Refund(
                        resultSet.getInt("RefundID"),
                        resultSet.getInt("OrderId"),
                        resultSet.getString("RefundReason"),
                        resultSet.getBigDecimal("RefundAmount"),
                        resultSet.getString("RefundStatus"),
                        resultSet.getString("RefundReasonImg"),
                        resultSet.getDate("created_at"),
                        resultSet.getInt("RefundOption")
                );
                refunds.add(refund);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return refunds;
    }

    public List<Refund> getRefundsByShopIdAndStatusAndOption(int shopId, String refundStatus, int refundOption) throws SQLException, Exception {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "       o.DeliveryStatus, "
                + "       o.PaymentStatus, "
                + "       o.isRefund "
                + "FROM Refund r "
                + "JOIN [Order] o ON r.OrderId = o.OrderID "
                + "JOIN OrderItem oi ON o.OrderID = oi.OrderID "
                + "JOIN Product p ON oi.ProductID = p.ProductID "
                + "WHERE p.ShopID = ? and r.RefundOption= ?"
                + "  AND r.RefundStatus = ? "
                + "  AND o.DeliveryStatus = 'COMPLETED' "
                + "  AND o.PaymentStatus LIKE 'PAID' "
                + "ORDER BY o.CreatedDate DESC;";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, shopId);
            statement.setString(3, refundStatus);
            statement.setInt(2, refundOption);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Refund refund = new Refund(
                        resultSet.getInt("RefundID"),
                        resultSet.getInt("OrderId"),
                        resultSet.getString("RefundReason"),
                        resultSet.getBigDecimal("RefundAmount"),
                        resultSet.getString("RefundStatus"),
                        resultSet.getString("RefundReasonImg"),
                        resultSet.getDate("created_at"),
                        resultSet.getInt("RefundOption")
                );
                refunds.add(refund);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return refunds;
    }

    public Refund getRefundById(int refundId) throws Exception {
        String sql = "SELECT * FROM Refund WHERE RefundID = ?";
        Refund refund = null;

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refundId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    refund = new Refund(
                            resultSet.getInt("RefundID"),
                            resultSet.getInt("OrderId"),
                            resultSet.getString("RefundReason"),
                            resultSet.getBigDecimal("RefundAmount"),
                            resultSet.getString("RefundStatus"),
                            resultSet.getString("RefundReasonImg"),
                            resultSet.getTimestamp("created_at"),
                            resultSet.getInt("RefundOption")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error fetching refund by ID: " + refundId, e);
        }
        return refund;
    }

    public boolean updateRefundStatus(int refundId, String newStatus) throws Exception {
        String sql = "UPDATE Refund SET RefundStatus = ? WHERE RefundID = ?";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setString(1, newStatus);
            statement.setInt(2, refundId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRefund(int refundId) throws Exception {
        String sql = "DELETE FROM Refund WHERE RefundID = ?";

        try (Connection con = connection.getConnection(); PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, refundId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
