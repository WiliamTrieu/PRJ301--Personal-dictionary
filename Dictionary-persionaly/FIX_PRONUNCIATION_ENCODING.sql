-- ============================================
-- FIX: Pronunciation encoding issues
-- ============================================
-- Problem: IPA characters showing as ??? 
-- Solution: Re-insert with N prefix for Unicode

-- Check current state
SELECT word_id, word_english, pronunciation 
FROM Dictionary 
WHERE pronunciation LIKE '%?%'
ORDER BY word_english;

-- Fix common words with correct IPA
-- Note: Use N prefix for Unicode strings!

UPDATE Dictionary SET pronunciation = N'/dɪˌpriːʃiˈeɪʃn/' WHERE word_english = 'depreciation';
UPDATE Dictionary SET pronunciation = N'/ədˈmɪt/' WHERE word_english = 'admit';
UPDATE Dictionary SET pronunciation = N'/ɪnˈhɑːns/' WHERE word_english = 'enhance';
UPDATE Dictionary SET pronunciation = N'/ˈtʃekaʊt/' WHERE word_english = 'checkout';
UPDATE Dictionary SET pronunciation = N'/həˈləʊ/' WHERE word_english = 'hello';
UPDATE Dictionary SET pronunciation = N'/ˈælɡərɪðəm/' WHERE word_english = 'algorithm';

-- If you want to REMOVE all corrupted pronunciations:
-- UPDATE Dictionary SET pronunciation = NULL WHERE pronunciation LIKE '%?%';

-- Verify fix
SELECT word_id, word_english, pronunciation 
FROM Dictionary 
WHERE word_english IN ('depreciation', 'admit', 'enhance', 'checkout')
ORDER BY word_english;

-- FIX_PRONUNCIATION_ENCODING.sql

-- Dùng N prefix cho Unicode
UPDATE Dictionary SET pronunciation = N'/dɪˌpriːʃiˈeɪʃn/' WHERE word_english = 'depreciation';
UPDATE Dictionary SET pronunciation = N'/ədˈmɪt/' WHERE word_english = 'admit';
-- ... etc