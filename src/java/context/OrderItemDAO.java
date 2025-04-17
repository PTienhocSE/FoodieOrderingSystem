/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import context.DBContext;
import model.OrderDTO;
import model.OrderItemDTO;
import model.Account;
import model.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.OrderItem;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class OrderItemDAO {

    private DBContext dbContext;

    public OrderItemDAO() {
        dbContext = new DBContext();
    }

    public List<OrderItem> getOrderItemByOrderID(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM OrderItem WHERE OrderID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem(
                        rs.getInt("OrderItemID"),
                        rs.getInt("OrderID"),
                        rs.getInt("ProductID"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice")
                );
                orderItems.add(item);
            }
            return orderItems;
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No items found for the order");
        return null;
    }

    public int getTotalQuantityByProductID(int productId) {
        String query = "SELECT SUM(Quantity) AS TotalQuantity FROM OrderItem WHERE ProductID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("TotalQuantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("No quantity found for the product");
        return 0;
    }
}
