/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import model.WithdrawalRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author phuct
 */
public class WithdrawRequestDAO {

    private DBContext dbContext;

    public WithdrawRequestDAO() {
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

    public boolean addWithdrawalRequest(WithdrawalRequest request) throws Exception {
        String query = "INSERT INTO withdrawal_requests (shop_id, requested_amount, request_date, status, bank_account, bank_name) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, request.getShopId());
            ps.setDouble(2, request.getRequestedAmount());
            ps.setTimestamp(3, new Timestamp(request.getRequestDate().getTime()));
            ps.setString(4, request.getStatus());
            ps.setString(5, request.getBankAccount());
            ps.setString(6, request.getBankName());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<WithdrawalRequest> getAllWithdrawalRequests() throws Exception {
        List<WithdrawalRequest> requests = new ArrayList<>();
        String query = "SELECT * FROM withdrawal_requests";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                WithdrawalRequest request = new WithdrawalRequest(
                        rs.getInt("id"),
                        rs.getInt("shop_id"),
                        rs.getDouble("requested_amount"),
                        rs.getTimestamp("request_date"),
                        rs.getString("status"),
                        rs.getString("bank_account"),
                        rs.getString("bank_name")
                );
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public void updateRequestStatus(int id, String status) throws SQLException, Exception {
        String query = "UPDATE withdrawal_requests SET status = ? WHERE id = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public WithdrawalRequest getWithdrawalRequestById(int id) throws Exception {
        WithdrawalRequest request = null;
        String query = "SELECT * FROM withdrawal_requests WHERE id = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    request = new WithdrawalRequest(
                            rs.getInt("id"),
                            rs.getInt("shop_id"),
                            rs.getDouble("requested_amount"),
                            rs.getTimestamp("request_date"),
                            rs.getString("status"),
                            rs.getString("bank_account"),
                            rs.getString("bank_name")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return request;
    }

    public boolean updateWithdrawalRequestStatus(int id, String status) throws Exception {
        String query = "UPDATE withdrawal_requests SET status = ? WHERE id = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteWithdrawalRequest(int id) throws Exception {
        String query = "DELETE FROM withdrawal_requests WHERE id = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
