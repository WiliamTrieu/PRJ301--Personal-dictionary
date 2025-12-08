-- =====================================================
-- DATABASE MIGRATION: Security Code & Password Reset
-- Date: December 8, 2025
-- Description: Add security_code_hash to Users table
--              and create PasswordResetRequests table
-- =====================================================

USE PersonalDictionary;
GO

-- Step 1: Add security_code_hash column to Users table
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Users' 
    AND COLUMN_NAME = 'security_code_hash'
)
BEGIN
    ALTER TABLE Users
    ADD security_code_hash VARCHAR(255) NULL;
    
    PRINT '✅ Added security_code_hash column to Users table';
END
ELSE
BEGIN
    PRINT 'ℹ️ security_code_hash column already exists in Users table';
END
GO

-- Step 2: Create PasswordResetRequests table
-- =====================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PasswordResetRequests')
BEGIN
    CREATE TABLE PasswordResetRequests (
        request_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        username NVARCHAR(50) NOT NULL,
        contact_email NVARCHAR(255) NOT NULL,
        verified BIT DEFAULT 1,
        status NVARCHAR(20) DEFAULT 'pending', -- 'pending', 'completed'
        requested_at DATETIME DEFAULT GETDATE(),
        read_at DATETIME NULL,
        completed_at DATETIME NULL,
        
        CONSTRAINT FK_PasswordResetRequests_Users 
            FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
        
        CONSTRAINT CK_PasswordResetRequests_Status 
            CHECK (status IN ('pending', 'completed'))
    );
    
    -- Create indexes for better performance
    CREATE INDEX IDX_PasswordResetRequests_Status 
        ON PasswordResetRequests(status);
    
    CREATE INDEX IDX_PasswordResetRequests_UserId 
        ON PasswordResetRequests(user_id);
    
    PRINT '✅ Created PasswordResetRequests table with indexes';
END
ELSE
BEGIN
    PRINT 'ℹ️ PasswordResetRequests table already exists';
END
GO

-- Step 3: Verification
-- =====================================================
PRINT '';
PRINT '========================================';
PRINT 'MIGRATION SUMMARY';
PRINT '========================================';

-- Check Users table structure
IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Users' 
    AND COLUMN_NAME = 'security_code_hash'
)
BEGIN
    PRINT '✅ Users.security_code_hash: OK';
END

-- Check PasswordResetRequests table
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PasswordResetRequests')
BEGIN
    PRINT '✅ PasswordResetRequests table: OK';
    
    -- Show table structure
    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        CHARACTER_MAXIMUM_LENGTH,
        IS_NULLABLE,
        COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'PasswordResetRequests'
    ORDER BY ORDINAL_POSITION;
END

PRINT '========================================';
PRINT '✅ Migration completed successfully!';
PRINT '========================================';
GO

-- =====================================================
-- OPTIONAL: Sample test data (for development only)
-- =====================================================
-- Uncomment below to insert test data
/*
-- Insert sample security code hash for existing user (example: user 'test' with security code 'test123456')
-- Hash of 'test123456' with SHA-256 (lowercase, trimmed)
UPDATE Users 
SET security_code_hash = '9f735e0df9a1ddc702bf0a1a7b83033f9f7153a00c29de82cedadc9957289b05'
WHERE username = 'test' AND security_code_hash IS NULL;

-- Insert sample password reset request
INSERT INTO PasswordResetRequests (user_id, username, contact_email, verified, status)
SELECT TOP 1 
    user_id, 
    username, 
    'test@example.com',
    1,
    'pending'
FROM Users 
WHERE role = 'user';

PRINT 'ℹ️ Sample test data inserted';
*/
GO

