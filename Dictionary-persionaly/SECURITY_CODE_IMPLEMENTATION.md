# 🔐 Security Code & Password Reset Implementation Guide

## 📋 Tổng quan

Hệ thống Security Code giúp users reset mật khẩu **mà không cần email verification service**. Flow được thiết kế đơn giản, bảo mật, và dễ quản lý bởi admin.

---

## 🎯 Luồng hoạt động (User Flow)

### **1. ĐĂNG KÝ TÀI KHOẢN (Register)**

```
User nhập:
├─ Username
├─ Full Name  
├─ Password
├─ Confirm Password
├─ Security Code (MÃ BẢO MẬT - riêng tư, chỉ user biết)
└─ Confirm Security Code

→ Hệ thống hash Security Code bằng SHA-256
→ Lưu vào Users.security_code_hash
```

**💡 Gợi ý Security Code:**
- "Tên chó tôi là Milo"
- "Mẹ tôi sinh năm 1975"  
- "Quê ở Hà Nội"
- "Phim yêu thích Avatar"

**⚠️ Lưu ý quan trọng:**
- Mã bảo mật KHÁC với mật khẩu đăng nhập
- Chỉ user biết, admin không thấy được
- Cần nhớ để khôi phục mật khẩu

---

### **2. QUÊN MẬT KHẨU (Forgot Password)**

```
User nhập:
├─ Username
├─ Security Code (để verify identity)
└─ Contact Email (để admin liên hệ)

→ Hệ thống verify Security Code
→ Tạo PasswordResetRequest (status = 'pending')
→ Hiển thị thông báo thành công
```

**✅ Nếu Security Code đúng:**
- Request được tạo và gửi tới admin
- User thấy thông báo: "Yêu cầu đã được gửi thành công!"

**❌ Nếu Security Code sai:**
- Hiển thị lỗi: "Mã bảo mật không đúng!"
- User thử lại

---

### **3. ADMIN XỬ LÝ REQUEST**

```
Admin Dashboard → Password Reset Requests

Hiển thị:
┌──────────────────────────────────────────┐
│ 🔴 Username: johndoe123                  │
│ 👤 Username: johndoe123                  │
│ 📧 Email: john@example.com               │
│ 🔒 Security Code: ✓ Verified             │
│ ⏰ Yêu cầu lúc: 08/12/2025 10:30 AM      │
│                                          │
│              [Đã đọc]                    │
└──────────────────────────────────────────┘

Khi bấm "Đã đọc":
→ Popup: "Đã gửi password cho user này chưa?"
   ├─ Chưa: Quay lại màn hình
   └─ Rồi: Mark as completed → Xóa khỏi list
```

**Admin workflow:**
1. Xem request (username + contact email)
2. **Manually** tạo password mới (random hoặc mặc định)
3. **Manually** gửi password qua email cho user
4. Bấm "Đã đọc" → Confirm đã gửi → Request biến mất

---

## 📁 Cấu trúc file đã tạo/sửa

### **✅ Files mới tạo:**
```
src/java/model/PasswordResetRequest.java
src/java/Dao/PasswordResetRequestDAO.java
src/java/controller/admin/PasswordResetServlet.java
src/java/controller/api/PasswordResetCountServlet.java
web/admin/password-reset-requests.jsp
database_migration_security_code.sql
```

### **✏️ Files đã sửa:**
```
web/register.jsp                          → Add Security Code fields
web/js/register.js                        → Add Security Code validation
src/java/controller/RegisterServlet.java  → Handle Security Code
src/java/dao/UserDAO.java                 → Add verifySecurityCode(), hashSecurityCode()
web/forgot-password.jsp                   → Replace email with Security Code
src/java/controller/ForgotPasswordServlet.java → New verification flow
web/admin/dashboard.jsp                   → Add notification badge
```

---

## 🗄️ Database Schema

### **1. Users Table (Updated)**
```sql
ALTER TABLE Users
ADD security_code_hash VARCHAR(255) NULL;
```

**Ví dụ:**
| user_id | username | password_hash | security_code_hash | role |
|---------|----------|--------------|-------------------|------|
| 1 | john | (hashed) | (SHA-256 hash) | user |

### **2. PasswordResetRequests Table (New)**
```sql
CREATE TABLE PasswordResetRequests (
    request_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    username NVARCHAR(50) NOT NULL,
    contact_email NVARCHAR(255) NOT NULL,
    verified BIT DEFAULT 1,
    status NVARCHAR(20) DEFAULT 'pending',
    requested_at DATETIME DEFAULT GETDATE(),
    read_at DATETIME NULL,
    completed_at DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
```

**Status values:**
- `pending`: Chưa xử lý
- `completed`: Đã gửi password cho user

---

## 🚀 Cài đặt (Installation Steps)

### **Step 1: Run Database Migration**
```sql
-- Mở SQL Server Management Studio
-- Chạy file: database_migration_security_code.sql
-- Hoặc copy-paste và execute
```

### **Step 2: Build Project**
```bash
# Clean và build lại project trong NetBeans
1. Right-click project → Clean and Build
2. Kiểm tra lỗi compile
```

