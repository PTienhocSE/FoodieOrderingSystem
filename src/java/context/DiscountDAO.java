package context;

import model.Discount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {

    private DBContext dbContext;

    public DiscountDAO() {
        dbContext = new DBContext();
    }

    public void createDiscount(Discount discount) {
        String sql = "INSERT INTO Discount (UserID, DiscountCODE, NumberOfDiscount, TotalUse, DiscountPercentage, ShopID, MinimumAmount, MaximumAmount) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, discount.getUserID());
            ps.setString(2, discount.getDiscountCODE());
            ps.setInt(3, discount.getNumberOfDiscount());
            ps.setInt(4, discount.getTotalUse());
            ps.setDouble(5, discount.getDiscountPercentage());
            ps.setInt(6, discount.getShopID());
            ps.setDouble(7, discount.getMinimumAmount());
            ps.setDouble(8, discount.getMaximumAmount());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
    }

    public List<Discount> getAllDiscounts() {
        List<Discount> discounts = new ArrayList<>();
        String sql = "SELECT * FROM Discount";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountID(rs.getInt("DiscountID"));
                discount.setUserID(rs.getInt("UserID"));
                discount.setDiscountCODE(rs.getString("DiscountCODE"));
                discount.setNumberOfDiscount(rs.getInt("NumberOfDiscount"));
                discount.setTotalUse(rs.getInt("TotalUse"));
                discount.setDiscountPercentage(rs.getDouble("DiscountPercentage"));
                discount.setShopID(rs.getInt("ShopID"));
                discount.setStatus(rs.getInt("Status"));
                discount.setMinimumAmount(rs.getDouble("MinimumAmount"));
                discount.setMaximumAmount(rs.getDouble("MaximumAmount"));
                discounts.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return discounts;
    }

    public List<Discount> getAllDiscountsByShopID(int shopID) {
        List<Discount> discounts = new ArrayList<>();
        String sql = "SELECT * FROM Discount WHERE ShopID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, shopID);  // Set the ShopID parameter
            rs = ps.executeQuery();

            while (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountID(rs.getInt("DiscountID"));
                discount.setUserID(rs.getInt("UserID"));
                discount.setDiscountCODE(rs.getString("DiscountCODE"));
                discount.setNumberOfDiscount(rs.getInt("NumberOfDiscount"));
                discount.setTotalUse(rs.getInt("TotalUse"));
                discount.setDiscountPercentage(rs.getDouble("DiscountPercentage"));
                discount.setShopID(rs.getInt("ShopID"));
                discount.setStatus(rs.getInt("Status"));
                discount.setMinimumAmount(rs.getDouble("MinimumAmount"));
                discount.setMaximumAmount(rs.getDouble("MaximumAmount"));
                discounts.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return discounts;
    }

    public Double getMinimumAmountByDiscountCode(String discountCode) {
        String sql = "SELECT MinimumAmount FROM Discount WHERE DiscountCODE = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Double minimumAmount = null;

        try {
            conn = dbContext.getConnection(); 
            ps = conn.prepareStatement(sql);  
            ps.setString(1, discountCode);   

            rs = ps.executeQuery();          

            if (rs.next()) {
                minimumAmount = rs.getDouble("MinimumAmount");  
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn); 
        }
        return minimumAmount;  
    }

    public Double getMaximumDiscountByDiscountCode(String discountCode) {
        String sql = "SELECT MaximumAmount FROM Discount WHERE DiscountCODE = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Double maximumAmount = null;

        try {
            conn = dbContext.getConnection(); 
            ps = conn.prepareStatement(sql);  
            ps.setString(1, discountCode);   

            rs = ps.executeQuery();          

            if (rs.next()) {
                maximumAmount = rs.getDouble("MaximumAmount");  
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);  
        }
        return maximumAmount;  
    }

    public Double getDiscountPercentageByDiscountCode(String discountCode) {
        Double discountPercentage = null;
        String sql = "SELECT DiscountPercentage FROM Discount WHERE DiscountCODE = ? AND Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, discountCode);  // Set the Discount Code parameter
            rs = ps.executeQuery();

            if (rs.next()) {
                discountPercentage = rs.getDouble("DiscountPercentage");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return discountPercentage;
    }

    public Discount getDiscountDetailsByDiscountCode(String discountCode) {
        Discount discount = null;
        String sql = "SELECT DiscountID, UserID, DiscountCODE, NumberOfDiscount, TotalUse, DiscountPercentage, ShopID, Status, MinimumAmount, MaximumAmount "
                + "FROM Discount WHERE DiscountCODE = ? AND Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, discountCode);
            rs = ps.executeQuery();

            if (rs.next()) {
                discount = new Discount();
                discount.setDiscountID(rs.getInt("DiscountID"));
                discount.setUserID(rs.getInt("UserID"));
                discount.setDiscountCODE(rs.getString("DiscountCODE"));
                discount.setNumberOfDiscount(rs.getInt("NumberOfDiscount"));
                discount.setTotalUse(rs.getInt("TotalUse"));
                discount.setDiscountPercentage(rs.getDouble("DiscountPercentage"));
                discount.setShopID(rs.getInt("ShopID"));
                discount.setStatus(rs.getInt("Status"));
                discount.setMinimumAmount(rs.getDouble("MinimumAmount"));
                discount.setMaximumAmount(rs.getDouble("MaximumAmount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }

        return discount;
    }

    public int getUserIdByDiscountCode(String DiscountCODE) {
        int UserID = 0;
        String sql = "SELECT UserID FROM Discount WHERE DiscountCODE = ? AND Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, DiscountCODE);
            rs = ps.executeQuery();

            if (rs.next()) {
                UserID = rs.getInt("UserID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return UserID;
    }

    public void deleteDiscount(int discountID) throws Exception {
        String sql = "UPDATE Discount Set Status=0 WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = dbContext.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, discountID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error deleting discount: " + e.getMessage());
        } finally {
            dbContext.closeConnection(conn);
        }
    }

    public void updateDiscount(Discount discount) throws Exception {
        String sql = "UPDATE Discount SET NumberOfDiscount = ?, DiscountPercentage = ? WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, discount.getNumberOfDiscount());
            ps.setDouble(2, discount.getDiscountPercentage());
            ps.setInt(3, discount.getDiscountID()); // Ensure you use the correct discount ID

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error updating discount: " + e.getMessage());
        } finally {
            dbContext.closeConnection(conn);
        }
    }

    public void updateTotalUse(int discountID, int newTotalUse) throws Exception {
        String sql = "UPDATE Discount SET TotalUse = ? WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, newTotalUse);
            ps.setInt(2, discountID);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error updating total use for discount ID " + discountID + ": " + e.getMessage());
        } finally {
            dbContext.closeConnection(conn);
        }
    }

    public int getDiscountIDByCode(String discountCode) throws Exception {
        int discountID = -1;
        String sql = "SELECT DiscountID FROM Discount WHERE DiscountCODE = ? AND Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, discountCode);
            rs = ps.executeQuery();

            if (rs.next()) {
                discountID = rs.getInt("DiscountID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return discountID;
    }

    public int getCurrentTotalUse(int discountID) throws Exception {
        int totalUse = 0;
        String sql = "SELECT TotalUse FROM Discount WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, discountID);
            rs = ps.executeQuery();

            if (rs.next()) {
                totalUse = rs.getInt("TotalUse");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return totalUse;
    }

    public int getNumberOfDiscount(int discountID) throws Exception {
        int numberOfDiscount = 0;
        String sql = "SELECT NumberOfDiscount FROM Discount WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, discountID);
            rs = ps.executeQuery();

            if (rs.next()) {
                numberOfDiscount = rs.getInt("NumberOfDiscount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return numberOfDiscount;
    }

    public void unlockDiscount(int discountID) throws Exception {
        String sql = "UPDATE Discount SET Status = 1 WHERE DiscountID = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, discountID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error unlocking discount: " + e.getMessage());
        } finally {
            dbContext.closeConnection(conn);
        }
    }

    public String getLatestDiscountCodeByUserID(int userID) {
        String discountCode = null;
        String sql = "SELECT DiscountCODE FROM Discount WHERE UserID = ? AND Status = 1 ORDER BY created_at DESC LIMIT 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);  // Set the UserID parameter
            rs = ps.executeQuery();

            if (rs.next()) {
                discountCode = rs.getString("DiscountCODE");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbContext.closeConnection(conn);
        }
        return discountCode;
    }

}
