package model;

import java.sql.Timestamp;

/**
 * PasswordResetRequest Model
 * Đại diện cho một yêu cầu reset password từ user
 * 
 * @author PRJ301
 */
public class PasswordResetRequest {
    private int requestId;
    private int userId;
    private String username;
    private String contactEmail;
    private boolean verified;
    private String status; // 'pending', 'completed'
    private Timestamp requestedAt;
    private Timestamp readAt;
    private Timestamp completedAt;

    // Constructors
    public PasswordResetRequest() {
    }

    public PasswordResetRequest(int requestId, int userId, String username, String contactEmail, 
                               boolean verified, String status, Timestamp requestedAt, 
                               Timestamp readAt, Timestamp completedAt) {
        this.requestId = requestId;
        this.userId = userId;
        this.username = username;
        this.contactEmail = contactEmail;
        this.verified = verified;
        this.status = status;
        this.requestedAt = requestedAt;
        this.readAt = readAt;
        this.completedAt = completedAt;
    }

    // Getters and Setters
    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

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

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRequestedAt() {
        return requestedAt;
    }

    public void setRequestedAt(Timestamp requestedAt) {
        this.requestedAt = requestedAt;
    }

    public Timestamp getReadAt() {
        return readAt;
    }

    public void setReadAt(Timestamp readAt) {
        this.readAt = readAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    @Override
    public String toString() {
        return "PasswordResetRequest{" +
                "requestId=" + requestId +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", verified=" + verified +
                ", status='" + status + '\'' +
                ", requestedAt=" + requestedAt +
                ", readAt=" + readAt +
                ", completedAt=" + completedAt +
                '}';
    }
}

