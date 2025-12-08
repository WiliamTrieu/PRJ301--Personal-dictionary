package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.PasswordResetRequest;

/**
 * PasswordResetRequestDAO
 * Quản lý các yêu cầu reset mật khẩu
 * 
 * @author PRJ301
 */
public class PasswordResetRequestDAO {
    private final DBContext dbContext;

    public PasswordResetRequestDAO() {
        this.dbContext = new DBContext();
    }

    /**
     * Tạo request mới
     * @param userId ID của user
     * @param username Username của user
     * @param contactEmail Email liên hệ
     * @return true nếu tạo thành công
     */
    public boolean createRequest(int userId, String username, String contactEmail) {
        String sql = "INSERT INTO PasswordResetRequests (user_id, username, contact_email, verified, status) " +
                     "VALUES (?, ?, ?, 1, 'pending')";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, username);
            ps.setString(3, contactEmail);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in PasswordResetRequestDAO.createRequest: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, ps, null);
        }
    }

    /**
     * Lấy tất cả requests pending (chưa completed)
     * @return List các requests
     */
    public List<PasswordResetRequest> getPendingRequests() {
        List<PasswordResetRequest> requests = new ArrayList<>();
        String sql = "SELECT request_id, user_id, username, contact_email, verified, status, " +
                     "requested_at, read_at, completed_at " +
                     "FROM PasswordResetRequests " +
                     "WHERE status = 'pending' " +
                     "ORDER BY requested_at DESC";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                PasswordResetRequest request = mapResultSetToRequest(rs);
                requests.add(request);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in PasswordResetRequestDAO.getPendingRequests: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        
        return requests;
    }

    /**
     * Đánh dấu request là "đã đọc"
     * @param requestId ID của request
     * @return true nếu thành công
     */
    public boolean markAsRead(int requestId) {
        String sql = "UPDATE PasswordResetRequests SET read_at = GETDATE() WHERE request_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, requestId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in PasswordResetRequestDAO.markAsRead: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, ps, null);
        }
    }

    /**
     * Đánh dấu request là "completed"
     * @param requestId ID của request
     * @return true nếu thành công
     */
    public boolean markAsCompleted(int requestId) {
        String sql = "UPDATE PasswordResetRequests " +
                     "SET status = 'completed', completed_at = GETDATE() " +
                     "WHERE request_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, requestId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in PasswordResetRequestDAO.markAsCompleted: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, ps, null);
        }
    }

    /**
     * Đếm số request pending
     * @return Số lượng request chưa xử lý
     */
    public int countPendingRequests() {
        String sql = "SELECT COUNT(*) as count FROM PasswordResetRequests WHERE status = 'pending'";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
            
        } catch (SQLException e) {
            System.err.println("Error in PasswordResetRequestDAO.countPendingRequests: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        
        return 0;
    }

    /**
     * Map ResultSet to PasswordResetRequest object
     */
    private PasswordResetRequest mapResultSetToRequest(ResultSet rs) throws SQLException {
        PasswordResetRequest request = new PasswordResetRequest();
        request.setRequestId(rs.getInt("request_id"));
        request.setUserId(rs.getInt("user_id"));
        request.setUsername(rs.getString("username"));
        request.setContactEmail(rs.getString("contact_email"));
        request.setVerified(rs.getBoolean("verified"));
        request.setStatus(rs.getString("status"));
        request.setRequestedAt(rs.getTimestamp("requested_at"));
        request.setReadAt(rs.getTimestamp("read_at"));
        request.setCompletedAt(rs.getTimestamp("completed_at"));
        return request;
    }

    /**
     * Close database resources
     */
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.err.println("Error closing resources: " + e.getMessage());
        }
    }
}

