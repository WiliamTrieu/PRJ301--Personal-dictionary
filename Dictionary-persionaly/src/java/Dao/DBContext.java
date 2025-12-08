package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBContext - Quản lý kết nối database
 * Kết nối đến SQL Server database PersonalDictionary
 * 
 * @author PRJ301
 */
public class DBContext {
    
    // Thông tin kết nối database
    private static final String SERVER_NAME = "localhost";
    private static final String DATABASE_NAME = "Spring1";
    private static final String PORT = "1433"; // Port mặc định của SQL Server
    private static final String USERNAME = "sa"; // Thay bằng username của bạn
    private static final String PASSWORD = "123"; // Thay bằng password của bạn
    
    // Connection String cho SQL Server
    private static final String CONNECTION_URL = 
        "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + 
        ";databaseName=" + DATABASE_NAME + 
        ";encrypt=true;trustServerCertificate=true;";
    
    /**
     * Lấy kết nối đến database
     * @return Connection object
     * @throws SQLException nếu không kết nối được
     */
    public Connection getConnection() throws SQLException {
        try {
            // Load JDBC Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Tạo connection
            Connection conn = DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
            return conn;
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found: " + e.getMessage());
        }
    }
    
    /**
     * Test kết nối (dùng để kiểm tra)
     * Chạy method main này để test connection
     */
    public static void main(String[] args) {
        DBContext db = new DBContext();
        try {
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("✅ Kết nối database thành công!");
                System.out.println("Database: " + DATABASE_NAME);
                System.out.println("Server: " + SERVER_NAME);
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

