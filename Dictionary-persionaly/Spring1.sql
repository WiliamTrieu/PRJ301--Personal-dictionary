-- =============================================
-- DATABASE: Spring1 (Personal Dictionary)
-- MÔ TẢ: Database cho ứng dụng Từ điển Cá nhân
-- VERSION: 2.0 (Không có Email)
-- Tác giả: PRJ301 Project
-- Ngày tạo: December 2025
-- Encoding: UTF-8 (Unicode)
-- =============================================

-- Tạo Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Spring1')
BEGIN
    CREATE DATABASE Spring1;
    PRINT N'✓ Database Spring1 đã được tạo';
END
ELSE
BEGIN
    PRINT N'✓ Database Spring1 đã tồn tại';
END
GO

USE Spring1;
GO

-- =============================================
-- BẢNG 1: Users (Người dùng)
-- Không có Email - Chỉ: username, password, full_name
-- =============================================
IF OBJECT_ID('Users', 'U') IS NOT NULL
BEGIN
    DROP TABLE Users;
    PRINT N'✓ Đã xóa bảng Users cũ';
END
GO

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) UNIQUE NOT NULL,           -- Tên đăng nhập (unique)
    password NVARCHAR(255) NOT NULL,                 -- Mật khẩu (sẽ hash trong code)
    full_name NVARCHAR(100) NOT NULL,                -- Họ và tên
    role NVARCHAR(20) DEFAULT 'user' CHECK (role IN ('admin', 'user')),
    status BIT DEFAULT 1,                            -- 1: active, 0: inactive
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME
);
GO

-- Index cho username (tăng tốc login)
CREATE INDEX IX_Users_Username ON Users(username);
GO

PRINT N'✓ Bảng Users đã được tạo (username, password, full_name)';
GO

-- =============================================
-- BẢNG 2: Dictionary (Từ điển chính)
-- =============================================
IF OBJECT_ID('Dictionary', 'U') IS NOT NULL
BEGIN
    DROP TABLE Dictionary;
END
GO

CREATE TABLE Dictionary (
    word_id INT PRIMARY KEY IDENTITY(1,1),
    word_english NVARCHAR(100) NOT NULL,
    word_vietnamese NVARCHAR(255) NOT NULL,
    pronunciation NVARCHAR(100),                     -- Phiên âm
    word_type NVARCHAR(50),                          -- noun, verb, adjective...
    example_sentence NVARCHAR(MAX),                  -- Câu ví dụ tiếng Anh
    example_translation NVARCHAR(MAX),               -- Bản dịch câu ví dụ
    created_by INT FOREIGN KEY REFERENCES Users(user_id),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    updated_by INT FOREIGN KEY REFERENCES Users(user_id)
);
GO

-- Index cho word_english (tăng tốc tìm kiếm)
CREATE INDEX IX_Dictionary_WordEnglish ON Dictionary(word_english);
CREATE INDEX IX_Dictionary_WordVietnamese ON Dictionary(word_vietnamese);
GO

PRINT N'✓ Bảng Dictionary đã được tạo';
GO

-- =============================================
-- BẢNG 3: WordSuggestions (Từ user đề xuất)
-- =============================================
IF OBJECT_ID('WordSuggestions', 'U') IS NOT NULL
BEGIN
    DROP TABLE WordSuggestions;
END
GO

CREATE TABLE WordSuggestions (
    suggestion_id INT PRIMARY KEY IDENTITY(1,1),
    word_english NVARCHAR(100) NOT NULL,
    word_vietnamese NVARCHAR(255) NOT NULL,
    pronunciation NVARCHAR(100),
    word_type NVARCHAR(50),
    example_sentence NVARCHAR(MAX),
    example_translation NVARCHAR(MAX),
    suggested_by INT FOREIGN KEY REFERENCES Users(user_id),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    reviewed_by INT FOREIGN KEY REFERENCES Users(user_id),
    review_note NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    reviewed_at DATETIME
);
GO

-- Index
CREATE INDEX IX_WordSuggestions_Status ON WordSuggestions(status);
CREATE INDEX IX_WordSuggestions_SuggestedBy ON WordSuggestions(suggested_by);
GO

PRINT N'✓ Bảng WordSuggestions đã được tạo';
GO

-- =============================================
-- BẢNG 4: SearchHistory (Lịch sử tra cứu)
-- =============================================
IF OBJECT_ID('SearchHistory', 'U') IS NOT NULL
BEGIN
    DROP TABLE SearchHistory;
END
GO

CREATE TABLE SearchHistory (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    search_term NVARCHAR(100) NOT NULL,
    search_date DATETIME DEFAULT GETDATE(),
    found_word_id INT FOREIGN KEY REFERENCES Dictionary(word_id)
);
GO

-- Index
CREATE INDEX IX_SearchHistory_UserID ON SearchHistory(user_id);
CREATE INDEX IX_SearchHistory_SearchDate ON SearchHistory(search_date DESC);
GO

PRINT N'✓ Bảng SearchHistory đã được tạo';
GO

-- =============================================
-- INSERT DỮ LIỆU MẪU (Sample Data)
-- =============================================

