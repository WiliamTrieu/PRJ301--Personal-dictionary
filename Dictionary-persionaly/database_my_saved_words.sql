-- =====================================================
-- MY SAVED WORDS FEATURE
-- Create UserSavedWords table
-- Date: December 8, 2025
-- =====================================================

USE Spring1;
GO

-- =====================================================
-- TABLE: UserSavedWords
-- Mỗi user có bộ từ riêng
-- =====================================================

IF OBJECT_ID('UserSavedWords', 'U') IS NOT NULL
BEGIN
    PRINT 'Dropping existing UserSavedWords table...';
    DROP TABLE UserSavedWords;
END
GO

CREATE TABLE UserSavedWords (
    saved_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    word_id INT NOT NULL,
    personal_note NVARCHAR(500),          -- Ghi chú riêng của user
    mastery_level INT DEFAULT 0,           -- 0-5: Mức độ thành thạo
    times_reviewed INT DEFAULT 0,          -- Số lần ôn tập
    last_reviewed DATETIME,                -- Lần ôn cuối
    saved_at DATETIME DEFAULT GETDATE(),   -- Thời điểm lưu
    
    -- Foreign Keys
    CONSTRAINT FK_UserSavedWords_User FOREIGN KEY (user_id) 
        REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT FK_UserSavedWords_Word FOREIGN KEY (word_id) 
        REFERENCES Dictionary(word_id) ON DELETE CASCADE,
    
    -- Unique: 1 user không save trùng từ
    CONSTRAINT UQ_UserSavedWords_UserWord UNIQUE (user_id, word_id)
);
GO

-- Index cho performance
CREATE INDEX IX_UserSavedWords_UserId ON UserSavedWords(user_id);
CREATE INDEX IX_UserSavedWords_WordId ON UserSavedWords(word_id);
CREATE INDEX IX_UserSavedWords_SavedAt ON UserSavedWords(saved_at DESC);
GO

PRINT '✅ UserSavedWords table created successfully!';
PRINT '';
PRINT 'Features:';
PRINT '  - Each user has their own saved words collection';
PRINT '  - Personal notes for each word';
PRINT '  - Mastery level tracking (0-5)';
PRINT '  - Review statistics';
PRINT '  - Cannot save same word twice';
GO

-- =====================================================
-- SAMPLE DATA (Optional - for testing)
-- =====================================================

-- Note: Sample data commented out
-- Run this AFTER you have words in Dictionary table
-- Replace word_id with actual IDs from your Dictionary

/*
-- Example: User 2 saves some words
INSERT INTO UserSavedWords (user_id, word_id, personal_note, mastery_level)
VALUES 
    (2, 1, N'Từ đầu tiên tôi học!', 2),
    (2, 2, N'Dùng trong lập trình', 3);
GO
*/

PRINT '✅ Table created successfully (sample data skipped)!';
GO

