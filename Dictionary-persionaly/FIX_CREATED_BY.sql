-- ============================================
-- FIX: created_by NULL/0 causing word_id issues
-- ============================================

-- Problem: If created_by is NULL or 0, it might cause
-- ResultSet reading issues in JDBC

-- Step 1: Check current state
SELECT 
    word_id,
    word_english,
    created_by,
    CASE 
        WHEN created_by IS NULL THEN '❌ NULL'
        WHEN created_by = 0 THEN '❌ ZERO'
        ELSE '✅ OK'
    END as created_by_status
FROM Dictionary
WHERE created_by IS NULL OR created_by = 0
ORDER BY word_english;

-- Step 2: Fix all words with NULL/0 created_by
-- Set to admin user_id = 1
UPDATE Dictionary
SET created_by = 1
WHERE created_by IS NULL OR created_by = 0;

-- Step 3: Verify fix
SELECT COUNT(*) as fixed_count
FROM Dictionary
WHERE created_by = 1;

-- Step 4: Check specific words
SELECT 
    word_id,
    word_english,
    created_by,
    created_at
FROM Dictionary
WHERE word_english IN ('checkout', 'admit', 'enhance', 'hello', 'algorithm')
ORDER BY word_english;

-- All should now have:
-- word_id > 0  ✅
-- created_by = 1  ✅

