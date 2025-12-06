package model;

import java.sql.Timestamp;

/**
 * UserWithStats - DTO chứa thông tin User kèm thống kê đóng góp
 * 
 * @author PRJ301
 */
public class UserWithStats {
    private User user;
    private int contributionCount; // Số từ đã đóng góp
    
    public UserWithStats() {
    }
    
    public UserWithStats(User user, int contributionCount) {
        this.user = user;
        this.contributionCount = contributionCount;
    }
    
    // Getters and Setters
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public int getContributionCount() {
        return contributionCount;
    }
    
    public void setContributionCount(int contributionCount) {
        this.contributionCount = contributionCount;
    }
    
    // Helper methods để dễ truy cập
    public int getUserId() {
        return user != null ? user.getUserId() : 0;
    }
    
    public String getEmail() {
        return user != null ? user.getEmail() : "";
    }
    
    public String getFullName() {
        return user != null ? user.getFullName() : "";
    }
    
    public String getRole() {
        return user != null ? user.getRole() : "";
    }
    
    public boolean isStatus() {
        return user != null && user.isStatus();
    }
    
    public Timestamp getCreatedAt() {
        return user != null ? user.getCreatedAt() : null;
    }
}

