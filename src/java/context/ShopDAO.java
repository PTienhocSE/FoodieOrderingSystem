/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

/**
 *
 * @author LENOVO
 */
import java.sql.Time;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Shop;

public class ShopDAO {

    private DBContext dbContext;

    public ShopDAO() {
        dbContext = new DBContext();
    }

    
    
public double getShopWallet(int shopId) {
    String query = "SELECT ShopWallet FROM shop WHERE ShopID = ?";

    try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, shopId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("ShopWallet"); 
            } else {
                return 0.0; 
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        return 0.0; 
    }
}
    
    public boolean updateShopWallet(int shopId, double amount) {
        String query = "UPDATE shop SET ShopWallet = ShopWallet + ? WHERE ShopID = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, amount); 
            ps.setInt(2, shopId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createRestaurant(Shop r) {
        String query = "INSERT INTO Shop (Name, Description, Status, ShopImage, Address, TimeOpen, TimeClose) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getDescription());
            ps.setBoolean(3, r.getStatus());
            ps.setString(4, r.getShopImage());
            ps.setString(5, r.getAddress());
            ps.setTime(6, Time.valueOf(r.getTimeOpen()));
            ps.setTime(7, Time.valueOf(r.getTimeClose()));

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRestaurant(Shop r) {
        String query = "UPDATE Shop SET Name = ?, Description = ?,  Address = ?, TimeOpen = ?, TimeClose = ? WHERE ShopID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getDescription());
            ps.setString(3, r.getAddress());
            ps.setTime(4, Time.valueOf(r.getTimeOpen()));
            ps.setTime(5, Time.valueOf(r.getTimeClose()));
            ps.setInt(6, r.getShopID());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRestaurant(int shopID) {
        String query = "DELETE FROM Shop WHERE ShopID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, shopID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Shop getRestaurantByID(int shopID) {
        String query = "SELECT * FROM Shop WHERE ShopID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, shopID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Shop(
                            rs.getInt("ShopID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getBoolean("Status"),
                            rs.getString("ShopImage"),
                            rs.getString("Address"),
                            rs.getTime("TimeOpen").toLocalTime(),
                            rs.getTime("TimeClose").toLocalTime()
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all restaurants
    public List<Shop> getAllRestaurants() {
        List<Shop> restaurants = new ArrayList<>();
        String query = "SELECT * FROM Shop";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Shop restaurant = new Shop(
                        rs.getInt("ShopID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getBoolean("Status"),
                        rs.getString("ShopImage"),
                        rs.getString("Address"),
                        rs.getTime("TimeOpen").toLocalTime(),
                        rs.getTime("TimeClose").toLocalTime()
                );
                restaurants.add(restaurant);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    //PAGINATION
    public List<Shop> getShops(int page, int size) {
        List<Shop> shops = new ArrayList<>();
        int offset = (page - 1) * size;
        String query = "SELECT * FROM Shop ORDER BY ShopID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, size);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopID(rs.getInt("ShopID"));
                shop.setName(rs.getString("Name"));
                shop.setDescription(rs.getString("Description"));
                shop.setStatus(rs.getBoolean("Status"));
                shop.setShopImage(rs.getString("ShopImage"));
                shop.setAddress(rs.getString("Address"));
                shop.setTimeOpen(rs.getTime("TimeOpen").toLocalTime());
                shop.setTimeClose(rs.getTime("TimeClose").toLocalTime());

                shops.add(shop);
            }

            System.out.println("Total shops retrieved: " + shops.size()); // Kiểm tra số lượng cửa hàng
        } catch (Exception e) {
            e.printStackTrace();
        }

        return shops;
    }

    public int getTotalShops() {
        int totalShops = 0;
        String query = "SELECT COUNT(*) AS Total FROM Shop";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalShops = rs.getInt("Total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalShops;
    }

    //Search with pagination
    public List<Shop> searchShop(String keyword, int page, int size) {
        List<Shop> shops = new ArrayList<>();
        int offset = (page - 1) * size;
        String query = "SELECT * FROM Shop WHERE Name LIKE ? OR Description LIKE ? ORDER BY ShopID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setInt(3, offset);
            ps.setInt(4, size);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopID(rs.getInt("ShopID"));
                shop.setName(rs.getString("Name"));
                shop.setDescription(rs.getString("Description"));
                shop.setStatus(rs.getBoolean("Status"));
                shop.setShopImage(rs.getString("ShopImage"));
                shop.setAddress(rs.getString("Address"));
                shop.setTimeOpen(rs.getTime("TimeOpen").toLocalTime());
                shop.setTimeClose(rs.getTime("TimeClose").toLocalTime());

                shops.add(shop);
            }

            System.out.println("Total shops found for keyword '" + keyword + "': " + shops.size()); // Kiểm tra số lượng cửa hàng tìm thấy
        } catch (Exception e) {
            e.printStackTrace();
        }

        return shops;
    }

    public List<Shop> searchShop(String keyword) {
        List<Shop> shops = new ArrayList<>();
        String query = "SELECT * FROM Shop WHERE Name LIKE ? OR Description LIKE ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopID(rs.getInt("ShopID"));
                shop.setName(rs.getString("Name"));
                shop.setDescription(rs.getString("Description"));
                shop.setStatus(rs.getBoolean("Status"));
                shop.setShopImage(rs.getString("ShopImage"));
                shop.setAddress(rs.getString("Address"));
                shop.setTimeOpen(rs.getTime("TimeOpen").toLocalTime());
                shop.setTimeClose(rs.getTime("TimeClose").toLocalTime());

                shops.add(shop);
            }

            System.out.println("Total shops found: " + shops.size()); // Kiểm tra số lượng cửa hàng tìm thấy
        } catch (Exception e) {
            e.printStackTrace();
        }

        return shops;
    }

    public List<Shop> getShopsSortedByTimeOpen(int page, int size) {
        List<Shop> shops = new ArrayList<>();
        int offset = (page - 1) * size;
        String query = "SELECT * FROM Shop ORDER BY TimeOpen OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, size);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopID(rs.getInt("ShopID"));
                shop.setName(rs.getString("Name"));
                shop.setDescription(rs.getString("Description"));
                shop.setStatus(rs.getBoolean("Status"));
                shop.setShopImage(rs.getString("ShopImage"));
                shop.setAddress(rs.getString("Address"));
                shop.setTimeOpen(rs.getTime("TimeOpen").toLocalTime());
                shop.setTimeClose(rs.getTime("TimeClose").toLocalTime());

                shops.add(shop);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return shops;
    }

    public List<Shop> getShopsSortedByTimeClose(int page, int size) {
        List<Shop> shops = new ArrayList<>();
        int offset = (page - 1) * size;
        String query = "SELECT * FROM Shop ORDER BY TimeClose DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, size);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopID(rs.getInt("ShopID"));
                shop.setName(rs.getString("Name"));
                shop.setDescription(rs.getString("Description"));
                shop.setStatus(rs.getBoolean("Status"));
                shop.setShopImage(rs.getString("ShopImage"));
                shop.setAddress(rs.getString("Address"));
                shop.setTimeOpen(rs.getTime("TimeOpen").toLocalTime());
                shop.setTimeClose(rs.getTime("TimeClose").toLocalTime());

                shops.add(shop);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return shops;
    }

    public boolean createShop(Shop s) {
        String query = "INSERT INTO Shop (Name, Description, Status, ShopImage, Address, TimeOpen, TimeClose) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getDescription());
            ps.setBoolean(3, s.getStatus());
            ps.setString(4, s.getShopImage());
            ps.setString(5, s.getAddress());
            ps.setTime(6, Time.valueOf(s.getTimeOpen()));
            ps.setTime(7, Time.valueOf(s.getTimeClose()));

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Shop getShopByID(int shopID) {
        String query = "SELECT * FROM Shop WHERE ShopID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Shop shop = new Shop(
                        rs.getInt("ShopID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getBoolean("Status"),
                        rs.getString("ShopImage"),
                        rs.getString("Address"),
                        rs.getTime("TimeOpen").toLocalTime(),
                        rs.getTime("TimeClose").toLocalTime()
                );
                return shop;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Shop not found");
        return null;
    }

    public String getShopNameByID(int shopID) {
        String query = "SELECT Name FROM Shop WHERE ShopID = ?";
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, shopID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String Name = rs.getString("Name");

                return Name;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Shop not found");
        return null;
    }

    public boolean updateShopImage(int shopId, String imageUrl) {
        String query = "UPDATE Shop SET ShopImage = ? WHERE ShopID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, imageUrl);
            ps.setInt(2, shopId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int registerShop(Shop s) {
        int shopID = 0;
        String query = "INSERT INTO Shop (Name, Description, Status, ShopImage, Address, TimeOpen, TimeClose) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getDescription());
            ps.setBoolean(3, s.getStatus());
            ps.setString(4, s.getShopImage());
            ps.setString(5, s.getAddress());
            ps.setTime(6, Time.valueOf(s.getTimeOpen())); // Chuyển LocalTime thành Time
            ps.setTime(7, Time.valueOf(s.getTimeClose()));
            ps.executeUpdate();

            // lấy giá trị auto-generated keys
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    shopID = rs.getInt(1); // lấy ShopID sau khi tự động tăng
                }
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shopID;
    }

    public List<Shop> getRegisteredShopToProcess() {
        String query = "select * from Shop s \n"
                + "JOIN Users u ON s.ShopID = u.ShopID\n"
                + "WHERE u.Role = 2 AND s.Status = 0";
        List<Shop> shops = new ArrayList<>();
        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shop shop = new Shop(
                        rs.getInt("ShopID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getBoolean("Status"),
                        rs.getString("ShopImage"),
                        rs.getString("Address"),
                        rs.getTime("TimeOpen").toLocalTime(),
                        rs.getTime("TimeClose").toLocalTime()
                );
                shops.add(shop);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shops;
    }

    public boolean updateShopStatusAfterApprove(int shopID) {
        String query = "UPDATE Shop SET Status = 1 WHERE ShopID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, shopID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Admin function - getNumberOfRestaurants
    public int getNumberOfRestaurants() {
        int restaurantCount = 0;
        String sql = "SELECT COUNT(*) FROM Shop";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                restaurantCount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return restaurantCount;
    }

    // Admin function - get#ofWaitingApproveShop
    public int getNumberOfWaitingApproveRestaurants() {
        int restaurantCount = 0;
        String sql = "SELECT COUNT(ShopID) AS Waiting \n"
                + "  FROM Shop \n"
                + "  WHERE Status = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                restaurantCount = rs.getInt("Waiting");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return restaurantCount;
    }

}
