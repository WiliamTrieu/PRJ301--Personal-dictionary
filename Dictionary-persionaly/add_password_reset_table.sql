-- =============================================
-- PASSWORD RESET TOKENS TABLE
-- MÔ TẢ: Bảng lưu trữ tokens để reset password
-- Tác giả: PRJ301 Project
-- Ngày tạo: 2025
-- =============================================

USE Spring;
GO

-- Tạo bảng PasswordResetTokens
IF OBJECT_ID('PasswordResetTokens', 'U') IS NOT NULL
    DROP TABLE PasswordResetTokens;
GO

CREATE TABLE PasswordResetTokens (
    token_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    token NVARCHAR(255) UNIQUE NOT NULL,
    expires_at DATETIME NOT NULL,
    used BIT DEFAULT 0, -- 0: chưa dùng, 1: đã dùng
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
GO

-- Index cho token (tăng tốc tìm kiếm)
CREATE INDEX IX_PasswordResetTokens_Token ON PasswordResetTokens(token);
GO

-- Index cho user_id
CREATE INDEX IX_PasswordResetTokens_UserId ON PasswordResetTokens(user_id);
GO

-- Index cho expires_at (để cleanup nhanh hơn)
CREATE INDEX IX_PasswordResetTokens_ExpiresAt ON PasswordResetTokens(expires_at);
GO

-- Stored Procedure: Cleanup expired tokens (có thể chạy định kỳ)
IF OBJECT_ID('sp_CleanupExpiredTokens', 'P') IS NOT NULL
    DROP PROCEDURE sp_CleanupExpiredTokens;
GO

CREATE PROCEDURE sp_CleanupExpiredTokens
AS
BEGIN
    -- Xóa các token đã hết hạn hoặc đã được sử dụng (cũ hơn 24 giờ)
    DELETE FROM PasswordResetTokens 
    WHERE expires_at < GETDATE() 
       OR (used = 1 AND created_at < DATEADD(HOUR, -24, GETDATE()));
    
    SELECT @@ROWCOUNT AS DeletedRows;
END;
GO

PRINT 'PasswordResetTokens table created successfully!';
GO
