/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import model.Product;

import java.sql.Time;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Shop;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductDAO {

    private DBContext dbContext;

    public ProductDAO() {
        dbContext = new DBContext();
    }

    public boolean checkConnection() throws Exception {
        try (Connection conn = dbContext.getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Connection failed
        }
    }

    public boolean createProduct(Product p) {
        String query = "INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, Rating) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setBoolean(4, p.isStatus());
            ps.setInt(5, p.getShopId());
            ps.setInt(6, p.getCategoryId());
            ps.setDouble(7, p.getRating());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product Where Status LIKE 1";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getBoolean("Status"),
                        rs.getInt("ShopID"),
                        rs.getInt("CategoryID"),
                        rs.getInt("PurchaseCount"),
                        rs.getDouble("Rating")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductByID(int productID) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE ProductID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getBoolean("Status"),
                            rs.getInt("ShopID"),
                            rs.getInt("CategoryID"),
                            rs.getInt("PurchaseCount"),
                            rs.getDouble("Rating")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public String getCategoryNameByID(int categoryID) {
        String categoryName = null;
        String query = "SELECT Type FROM Categories WHERE CategoryID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, categoryID); // Đặt giá trị CategoryID vào câu truy vấn
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    categoryName = rs.getString("Type");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryName;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE Name LIKE ? AND status LIKE '1'";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStatus(rs.getBoolean("Status"));
                product.setShopId(rs.getInt("ShopID"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setPurchaseCount(rs.getInt("PurchaseCount"));
                product.setRating(rs.getDouble("Rating"));

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> filterProducts(List<Integer> categoryIDs, double minRating, String sortBy) {
        List<Product> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Product WHERE 1=1 AND Status LIKE 1");

        // Lọc theo danh mục nếu có danh sách categoryIDs
        if (categoryIDs != null && !categoryIDs.isEmpty()) {
            if (categoryIDs.contains(0)) {
            } else {
                query.append(" AND CategoryID IN (");
                for (int i = 0; i < categoryIDs.size(); i++) {
                    query.append("?");
                    if (i < categoryIDs.size() - 1) {
                        query.append(",");
                    }
                }
                query.append(")");
            }
        }

        // Lọc theo đánh giá nếu minRating > 0
        if (minRating > 0) {
            query.append(" AND Rating >= ?");
        }

        // Sắp xếp theo tiêu chí nếu sortBy không phải là null và không phải là "none"
        if (sortBy != null && !"none".equals(sortBy)) {
            switch (sortBy) {
                case "popularity":
                    query.append(" ORDER BY PurchaseCount DESC");
                    break;
                case "rating":
                    query.append(" ORDER BY Rating DESC");
                    break;
                case "price":
                    query.append(" ORDER BY Price ASC");
                    break;
                default:
                    break; // Nếu không có tiêu chí sắp xếp nào, sẽ không thêm ORDER BY
            }
        }

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;

            // Gán các giá trị cho câu query
            if (categoryIDs != null && !categoryIDs.isEmpty()) {
                for (Integer categoryID : categoryIDs) {
                    ps.setInt(paramIndex++, categoryID);
                }
            }

            // Gán giá trị cho minRating nếu > 0
            if (minRating > 0) {
                ps.setDouble(paramIndex++, minRating);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStatus(rs.getBoolean("Status"));
                product.setShopId(rs.getInt("ShopID"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setPurchaseCount(rs.getInt("PurchaseCount"));
                product.setRating(rs.getDouble("Rating"));

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> filterProducts(List<Integer> categoryIDs, double minRating, String sortBy, int page, int size) {
        List<Product> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM Product WHERE 1=1 AND Status LIKE 1");

        if (categoryIDs != null && !categoryIDs.isEmpty()) {
            if (!categoryIDs.contains(0)) {
                query.append(" AND CategoryID IN (");
                for (int i = 0; i < categoryIDs.size(); i++) {
                    query.append("?");
                    if (i < categoryIDs.size() - 1) {
                        query.append(", ");
                    }
                }
                query.append(")");
            }
        }

        if (minRating > 0) {
            query.append(" AND Rating >= ?");
        }

        if (sortBy != null && !"none".equals(sortBy)) {
            switch (sortBy) {
                case "popularity":
                    query.append(" ORDER BY PurchaseCount DESC");
                    break;
                case "rating":
                    query.append(" ORDER BY Rating DESC");
                    break;
                case "price":
                    query.append(" ORDER BY Price ASC");
                    break;
                default:
                    break;
            }
        } else {
            query.append(" ORDER BY ProductID");
        }

        query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;

            if (categoryIDs != null && !categoryIDs.isEmpty()) {
                for (Integer categoryID : categoryIDs) {
                    ps.setInt(paramIndex++, categoryID);
                }
            }

            if (minRating > 0) {
                ps.setDouble(paramIndex++, minRating);
            }

            int offset = (page - 1) * size;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, size);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStatus(rs.getBoolean("Status"));
                product.setShopId(rs.getInt("ShopID"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setPurchaseCount(rs.getInt("PurchaseCount"));
                product.setRating(rs.getDouble("Rating"));

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    //PAGINATION
    public List<Product> getProducts(int page, int size) {
        List<Product> products = new ArrayList<>();
        int offset = (page - 1) * size; // Tính toán offset
        String query = "SELECT * FROM Product Where Status LIKE 1 ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, size);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStatus(rs.getBoolean("Status"));
                product.setShopId(rs.getInt("ShopID"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setPurchaseCount(rs.getInt("PurchaseCount"));
                product.setRating(rs.getDouble("Rating"));

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Lấy tổng số sản phẩm
    public int getTotalProducts() {
        int total = 0;
        String query = "SELECT COUNT(*) FROM Product Where Status LIKE 1";

        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public int createProductGetID(Product p) {
        String query = "INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, Rating) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setBoolean(4, p.isStatus());
            ps.setInt(5, p.getShopId());
            ps.setInt(6, p.getCategoryId());
            ps.setDouble(7, p.getRating());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);  // Trả về ProductID tự động tạo
                    }
                }
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public boolean updateProduct(Product product) throws Exception {
        String query = "UPDATE Product SET Name = ?, Description = ?, Price = ?, Status = ?, ShopID = ?, CategoryID = ?  WHERE ProductID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setBoolean(4, product.isStatus());
            ps.setInt(5, product.getShopId());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getProductId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error updating product: " + e.getMessage());
        }
    }

    // DELETE: Delete a product by ID
    public boolean deleteProduct(int productId) throws Exception {
        String query = "UPDATE Product SET status = 0 WHERE ProductID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error updating product status: " + e.getMessage());
        }
    }

    public List<Product> getProductByShopID(int shopID) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE ShopID = ? AND Status LIKE 1";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, shopID);
            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getBoolean("Status"),
                            rs.getInt("ShopID"),
                            rs.getInt("CategoryID"),
                            rs.getInt("PurchaseCount"),
                            rs.getDouble("Rating")
                    );
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductByShopIDInPage(int shopID, int page, int size) {
        List<Product> products = new ArrayList<>();
        int offset = (page - 1) * size; // Tính toán offset
        String query = "SELECT * FROM Product WHERE ShopID = ? AND Status LIKE 1 ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(2, offset);
            ps.setInt(3, size);
//            ResultSet rs = ps.executeQuery();
//        String query = "SELECT * FROM Product WHERE ShopID = ?";
//        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, shopID);
            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getBoolean("Status"),
                            rs.getInt("ShopID"),
                            rs.getInt("CategoryID"),
                            rs.getInt("PurchaseCount"),
                            rs.getDouble("Rating")
                    );
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductByCategoryID(int categoryID) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE CategoryID = ? AND Status LIKE 1";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, categoryID);
            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getBoolean("Status"),
                            rs.getInt("ShopID"),
                            rs.getInt("CategoryID"),
                            rs.getInt("PurchaseCount"),
                            rs.getDouble("Rating")
                    );
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // lấy cả product có status bằng 0
    public List<Product> getAllProductsFromInventory() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ProductID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getBoolean("Status"),
                        rs.getInt("ShopID"),
                        rs.getInt("CategoryID"),
                        rs.getInt("PurchaseCount"),
                        rs.getDouble("Rating")
                );
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Qhuy delete Illegal Product
    public boolean lockIllegalProduct(int productID) {
        boolean flag = false;
        String sql = "UPDATE Product \n"
                + "SET Status = 0\n"
                + "WHERE ProductID= ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            int rowsAffected = ps.executeUpdate();  // Lấy số dòng bị ảnh hưởng
            if (rowsAffected > 0) {
                flag = true;  // Nếu có dòng bị cập nhật, đánh dấu flag thành true
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    // Unlock Product
    public boolean unlockProduct(int productID) {
        boolean flag = false;
        String sql = "UPDATE Product \n"
                + "SET Status = 1\n"
                + "WHERE ProductID= ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                flag = true;
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    // Admin function - getNumberOfProduct
    public int getNumberOfProducts() {
        int foodCount = 0;
        String sql = "SELECT COUNT(*) FROM Product";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                foodCount = resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return foodCount;
    }

    // Admin function - getNumberOfLockedProduct
    public int getNumberOfLockedProducts(){
        int foodCount = 0;
        String sql = " SELECT COUNT(ProductID) AS NumberOfLockedProduct FROM Product WHERE Status = 0";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                foodCount = resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return foodCount;
    }
    
}
