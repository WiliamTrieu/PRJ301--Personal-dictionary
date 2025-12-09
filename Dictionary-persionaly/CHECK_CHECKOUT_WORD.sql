-- Check if "checkout" exists and has valid word_id
SELECT 
    word_id,
    word_english,
    word_vietnamese,
    pronunciation,
    created_by,
    created_at,
    CASE 
        WHEN word_id IS NULL THEN '❌ NULL ID'
        WHEN word_id = 0 THEN '❌ ZERO ID'
        WHEN word_id > 0 THEN '✅ VALID ID'
    END as id_status,
    CASE 
        WHEN created_by IS NULL THEN '⚠️ NULL created_by'
        WHEN created_by = 0 THEN '⚠️ ZERO created_by'
        ELSE '✅ OK'
    END as created_by_status
FROM Dictionary
WHERE word_english = 'checkout';

-- If "checkout" doesn't exist, insert it:
/*
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, 
                        example_sentence, example_translation, created_by)
VALUES 
('checkout', N'trả phòng', '/ˈtʃekaʊt/', 'noun',
 'Checkout time is 11 AM.',
 N'Giờ trả phòng là 11 giờ sáng.',
 1);  -- created_by = 1 (admin)
*/