-- Admin và Users mẫu
-- Password: "123" (bạn sẽ hash trong code)
INSERT INTO Users (username, password, full_name, role) 
VALUES 
    ('admin', '123', N'Administrator', 'admin'),
    ('user1', 'user123', N'Nguyễn Văn A', 'user'),
    ('user2', 'user123', N'Trần Thị B', 'user'),
    ('trieu', '123', N'Triệu Nguyễn Xuân', 'user');
GO

PRINT N'✓ Đã insert 4 users (admin, user1, user2, trieu)';
GO

-- Insert từ điển mẫu
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES 
    ('hello', N'xin chào', '/həˈloʊ/', 'interjection', 'Hello, how are you?', N'Xin chào, bạn khỏe không?', 1),
    ('computer', N'máy tính', '/kəmˈpjuːtər/', 'noun', 'I use my computer every day.', N'Tôi sử dụng máy tính mỗi ngày.', 1),
    ('engineer', N'kỹ sư', '/ˌendʒɪˈnɪr/', 'noun', 'He is a software engineer.', N'Anh ấy là kỹ sư phần mềm.', 1),
    ('dictionary', N'từ điển', '/ˈdɪkʃəˌneri/', 'noun', 'I need a dictionary to learn English.', N'Tôi cần một cuốn từ điển để học tiếng Anh.', 1),
    ('intelligent', N'thông minh', '/ɪnˈtelɪdʒənt/', 'adjective', 'She is very intelligent.', N'Cô ấy rất thông minh.', 1),
    ('algorithm', N'thuật toán', '/ˈælɡərɪðəm/', 'noun', 'This algorithm is efficient.', N'Thuật toán này hiệu quả.', 1),
    ('database', N'cơ sở dữ liệu', '/ˈdeɪtəbeɪs/', 'noun', 'We store data in a database.', N'Chúng tôi lưu dữ liệu trong CSDL.', 1);
GO

PRINT N'✓ Đã insert 7 từ vào Dictionary';
GO

-- Insert đề xuất mẫu
INSERT INTO WordSuggestions (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, suggested_by, status)
VALUES 
    ('framework', N'khung ứng dụng', '/ˈfreɪmwɜːrk/', 'noun', 'Spring is a Java framework.', N'Spring là một framework Java.', 2, 'pending'),
    ('variable', N'biến số', '/ˈveəriəbl/', 'noun', 'Declare a variable in Java.', N'Khai báo một biến trong Java.', 3, 'pending');
GO

PRINT N'✓ Đã insert 2 đề xuất vào WordSuggestions';
GO

-- =============================================
-- STORED PROCEDURES
-- =============================================

-- Stored Procedure: Tìm kiếm từ
IF OBJECT_ID('sp_SearchWord', 'P') IS NOT NULL
    DROP PROCEDURE sp_SearchWord;
GO

CREATE PROCEDURE sp_SearchWord
    @keyword NVARCHAR(100)
AS
BEGIN
    SELECT word_id, word_english, word_vietnamese, pronunciation, word_type, 
           example_sentence, example_translation
    FROM Dictionary
    WHERE word_english LIKE '%' + @keyword + '%' 
       OR word_vietnamese LIKE '%' + @keyword + '%'
    ORDER BY word_english;
END
GO

PRINT N'✓ Stored Procedure sp_SearchWord đã được tạo';
GO

-- =============================================
-- VIEWS
-- =============================================

-- View: Danh sách đề xuất chờ duyệt
IF OBJECT_ID('vw_PendingSuggestions', 'V') IS NOT NULL
    DROP VIEW vw_PendingSuggestions;
GO

CREATE VIEW vw_PendingSuggestions
AS
SELECT 
    s.suggestion_id,
    s.word_english,
    s.word_vietnamese,
    s.pronunciation,
    s.word_type,
    s.example_sentence,
    s.example_translation,
    s.created_at,
    u.full_name AS suggested_by_name,
    u.username AS suggested_by_username
FROM WordSuggestions s
INNER JOIN Users u ON s.suggested_by = u.user_id
WHERE s.status = 'pending';
GO

PRINT N'✓ View vw_PendingSuggestions đã được tạo';
GO

-- =============================================
-- KIỂM TRA KẾT QUẢ
-- =============================================

PRINT N'';
PRINT N'==============================================';
PRINT N'  DATABASE SPRING1 ĐÃ ĐƯỢC TẠO THÀNH CÔNG!';
PRINT N'==============================================';
PRINT N'';
PRINT N'Thông tin:';
PRINT N'  - Database: Spring1';
PRINT N'  - Bảng: 4 (Users, Dictionary, WordSuggestions, SearchHistory)';
PRINT N'  - Users: 4 (admin, user1, user2, trieu)';
PRINT N'  - Từ điển: 7 từ';
PRINT N'  - Đề xuất: 2 từ pending';
PRINT N'  - Không có Email - Chỉ username + password';
PRINT N'';
PRINT N'Kiểm tra:';
GO

-- Hiển thị users
SELECT user_id, username, full_name, role, status 
FROM Users;
GO

-- Hiển thị từ điển
SELECT word_id, word_english, word_vietnamese, word_type 
FROM Dictionary;
GO

PRINT N'';
PRINT N'✓ Script hoàn tất!';
GO