-- ============================================
-- DEBUG: Check word_id values in Dictionary
-- ============================================

-- 1. Check table structure
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Dictionary'
ORDER BY ORDINAL_POSITION;

-- 2. Check for words with NULL or 0 word_id
SELECT 
    word_id,
    word_english,
    word_vietnamese,
    CASE 
        WHEN word_id IS NULL THEN '❌ NULL'
        WHEN word_id = 0 THEN '❌ ZERO'
        WHEN word_id > 0 THEN '✅ OK'
    END as status
FROM Dictionary
WHERE word_id IS NULL OR word_id = 0;

-- 3. Check specific words: "admit", "enhance", "algorithm"
SELECT 
    word_id,
    word_english,
    word_vietnamese,
    pronunciation
FROM Dictionary
WHERE word_english IN ('admit', 'enhance', 'algorithm', 'hello')
ORDER BY word_english;

-- 4. Count total words and valid word_ids
SELECT 
    COUNT(*) as total_words,
    COUNT(CASE WHEN word_id > 0 THEN 1 END) as valid_word_ids,
    COUNT(CASE WHEN word_id IS NULL OR word_id = 0 THEN 1 END) as invalid_word_ids
FROM Dictionary;

-- 5. Show first 10 words with their IDs
SELECT TOP 10
    word_id,
    word_english,
    word_vietnamese
FROM Dictionary
ORDER BY word_id;

-- ============================================
-- EXPECTED OUTPUT:
-- ============================================
-- If you see word_id = NULL or 0, that's the problem!
-- All words should have word_id > 0

-- ============================================
-- FIX: If words have NULL/0 word_id:
-- ============================================

-- Option A: Re-insert specific words
/*
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, 
                        example_sentence, example_translation)
VALUES 
('admit', N'thừa nhận', '/ədˈmɪt/', 'verb',
 'I admit I was wrong.',
 N'Tôi thừa nhận mình đã sai.'),
 
('enhance', N'nâng cao, tăng cường', '/ɪnˈhɑːns/', 'verb',
 'This will enhance your skills.',
 N'Điều này sẽ nâng cao kỹ năng của bạn.');
*/

-- Option B: Run full 150 words script
-- Execute: database_150_words_insert.sql

-- ============================================
-- VERIFY AFTER FIX:
-- ============================================
SELECT word_id, word_english FROM Dictionary WHERE word_english = 'admit';
-- Should show: word_id = (some positive number)

SELECT COUNT(*) FROM Dictionary;SELECT word_id, word_english FROM Dictionary 
WHERE word_english = 'admit';