-- =============================================
-- DATABASE: PersonalDictionary
-- MÔ TẢ: Database cho ứng dụng Từ điển Cá nhân
-- Tác giả: PRJ301 Project
-- Ngày tạo: 2025
-- Encoding: UTF-8 (Unicode)
-- =============================================

-- Tạo Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Spring')
BEGIN
    CREATE DATABASE Spring;
END
GO

USE Spring;
GO

-- =============================================
-- BẢNG 1: Users (Người dùng)
-- =============================================
IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;
GO

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100),
    role NVARCHAR(20) DEFAULT 'user' CHECK (role IN ('admin', 'user')),
    status BIT DEFAULT 1, -- 1: active, 0: inactive
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME
);
GO

-- Index cho email (tăng tốc tìm kiếm)
CREATE INDEX IX_Users_Email ON Users(email);
GO

-- =============================================
-- BẢNG 2: Dictionary (Từ điển chính - đã được approve)
-- =============================================
IF OBJECT_ID('Dictionary', 'U') IS NOT NULL
    DROP TABLE Dictionary;
GO

CREATE TABLE Dictionary (
    word_id INT PRIMARY KEY IDENTITY(1,1),
    word_english NVARCHAR(100) NOT NULL,
    word_vietnamese NVARCHAR(255) NOT NULL,
    pronunciation NVARCHAR(100), -- phiên âm (ví dụ: /ˈhæpi/)
    word_type NVARCHAR(50), -- noun, verb, adjective, adverb, etc.
    example_sentence NVARCHAR(MAX), -- câu ví dụ tiếng Anh
    example_translation NVARCHAR(MAX), -- bản dịch câu ví dụ
    created_by INT FOREIGN KEY REFERENCES Users(user_id),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    updated_by INT FOREIGN KEY REFERENCES Users(user_id)
);
GO

-- Index cho word_english (tăng tốc tìm kiếm)
CREATE INDEX IX_Dictionary_WordEnglish ON Dictionary(word_english);
GO

-- Index cho word_vietnamese (tìm kiếm theo tiếng Việt)
CREATE INDEX IX_Dictionary_WordVietnamese ON Dictionary(word_vietnamese);
GO

-- =============================================
-- BẢNG 3: WordSuggestions (Từ user đề xuất - chờ duyệt)
-- =============================================
IF OBJECT_ID('WordSuggestions', 'U') IS NOT NULL
    DROP TABLE WordSuggestions;
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
    review_note NVARCHAR(MAX), -- lý do từ chối hoặc ghi chú
    created_at DATETIME DEFAULT GETDATE(),
    reviewed_at DATETIME
);
GO

-- Index cho status (tăng tốc filter theo trạng thái)
CREATE INDEX IX_WordSuggestions_Status ON WordSuggestions(status);
GO

-- Index cho suggested_by (xem đề xuất của user nào)
CREATE INDEX IX_WordSuggestions_SuggestedBy ON WordSuggestions(suggested_by);
GO

-- =============================================
-- BẢNG 4: SearchHistory (Lịch sử tra cứu - optional)
-- =============================================
IF OBJECT_ID('SearchHistory', 'U') IS NOT NULL
    DROP TABLE SearchHistory;
GO

CREATE TABLE SearchHistory (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    search_term NVARCHAR(100) NOT NULL,
    search_date DATETIME DEFAULT GETDATE(),
    found_word_id INT FOREIGN KEY REFERENCES Dictionary(word_id) -- từ nào được tìm thấy (NULL nếu không tìm thấy)
);
GO

-- Index cho user_id (xem lịch sử của user)
CREATE INDEX IX_SearchHistory_UserID ON SearchHistory(user_id);
GO

-- Index cho search_date (sắp xếp theo ngày)
CREATE INDEX IX_SearchHistory_SearchDate ON SearchHistory(search_date DESC);
GO

-- =============================================
-- INSERT DỮ LIỆU MẪU (Sample Data)
-- =============================================

-- Insert Admin mặc định
-- Password: "admin123" (bạn sẽ hash password này trong code)
INSERT INTO Users (email, password, full_name, role) 
VALUES 
    ('trieu', '123', N'Administrator', 'admin'),
    ('user1@test.com', 'user123', N'Nguyễn Văn A', 'user'),
    ('user2@test.com', 'user123', N'Trần Thị B', 'user');
GO

-- Insert một số từ điển mẫu
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES 
    ('hello', N'xin chào', '/həˈloʊ/', 'interjection', 'Hello, how are you?', N'Xin chào, bạn khỏe không?', 1),
    ('computer', N'máy tính', '/kəmˈpjuːtər/', 'noun', 'I use my computer every day.', N'Tôi sử dụng máy tính mỗi ngày.', 1),
    ('engineer', N'kỹ sư', '/ˌendʒɪˈnɪr/', 'noun', 'He is a software engineer.', N'Anh ấy là kỹ sư phần mềm.', 1),
    ('dictionary', N'từ điển', '/ˈdɪkʃəˌneri/', 'noun', 'I need a dictionary to learn English.', N'Tôi cần một cuốn từ điển để học tiếng Anh.', 1),
    ('intelligent', N'thông minh', '/ɪnˈtelɪdʒənt/', 'adjective', 'She is very intelligent.', N'Cô ấy rất thông minh.', 1);
GO

-- Insert một số đề xuất mẫu (pending)
INSERT INTO WordSuggestions (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, suggested_by, status)
VALUES 
    ('algorithm', N'thuật toán', '/ˈælɡərɪðəm/', 'noun', 'This algorithm is very efficient.', N'Thuật toán này rất hiệu quả.', 2, 'pending'),
    ('database', N'cơ sở dữ liệu', '/ˈdeɪtəbeɪs/', 'noun', 'We store data in a database.', N'Chúng tôi lưu trữ dữ liệu trong cơ sở dữ liệu.', 3, 'pending');
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

-- =============================================
-- VIEWS
-- =============================================

-- View: Danh sách đề xuất chờ duyệt
-- LƯU Ý: Không dùng ORDER BY trong VIEW, sẽ ORDER BY khi query VIEW
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
    u.email AS suggested_by_email
FROM WordSuggestions s
INNER JOIN Users u ON s.suggested_by = u.user_id
WHERE s.status = 'pending';
-- Đã bỏ ORDER BY - sẽ ORDER BY khi query: SELECT * FROM vw_PendingSuggestions ORDER BY created_at DESC
GO

-- =============================================
-- KẾT THÚC SCRIPT
-- =============================================
PRINT N'Database Spring đã được tạo thành công!';
PRINT N'Số bảng đã tạo: 4 (Users, Dictionary, WordSuggestions, SearchHistory)';
PRINT N'Dữ liệu mẫu đã được insert.';
PRINT N'Stored Procedure sp_SearchWord đã được tạo.';
PRINT N'View vw_PendingSuggestions đã được tạo.';
GO
