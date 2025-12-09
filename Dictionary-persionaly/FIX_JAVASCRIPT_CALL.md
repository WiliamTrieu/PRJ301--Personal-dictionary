# 🔧 FIX: JavaScript Call Issue

## 🎯 **PROBLEM IDENTIFIED:**

Database có word_id hợp lệ (453, 318, 462) nhưng vẫn báo "Invalid word ID"

→ **Vấn đề: JavaScript không gửi đúng parameter!**

---

## 🔍 **DEBUG: Check Network Tab**

1. F12 → Network tab
2. Click "⭐ Lưu vào từ điển của tôi"
3. Xem request POST to `SaveWordServlet`
4. Click vào request → Headers tab → Scroll to "Form Data"

**Bạn sẽ thấy:**

### **Case A: Missing wordId**
```
action: save
wordId: (empty hoặc undefined)
```
❌ JavaScript không truyền wordId!

### **Case B: wordId = 0**
```
action: save
wordId: 0
```
❌ JSP render wordId = 0!

### **Case C: Valid wordId**
```
action: save
wordId: 453
```
✅ Gửi đúng → Vấn đề ở Servlet validate logic!

---

## 🛠️ **FIX NOW:**

### **PROBLEM:** onclick attribute có thể bị lỗi với số 0

JSP hiện tại:
```jsp
<button onclick="saveWord(${word.wordId}, this)" ...>
```

Nếu `word.wordId` = 0 (primitive int default value):
```html
<button onclick="saveWord(0, this)" ...>
```

SaveWordServlet check:
```java
if (wordIdStr == null || wordIdStr.trim().isEmpty()) {
    // Nhưng "0" không phải empty!
}

int wordId = Integer.parseInt(wordIdStr);  // wordId = 0
// 0 là valid integer nhưng invalid database ID!
```

**Solution: Add validation for wordId <= 0**

