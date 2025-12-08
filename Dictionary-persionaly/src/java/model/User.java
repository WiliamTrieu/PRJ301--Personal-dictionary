package model;

import java.sql.Timestamp;

/**
 * User Model - Đại diện cho bảng Users trong database
 * 
 * @author PRJ301
 */
public class User {
    private int userId;
    private String username;  // Thay email bằng username
    private String password;
    private String fullName;
    private String role; // "admin" hoặc "user"
    private boolean status; // true: active, false: inactive
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public User() {
    }
    
    public User(int userId, String username, String password, String fullName, 
                String role, boolean status, Timestamp createdAt, Timestamp updatedAt) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Constructor cho login (không cần tất cả fields)
    public User(int userId, String username, String fullName, String role, boolean status) {
        this.userId = userId;
        this.username = username;
        this.fullName = fullName;
        this.role = role;
        this.status = status;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public boolean isStatus() {
        return status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Helper methods
    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.role);
    }
    
    public boolean isUser() {
        return "user".equalsIgnoreCase(this.role);
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role='" + role + '\'' +
                ", status=" + status +
                '}';
    }
}

