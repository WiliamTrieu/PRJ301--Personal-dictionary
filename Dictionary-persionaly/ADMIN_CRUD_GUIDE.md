# 🛠️ ADMIN CRUD GUIDE - Quản lý từ điển

## 🎯 **TỔNG QUAN:**

Admin có thể trực tiếp:
- ➕ **THÊM** từ mới vào Dictionary
- ✏️ **SỬA** từ có sẵn trong Dictionary
- 🗑️ **XÓA** từ khỏi Dictionary

---

## 🔧 **VẤN ĐỀ ĐÃ FIX:**

### **Before (❌ LỖI):**
```
Admin click "Xóa từ" → SQL Error
→ FK constraint violation
→ Cannot delete: WordSuggestions references this word
```

### **After (✅ ĐÃ FIX):**
```
Admin click "Xóa từ" → Success!
→ Từ bị XÓA khỏi Dictionary
→ WordSuggestions: original_word_id → NULL (giữ lại audit trail)
```

---

## 📁 **FILES LIÊN QUAN:**

### **1. Servlet:**
```
src/java/controller/admin/AdminWordServlet.java
- doGet() → Load form edit / Delete word
- doPost() → Add / Update word
```

### **2. DAO:**
```
src/java/Dao/WordDAO.java
- insertWord() → INSERT new word
- updateWord() → UPDATE existing word
- deleteWord() → DELETE word
- wordExists() → Check duplicate
```

### **3. JSP:**
```
web/admin/manage-words.jsp → List + Search
web/admin/add-word.jsp → Form thêm từ
web/admin/edit-word.jsp → Form sửa từ
```

### **4. Migration SQL:**
```
database_migration_fix_fk_cascade.sql
→ Fix FK constraint để cho phép DELETE/UPDATE
```

---

## 🚀 **CÁCH SỬ DỤNG:**

### **1️⃣ XÓA TỪ:**

**Flow:**
```
Admin Dashboard
  ↓
Quản lý từ điển
  ↓
Tìm từ cần xóa
  ↓
Click "🗑️ Xóa"
  ↓
Confirm dialog
  ↓
AdminWordServlet?action=delete&id=123
  ↓
WordDAO.deleteWord(123)
  ↓
SQL: DELETE FROM Dictionary WHERE word_id = 123
  ↓
FK Cascade: SET original_word_id = NULL in WordSuggestions
  ↓
Success message: "Xóa từ thành công!"
```

**Code (`AdminWordServlet.java`):**
```java
} else if ("delete".equals(action)) {
    String wordIdStr = request.getParameter("id");
    if (wordIdStr != null) {
        try {
            int wordId = Integer.parseInt(wordIdStr);
            boolean success = wordDAO.deleteWord(wordId);
            if (success) {
                request.setAttribute("success", "Xóa từ thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa từ!");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ!");
        }
    }
    // Redirect về manage-words.jsp
}
```

**Code (`WordDAO.java`):**
```java
public boolean deleteWord(int wordId) {
    String sql = "DELETE FROM Dictionary WHERE word_id = ?";
    // ... JDBC boilerplate
    try {
        ps.setInt(1, wordId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.err.println("Error deleting word: " + e.getMessage());
        return false;
    }
}
```

**Impact:**
```sql
-- Before delete:
WordSuggestions: original_word_id = 123

-- After delete:
WordSuggestions: original_word_id = NULL
```

---

### **2️⃣ SỬA TỪ:**

**Flow:**
```
Admin Dashboard
  ↓
Quản lý từ điển
  ↓
Tìm từ cần sửa
  ↓
Click "✏️ Sửa"
  ↓
AdminWordServlet?action=edit&id=123
  ↓
Load word từ DB → Show edit form
  ↓
Admin sửa thông tin
  ↓
Submit → AdminWordServlet (POST)
  ↓
WordDAO.updateWord(word)
  ↓
SQL: UPDATE Dictionary SET ... WHERE word_id = 123
  ↓
Success message: "Cập nhật từ thành công!"
```

**Code (`AdminWordServlet.java`):**
```java
if ("edit".equals(action)) {
    String wordIdStr = request.getParameter("id");
    if (wordIdStr != null) {
        try {
            int wordId = Integer.parseInt(wordIdStr);
            Word word = wordDAO.getWordById(wordId);
            if (word != null) {
                request.setAttribute("word", word);
                request.getRequestDispatcher("edit-word.jsp").forward(...);
            } else {
                request.setAttribute("error", "Không tìm thấy từ!");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ!");
        }
    }
}
```