### **Step 3: Deploy**
```bash
# Deploy lên server
1. Run project trong NetBeans (F6)
2. Hoặc deploy .war file lên Tomcat
```

### **Step 4: Test Flow**

**Test 1: Đăng ký với Security Code**
```
1. Vào: http://localhost:8080/Dictionary/register.jsp
2. Điền form với Security Code: "TestCode123456"
3. Submit → Check database: security_code_hash có giá trị
```

**Test 2: Forgot Password**
```
1. Vào: http://localhost:8080/Dictionary/forgot-password.jsp
2. Nhập username + security code + email
3. Submit → Check database: PasswordResetRequests có record mới
```

**Test 3: Admin View**
```
1. Login as admin
2. Vào: Admin Dashboard → Password Reset Requests
3. Verify hiển thị request
4. Bấm "Đã đọc" → Confirm → Request biến mất
```

---

## 🔒 Bảo mật (Security Features)

### **1. Security Code Hashing**
```java
// SHA-256 hash, case-insensitive, trimmed
String hash = hashSecurityCode("Tên chó tôi là Milo");
// → "9f735e0df9a1ddc702bf0a1a7b83033f9f7153a00c29de82cedadc9957289b05"
```

### **2. Validation Rules**
```java
✅ Security Code ≥ 6 ký tự
✅ Security Code ≠ Password
✅ Security Code ≠ Username  
✅ Verify trước khi tạo request
```

### **3. Admin Access Control**
```java
// Chỉ admin mới xem được requests
if (!"admin".equals(user.getRole())) {
    redirect to user dashboard
}
```

---

## 📊 Database ERD

```
┌─────────────────┐         ┌─────────────────────────┐
│     Users       │         │ PasswordResetRequests   │
├─────────────────┤         ├─────────────────────────┤
│ user_id (PK)    │◄────────│ request_id (PK)         │
│ username        │    1:N  │ user_id (FK)            │
│ password_hash   │         │ username                │
│ security_code_  │         │ contact_email           │
│   hash (NEW)    │         │ verified                │
│ role            │         │ status                  │
│ ...             │         │ requested_at            │
└─────────────────┘         │ read_at                 │
                            │ completed_at            │
                            └─────────────────────────┘
```

---

## 🎨 UI/UX Features

### **1. Register Page**
- 🔐 Security Code section với background xanh lá
- 💡 Info button giải thích "Tại sao cần mã bảo mật?"
- ✅ Real-time validation
- 🎭 Interactive modal với examples

### **2. Forgot Password Page**
- 📝 3 fields: Username, Security Code, Contact Email
- 💡 Hint box: "Mã bảo mật là mã riêng bạn đã đặt khi đăng ký"
- ✅ Client-side validation
- 🎉 Success message với hướng dẫn rõ ràng

### **3. Admin Dashboard**
- 🔔 Notification badge (red, animated pulse)
- 📊 Request cards với đầy đủ thông tin
- ✅ One-click "Đã đọc" với confirm dialog
- 🎨 Clean, modern design

---

## 🐛 Troubleshooting

### **Lỗi: "security_code_hash" column not found**
```sql
-- Check column exists
SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users' 
AND COLUMN_NAME = 'security_code_hash';

-- If not exists, run migration again
```

### **Lỗi: "PasswordResetRequests" table not found**
```sql
-- Check table exists
SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'PasswordResetRequests';

-- If not exists, run CREATE TABLE script
```

### **Notification badge không hiện**
```javascript
// Check browser console for errors
// Verify API endpoint: /api/password-reset-count
// Check database: SELECT COUNT(*) FROM PasswordResetRequests WHERE status='pending'
```

---

## 📝 API Endpoints

### **Frontend Pages**
```
GET  /register.jsp                     → Register with Security Code
GET  /forgot-password.jsp              → Forgot Password form
POST /ForgotPasswordServlet            → Submit forgot password request
```

### **Admin Pages**
```
GET  /admin/PasswordResetServlet       → View requests
POST /admin/PasswordResetServlet       → Mark as read/completed
```

### **API**
```
GET  /api/password-reset-count         → Get pending request count (JSON)
```

---

## 🎯 Next Steps / Future Enhancements

### **Optional Improvements:**
1. ✉️ Email service integration (SendGrid, AWS SES)
2. 🔄 Auto-generate password và gửi tự động
3. 📱 SMS verification thay vì email
4. 🔑 Two-factor authentication (2FA)
5. 📊 Statistics dashboard (số request/ngày)
6. ⏰ Auto-expire requests sau 24h

---

## ✅ Checklist hoàn thành

- [x] Add Security Code to Register
- [x] Update UserDAO with hash function
- [x] Update Forgot Password flow
- [x] Create PasswordResetRequestDAO
- [x] Create Admin reset requests page
- [x] Add notification badge to dashboard
- [x] Create database migration script
- [x] Write comprehensive documentation

---

## 📞 Support

Nếu có vấn đề, check:
1. Database migration đã chạy chưa?
2. Project đã build lại chưa?
3. Lỗi trong browser console?
4. Lỗi trong server logs?

**Happy Coding! 🚀**

