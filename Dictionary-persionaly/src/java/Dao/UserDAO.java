package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 * UserDAO - Data Access Object cho bảng Users
 * Xử lý các thao tác database liên quan đến User
 * 
 * @author PRJ301
 */
public class UserDAO {
    
    private final DBContext dbContext;
    
    public UserDAO() {
        dbContext = new DBContext();
    }
    
    /**
     * Xác thực user (login)
     * @param email Email của user
     * @param password Password (plain text - sẽ hash sau)
     * @return User object nếu đăng nhập thành công, null nếu thất bại
     */
    public User authenticate(String email, String password) {
        String sql = "SELECT user_id, email, password, full_name, role, status " +
                     "FROM Users " +
                     "WHERE email = ? AND password = ? AND status = 1";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password); // TODO: Hash password trước khi so sánh
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Không nên trả về password trong production
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.authenticate: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Đóng resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return null;
    }
    
    /**
     * Lấy user theo email
     * @param email Email của user
     * @return User object hoặc null nếu không tìm thấy
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT user_id, email, full_name, role, status, created_at, updated_at " +
                     "FROM Users " +
                     "WHERE email = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.getUserByEmail: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return null;
    }
    
    /**
     * Lấy user theo ID
     * @param userId ID của user
     * @return User object hoặc null nếu không tìm thấy
     */
    public User getUserById(int userId) {
        String sql = "SELECT user_id, email, full_name, role, status, created_at, updated_at " +
                     "FROM Users " +
                     "WHERE user_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.getUserById: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return null;
    }
    
    /**
     * Đếm tổng số users
     * @return Tổng số users
     */
    public int countTotalUsers() {
        String sql = "SELECT COUNT(*) as total FROM Users";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.countTotalUsers: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return 0;
    }
    
    /**
     * Lấy tất cả users với thống kê đóng góp
     * @return Danh sách User objects
     */
    public java.util.List<model.User> getAllUsers() {
        java.util.List<model.User> users = new java.util.ArrayList<>();
        String sql = "SELECT user_id, email, password, full_name, role, status, created_at, updated_at " +
                     "FROM Users " +
                     "ORDER BY created_at DESC";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                model.User user = new model.User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                users.add(user);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.getAllUsers: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return users;
    }
}