**Code (`WordDAO.java`):**
```java
public boolean updateWord(Word word) {
    String sql = "UPDATE Dictionary SET " +
                 "word_english = ?, word_vietnamese = ?, " +
                 "pronunciation = ?, word_type = ?, " +
                 "example_sentence = ?, example_translation = ?, " +
                 "updated_by = ?, updated_at = GETDATE() " +
                 "WHERE word_id = ?";
    // ... JDBC boilerplate
    try {
        ps.setString(1, word.getWordEnglish());
        ps.setString(2, word.getWordVietnamese());
        // ... set other params
        ps.setInt(8, word.getWordId());
        
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.err.println("Error updating word: " + e.getMessage());
        return false;
    }
}
```

---

### **3️⃣ THÊM TỪ:**

**Flow:**
```
Admin Dashboard
  ↓
Quản lý từ điển
  ↓
Click "➕ Thêm từ mới"
  ↓
add-word.jsp (form trống)
  ↓
Admin nhập thông tin
  ↓
Submit → AdminWordServlet (POST)
  ↓
Check wordExists() → Nếu tồn tại → Error
  ↓
WordDAO.insertWord(word)
  ↓
SQL: INSERT INTO Dictionary ...
  ↓
Success message: "Thêm từ thành công!"
```

**Code (`AdminWordServlet.java`):**
```java
if ("add".equals(action)) {
    Word word = createWordFromRequest(request);
    word.setCreatedBy(adminId);
    
    // Check duplicate
    if (wordDAO.wordExists(word.getWordEnglish())) {
        request.setAttribute("error", "Từ này đã tồn tại trong từ điển!");
        // ... forward back to form
        return;
    }
    
    boolean success = wordDAO.insertWord(word);
    if (success) {
        request.setAttribute("success", "Thêm từ thành công!");
    } else {
        request.setAttribute("error", "Có lỗi xảy ra khi thêm từ!");
    }
}
```

---

## 🗄️ **DATABASE SCHEMA:**

### **Dictionary Table:**
```sql
CREATE TABLE Dictionary (
    word_id INT PRIMARY KEY IDENTITY(1,1),
    word_english NVARCHAR(100) NOT NULL UNIQUE,
    word_vietnamese NVARCHAR(500) NOT NULL,
    pronunciation NVARCHAR(100),
    word_type NVARCHAR(50),
    example_sentence NVARCHAR(500),
    example_translation NVARCHAR(500),
    added_by INT, -- FK to Users
    created_at DATETIME DEFAULT GETDATE(),
    updated_by INT,
    updated_at DATETIME
);
```

### **WordSuggestions Table (with FK):**
```sql
CREATE TABLE WordSuggestions (
    suggestion_id INT PRIMARY KEY IDENTITY(1,1),
    suggestion_type NVARCHAR(20) DEFAULT 'new',
    original_word_id INT NULL,
    word_english NVARCHAR(100) NOT NULL,
    word_vietnamese NVARCHAR(500) NOT NULL,
    -- ... other fields
    
    CONSTRAINT FK_WordSuggestions_Dictionary
    FOREIGN KEY (original_word_id)
    REFERENCES Dictionary(word_id)
    ON DELETE SET NULL    -- ✅ KEY FEATURE!
    ON UPDATE CASCADE
);
```

---

## 🔍 **FK CASCADE BEHAVIORS:**

### **ON DELETE SET NULL:**
```sql
-- Scenario:
Dictionary: word_id=123, word_english='hello'
WordSuggestions: original_word_id=123

-- Admin xóa 'hello':
DELETE FROM Dictionary WHERE word_id=123;

-- Result:
Dictionary: (row deleted)
WordSuggestions: original_word_id=NULL (not deleted!)
```

**Why?**
- ✅ Giữ lại audit trail
- ✅ Biết user đã suggest edit cho từ nào (dù từ đã bị xóa)
- ✅ Không mất data

### **ON UPDATE CASCADE:**
```sql
-- Scenario:
Dictionary: word_id=123
WordSuggestions: original_word_id=123

-- Admin update word_id (rare case):
UPDATE Dictionary SET word_id=456 WHERE word_id=123;

-- Result:
Dictionary: word_id=456
WordSuggestions: original_word_id=456 (auto updated!)
```

