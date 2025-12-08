# 🚨 HƯỚNG DẪN KHẮC PHỤC LỖI ĐĂNG KÝ

## Vấn đề: "Đăng ký thất bại! Vui lòng thử lại."

### ✅ Nguyên nhân:
Database chưa có column `security_code_hash` trong table `Users`.

---

## 🔧 CÁCH FIX (2 BƯỚC):

### **BƯỚC 1: Chạy Database Migration**

1. **Mở SQL Server Management Studio**
2. **Connect tới database của bạn** (database name: `Spring1`)
3. **Copy & paste script dưới đây và Execute:**

```sql
-- Add security_code_hash column to Users table
USE Spring1;
GO

ALTER TABLE Users
ADD security_code_hash VARCHAR(255) NULL;
GO

-- Verify
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'security_code_hash';
GO
```

**Hoặc chạy file SQL có sẵn:**
```
File: database_migration_security_code.sql
→ Mở trong SSMS → Execute
```

### **BƯỚC 2: Restart Server**

1. **Stop server** trong NetBeans
2. **Clean and Build project** (Shift + F11)
3. **Run project** (F6)

---

## ✅ Kiểm tra đã fix chưa:

### **Check Database:**
```sql
-- Check column exists
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'security_code_hash';

-- Should return 1 row with:
-- COLUMN_NAME: security_code_hash
-- DATA_TYPE: varchar
```

### **Check Server Logs:**
- Khi đăng ký thành công, console sẽ hiện:
  ```
  ✅ Register SUCCESS: [username]
  ```

- Nếu vẫn lỗi, console sẽ hiện:
  ```
  ❌ Error in UserDAO.registerUser: ...
  ⚠️  HINT: Run database migration script!
  ```

---

## 📝 Các thay đổi đã làm:

### ✅ **1. Đơn giản hóa Security Code**
- **Trước:** Phải là câu hỏi, không được trùng password/username
- **Bây giờ:** Chỉ cần ≥6 ký tự bất kỳ (chữ, số, ký tự đặc biệt)
- **Ví dụ hợp lệ:**
  - ✅ "123456"
  - ✅ "MyCode123"
  - ✅ "abc@xyz"
  - ✅ "Tên chó Milo"

### ✅ **2. Fix Scroll Issue**
- Thêm `overflow-y: auto` vào `.eden-card`
- Bây giờ có thể scroll xuống dễ dàng

### ✅ **3. Better Error Logging**
- Console log chi tiết lỗi SQL
- Gợi ý fix nếu thiếu column

---

## 🎯 Test Flow:

### **Test 1: Đăng ký với Security Code đơn giản**
```
Username: testuser123
Full Name: Nguyen Van A
Password: Test1234
Confirm Password: Test1234
Security Code: abcd1234
Confirm Security Code: abcd1234
✅ Agree terms
→ Submit
```

**Expected:** "Đăng ký thành công! Vui lòng đăng nhập."

---

## 🐛 Vẫn gặp lỗi?

### **Check List:**
- [ ] Database column `security_code_hash` đã được tạo?
- [ ] Server đã restart?
- [ ] Project đã Clean and Build?
- [ ] Console logs hiển thị gì?

### **Common Errors:**

**Error 1:** "Invalid column name 'security_code_hash'"
```
→ Fix: Chạy migration script (BƯỚC 1)
```

**Error 2:** Validation lỗi "Mã bảo mật phải có ít nhất 6 ký tự"
```
→ Fix: Nhập ít nhất 6 ký tự bất kỳ
```

**Error 3:** Không scroll được
```
→ Fix: Clear browser cache (Ctrl + Shift + R)
```

---

## 📞 Debug Commands:

### **Check Database Connection:**
```sql
-- Test connection
SELECT @@VERSION;

-- Check Users table structure
EXEC sp_columns Users;
```

### **Check Server Status:**
```bash
# NetBeans Output window
# Look for:
✅ Register SUCCESS: testuser123
# Or:
❌ Error in UserDAO.registerUser: ...
```

---

## ✅ Sau khi fix xong:

1. ✅ Đăng ký account mới với security code đơn giản
2. ✅ Test forgot password flow
3. ✅ Scroll xuống/lên dễ dàng
4. ✅ Admin có thể xem reset requests

**Happy Coding! 🚀**

