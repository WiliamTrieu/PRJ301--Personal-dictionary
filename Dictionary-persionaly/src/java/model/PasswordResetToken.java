package model;

import java.sql.Timestamp;

/**
 * PasswordResetToken Model - Đại diện cho bảng PasswordResetTokens
 * 
 * @author PRJ301
 */
public class PasswordResetToken {
    private int tokenId;
    private int userId;
    private String token;
    private Timestamp expiresAt;
    private boolean used;
    private Timestamp createdAt;
    
    // Constructors
    public PasswordResetToken() {
    }
    
    public PasswordResetToken(int userId, String token, Timestamp expiresAt) {
        this.userId = userId;
        this.token = token;
        this.expiresAt = expiresAt;
        this.used = false;
    }
    
    public PasswordResetToken(int tokenId, int userId, String token, 
                              Timestamp expiresAt, boolean used, Timestamp createdAt) {
        this.tokenId = tokenId;
        this.userId = userId;
        this.token = token;
        this.expiresAt = expiresAt;
        this.used = used;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getTokenId() {
        return tokenId;
    }
    
    public void setTokenId(int tokenId) {
        this.tokenId = tokenId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public Timestamp getExpiresAt() {
        return expiresAt;
    }
    
    public void setExpiresAt(Timestamp expiresAt) {
        this.expiresAt = expiresAt;
    }
    
    public boolean isUsed() {
        return used;
    }
    
    public void setUsed(boolean used) {
        this.used = used;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    // Helper methods
    public boolean isValid() {
        return !used && expiresAt != null && expiresAt.getTime() > System.currentTimeMillis();
    }
    
    public boolean isExpired() {
        return expiresAt != null && expiresAt.getTime() <= System.currentTimeMillis();
    }
    
    @Override
    public String toString() {
        return "PasswordResetToken{" +
                "tokenId=" + tokenId +
                ", userId=" + userId +
                ", token='" + token + '\'' +
                ", expiresAt=" + expiresAt +
                ", used=" + used +
                ", createdAt=" + createdAt +
                '}';
    }
}

