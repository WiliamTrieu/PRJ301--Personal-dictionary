-- =====================================================
-- DATABASE MIGRATION: Suggest Edit Feature
-- Date: December 8, 2025
-- Description: Add suggestion_type and original_word_id
--              to WordSuggestions table
-- =====================================================

USE Spring1;
GO

-- Step 1: Add suggestion_type column
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'WordSuggestions' 
    AND COLUMN_NAME = 'suggestion_type'
)
BEGIN
    ALTER TABLE WordSuggestions
    ADD suggestion_type NVARCHAR(20) DEFAULT 'new';
    
    PRINT '✅ Added suggestion_type column to WordSuggestions table';
END
ELSE
BEGIN
    PRINT 'ℹ️ suggestion_type column already exists';
END
GO

-- Step 2: Add CHECK constraint for suggestion_type
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = 'CK_WordSuggestions_Type'
)
BEGIN
    ALTER TABLE WordSuggestions
    ADD CONSTRAINT CK_WordSuggestions_Type 
    CHECK (suggestion_type IN ('new', 'edit'));
    
    PRINT '✅ Added CHECK constraint for suggestion_type';
END
ELSE
BEGIN
    PRINT 'ℹ️ CHECK constraint already exists';
END
GO

-- Step 3: Add original_word_id column
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'WordSuggestions' 
    AND COLUMN_NAME = 'original_word_id'
)
BEGIN
    ALTER TABLE WordSuggestions
    ADD original_word_id INT NULL;
    
    PRINT '✅ Added original_word_id column to WordSuggestions table';
END
ELSE
BEGIN
    PRINT 'ℹ️ original_word_id column already exists';
END
GO

-- Step 4: Add Foreign Key constraint
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = 'FK_WordSuggestions_OriginalWord'
)
BEGIN
    ALTER TABLE WordSuggestions
    ADD CONSTRAINT FK_WordSuggestions_OriginalWord 
    FOREIGN KEY (original_word_id) REFERENCES Dictionary(word_id);
    
    PRINT '✅ Added Foreign Key constraint';
END
ELSE
BEGIN
    PRINT 'ℹ️ Foreign Key constraint already exists';
END
GO

-- Step 5: Create index for better performance
-- =====================================================
IF NOT EXISTS (
    SELECT * FROM sys.indexes 
    WHERE name = 'IDX_WordSuggestions_Type' 
    AND object_id = OBJECT_ID('WordSuggestions')
)
BEGIN
    CREATE INDEX IDX_WordSuggestions_Type 
    ON WordSuggestions(suggestion_type);
    
    PRINT '✅ Created index for suggestion_type';
END
ELSE
BEGIN
    PRINT 'ℹ️ Index already exists';
END
GO

-- Step 6: Verification
-- =====================================================
PRINT '';
PRINT '========================================';
PRINT 'MIGRATION SUMMARY';
PRINT '========================================';

-- Check columns
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'WordSuggestions'
AND COLUMN_NAME IN ('suggestion_type', 'original_word_id');

PRINT '';
PRINT '✅ Migration completed successfully!';
PRINT '';
PRINT '📊 WordSuggestions table structure updated:';
PRINT '   - suggestion_type: NVARCHAR(20) DEFAULT ''new'' CHECK (''new'', ''edit'')';
PRINT '   - original_word_id: INT NULL FK → Dictionary(word_id)';
PRINT '';
PRINT '🎯 Usage:';
PRINT '   - suggestion_type = ''new'': User suggests NEW word';
PRINT '   - suggestion_type = ''edit'': User suggests EDIT to existing word';
PRINT '   - original_word_id: ID of the original word (for ''edit'' type)';
PRINT '========================================';
GO
