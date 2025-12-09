-- =====================================================
-- DATABASE MIGRATION: Fix FK Constraint for DELETE/UPDATE
-- Date: December 8, 2025
-- Description: Update FK constraint to allow DELETE/UPDATE
--              Dictionary words without blocking
-- Solution: ON DELETE SET NULL, ON UPDATE CASCADE
-- =====================================================

USE Spring1;
GO

PRINT '========================================';
PRINT 'Starting FK Constraint Migration...';
PRINT '========================================';
GO

-- Step 1: Drop existing FK constraint (if exists)
-- =====================================================
-- Try both possible constraint names (in case of different installations)
IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = 'FK_WordSuggestions_OriginalWord'
    AND TABLE_NAME = 'WordSuggestions'
)
BEGIN
    ALTER TABLE WordSuggestions
    DROP CONSTRAINT FK_WordSuggestions_OriginalWord;
    
    PRINT '✅ Dropped existing FK constraint: FK_WordSuggestions_OriginalWord';
END
ELSE IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = 'FK_WordSuggestions_Dictionary'
    AND TABLE_NAME = 'WordSuggestions'
)
BEGIN
    ALTER TABLE WordSuggestions
    DROP CONSTRAINT FK_WordSuggestions_Dictionary;
    
    PRINT '✅ Dropped existing FK constraint: FK_WordSuggestions_Dictionary';
END
ELSE
BEGIN
    PRINT 'ℹ️ No existing FK constraint found';
END
GO

-- Step 2: Recreate FK with CASCADE behaviors
-- =====================================================
ALTER TABLE WordSuggestions
ADD CONSTRAINT FK_WordSuggestions_Dictionary
FOREIGN KEY (original_word_id) 
REFERENCES Dictionary(word_id)
ON DELETE SET NULL    -- Khi xóa từ → Set original_word_id = NULL
ON UPDATE CASCADE;    -- Khi update word_id → Tự động update

PRINT '✅ Created new FK constraint with:';
PRINT '   - ON DELETE SET NULL (giữ lại suggestions, nhưng unlink khỏi từ đã xóa)';
PRINT '   - ON UPDATE CASCADE (tự động update nếu word_id thay đổi)';
GO

-- Step 3: Verify constraint
-- =====================================================
IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = 'FK_WordSuggestions_Dictionary'
    AND TABLE_NAME = 'WordSuggestions'
)
BEGIN
    PRINT '========================================';
    PRINT '✅ MIGRATION SUCCESSFUL!';
    PRINT '========================================';
    PRINT '';
    PRINT 'Admin giờ có thể:';
    PRINT '✅ Xóa từ trong Dictionary (suggestions sẽ có original_word_id = NULL)';
    PRINT '✅ Sửa từ trong Dictionary (không bị block)';
    PRINT '✅ WordSuggestions giữ lại audit trail';
    PRINT '';
END
ELSE
BEGIN
    PRINT '❌ MIGRATION FAILED - FK constraint not created';
END
GO

-- Step 4: Show current FK configuration
-- =====================================================
PRINT '========================================';
PRINT 'Current FK Configuration:';
PRINT '========================================';

SELECT 
    fk.name AS [Constraint Name],
    OBJECT_NAME(fk.parent_object_id) AS [Table],
    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS [Column],
    OBJECT_NAME(fk.referenced_object_id) AS [Referenced Table],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Referenced Column],
    fk.delete_referential_action_desc AS [On Delete],
    fk.update_referential_action_desc AS [On Update]
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fc 
    ON fk.object_id = fc.constraint_object_id
WHERE fk.name = 'FK_WordSuggestions_Dictionary';

GO

-- Test Query: Check orphaned suggestions (for debugging)
-- =====================================================
PRINT '';
PRINT '========================================';
PRINT 'Checking for orphaned suggestions...';
PRINT '========================================';

SELECT COUNT(*) AS [Orphaned Suggestions Count]
FROM WordSuggestions
WHERE original_word_id IS NULL 
AND suggestion_type = 'edit';

PRINT '';
PRINT 'ℹ️ If count > 0: These are edit suggestions';
PRINT 'whose original words were deleted.';
PRINT '';

GO

PRINT '========================================';
PRINT '🎉 MIGRATION COMPLETE!';
PRINT '========================================';
PRINT '';
PRINT 'Next steps:';
PRINT '1. Test: Admin xóa từ trong Dictionary';
PRINT '2. Test: Admin sửa từ trong Dictionary';
PRINT '3. Verify: WordSuggestions updated correctly';
PRINT '';
GO

