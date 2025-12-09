-- ============================================
-- FIX: Invalid word ID issue
-- ============================================
-- Problem: Từ "enhance" trong database không có word_id
-- Solution: Kiểm tra và fix schema + data

-- Step 1: Check if word_id column exists and is PRIMARY KEY
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Dictionary'
ORDER BY ORDINAL_POSITION;

-- Step 2: Check for NULL word_id values
SELECT COUNT(*) as null_word_id_count
FROM Dictionary
WHERE word_id IS NULL;

-- Step 3: If Dictionary table doesn't have word_id as PK, recreate it:
-- (ONLY run this if word_id is NOT the primary key!)

/*
-- Backup old data first
SELECT * INTO Dictionary_BACKUP FROM Dictionary;

-- Drop old table
DROP TABLE Dictionary;

-- Recreate with proper schema
CREATE TABLE Dictionary (
    word_id INT PRIMARY KEY IDENTITY(1,1),
    word_english NVARCHAR(100) NOT NULL,
    word_vietnamese NVARCHAR(500) NOT NULL,
    pronunciation NVARCHAR(100),
    word_type NVARCHAR(50),
    example_sentence NVARCHAR(500),
    example_translation NVARCHAR(500),
    created_by INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    updated_by INT
);

-- Restore data from backup
SET IDENTITY_INSERT Dictionary ON;

INSERT INTO Dictionary (word_id, word_english, word_vietnamese, pronunciation, 
                        word_type, example_sentence, example_translation,
                        created_by, created_at, updated_at, updated_by)
SELECT word_id, word_english, word_vietnamese, pronunciation, 
       word_type, example_sentence, example_translation,
       created_by, created_at, updated_at, updated_by
FROM Dictionary_BACKUP
WHERE word_id IS NOT NULL;

SET IDENTITY_INSERT Dictionary OFF;

-- Clean up
-- DROP TABLE Dictionary_BACKUP;
*/

-- Step 4: Verify all words now have valid word_id
SELECT 
    word_id,
    word_english,
    word_vietnamese
FROM Dictionary
WHERE word_english LIKE '%enhance%';

-- Step 5: Count total words
SELECT COUNT(*) as total_words FROM Dictionary;

-- ============================================
-- QUICK FIX: If you just want to search "enhance" to work:
-- ============================================
-- Check if "enhance" exists with valid word_id
SELECT * FROM Dictionary WHERE word_english = 'enhance';

-- If it doesn't exist, you can insert it manually:
/*
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, 
                        example_sentence, example_translation)
VALUES ('enhance', N'nâng cao, tăng cường', '/ɪnˈhɑːns/', 'verb',
        'This will enhance your skills.',
        'Điều này sẽ nâng cao kỹ năng của bạn.');
*/

-- ============================================
-- RECOMMENDED SOLUTION:
-- ============================================
-- If your Dictionary table is mostly empty or has bad data,
-- just run the 150 words insert script:
-- Execute: database_150_words_insert.sql
-- This will give you 150 quality words with proper word_id

-- Run in SQL Server:
Execute: database_150_words_insert.sql

-- Then verify:
SELECT word_id, word_english FROM Dictionary WHERE word_english = 'enhance';
-- Should see: word_id = some number (not NULL)