---

## 🎨 **UI/UX:**

### **manage-words.jsp:**
```html
<table>
    <tr>
        <td>123</td>
        <td>hello</td>
        <td>xin chào</td>
        <td>interjection</td>
        <td>
            <a href="AdminWordServlet?action=edit&id=123">✏️ Sửa</a>
            <a href="AdminWordServlet?action=delete&id=123" 
               onclick="return confirm('Bạn có chắc muốn xóa từ này?');">
                🗑️ Xóa
            </a>
        </td>
    </tr>
</table>
```

### **Success/Error Messages:**
```html
<!-- Success -->
<div class="alert alert-success">
    ✅ Xóa từ thành công!
</div>

<!-- Error -->
<div class="alert alert-error">
    ❌ Có lỗi xảy ra khi xóa từ!
</div>
```

---

## 🧪 **TESTING:**

### **Test 1: Xóa từ có suggestions**
```
1. User suggest edit cho từ "hello" (ID=123)
   → WordSuggestions: original_word_id=123
   
2. Admin xóa từ "hello"
   → AdminWordServlet?action=delete&id=123
   
3. Check database:
   SELECT * FROM Dictionary WHERE word_id=123;
   → (0 rows) ✅
   
   SELECT original_word_id FROM WordSuggestions WHERE suggestion_id=42;
   → NULL ✅
```

### **Test 2: Sửa từ**
```
1. Admin click "✏️ Sửa" cho từ "hello"
   → AdminWordServlet?action=edit&id=123
   
2. Form load with pre-filled data ✅

3. Admin sửa nghĩa: "xin chào" → "chào bạn"
   
4. Submit → POST AdminWordServlet
   → action=update, wordId=123
   
5. Check database:
   SELECT word_vietnamese FROM Dictionary WHERE word_id=123;
   → "chào bạn" ✅
```

### **Test 3: Thêm từ trùng**
```
1. Dictionary already has "hello"

2. Admin thêm "hello" lại
   → AdminWordServlet (POST) action=add
   
3. Check wordExists("hello")
   → TRUE
   
4. Show error:
   "Từ này đã tồn tại trong từ điển!" ✅
```

---

## 📋 **MIGRATION CHECKLIST:**

- [ ] Backup database trước khi chạy migration
- [ ] Run `database_migration_fix_fk_cascade.sql`
- [ ] Verify FK constraint:
  ```sql
  SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE CONSTRAINT_NAME = 'FK_WordSuggestions_Dictionary';
  ```
- [ ] Test xóa từ
- [ ] Test sửa từ
- [ ] Check orphaned suggestions (original_word_id=NULL)

---

## 🚨 **COMMON ERRORS & FIXES:**

### **Error 1: "Cannot DELETE - FK constraint"**
**Cause:** Chưa chạy migration SQL  
**Fix:** Run `database_migration_fix_fk_cascade.sql`

### **Error 2: "Không tìm thấy từ"**
**Cause:** word_id không tồn tại  
**Fix:** Check `WordDAO.getWordById()` return null

### **Error 3: "Từ này đã tồn tại"**
**Cause:** Duplicate word_english  
**Fix:** Expected behavior! Change word_english or cancel

---

## 📊 **STATISTICS:**

| Operation | SQL | Impact on WordSuggestions |
|-----------|-----|---------------------------|
| **DELETE** | `DELETE FROM Dictionary WHERE word_id=?` | `original_word_id → NULL` |
| **UPDATE** | `UPDATE Dictionary SET ... WHERE word_id=?` | No impact (unless word_id changes) |
| **INSERT** | `INSERT INTO Dictionary ...` | No impact |

---

## ✅ **COMPLETED:**

- [x] Fix FK constraint (ON DELETE SET NULL)
- [x] AdminWordServlet implemented
- [x] WordDAO methods (insert, update, delete)
- [x] manage-words.jsp UI
- [x] edit-word.jsp UI
- [x] add-word.jsp UI
- [x] Migration SQL
- [x] Documentation

---

## 🎉 **RESULT:**

**Admin giờ có thể tự do:**
- ✅ Xóa từ (không bị block)
- ✅ Sửa từ (không bị block)
- ✅ Thêm từ (với duplicate check)
- ✅ WordSuggestions giữ nguyên audit trail

**Perfect! 🚀**

