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
     * @param username Username của user
     * @param password Password (plain text - sẽ hash sau)
     * @return User object nếu đăng nhập thành công, null nếu thất bại
     */
    public User authenticate(String username, String password) {
        String sql = "SELECT user_id, username, password, full_name, role, status " +
                     "FROM Users " +
                     "WHERE username = ? AND password = ? AND status = 1";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password); // TODO: Hash password trước khi so sánh
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
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
     * Lấy user theo username
     * @param username Username của user
     * @return User object hoặc null nếu không tìm thấy
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT user_id, username, full_name, role, status, created_at, updated_at " +
                     "FROM Users " +
                     "WHERE username = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.getUserByUsername: " + e.getMessage());
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
        String sql = "SELECT user_id, username, full_name, role, status, created_at, updated_at " +
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
                user.setUsername(rs.getString("username"));
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
        String sql = "SELECT user_id, username, password, full_name, role, status, created_at, updated_at " +
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
                user.setUsername(rs.getString("username"));
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
    
    /**
     * Đăng ký user mới
     * @param username Username
     * @param password Password (plain text - sẽ hash trong code)
     * @param fullName Họ và tên
     * @return true nếu đăng ký thành công, false nếu thất bại
     */
    public boolean registerUser(String username, String password, String fullName) {
        String sql = "INSERT INTO Users (username, password, full_name, role) VALUES (?, ?, ?, 'user')";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password); // TODO: Hash password trước khi lưu
            ps.setString(3, fullName);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.registerUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
    
    /**
     * Kiểm tra username đã tồn tại chưa
     * @param username Username cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) as count FROM Users WHERE username = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.isUsernameExists: " + e.getMessage());
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
        
        return false;
    }
}

