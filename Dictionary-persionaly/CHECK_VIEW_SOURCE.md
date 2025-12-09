# 🔍 CHECK VIEW PAGE SOURCE

## 📋 **NEXT STEP:**

Database có word_id = 453, 318, 462 (✅ VALID!)

Nhưng web vẫn báo "Invalid word ID"

→ Vấn đề là **JSP render hoặc JavaScript call sai**!

---

## 🎯 **LÀM NGAY:**

### **1. View Page Source:**
```
1. Ở trang kết quả search "admit"
2. Right-click → View Page Source (Ctrl + U)
3. Search for "<!-- DEBUG:" (Ctrl + F)
4. Xem dòng này:
   <!-- wordId = ??? | wordEnglish = admit -->
```

**Bạn sẽ thấy 1 trong 3 TH:**

#### **Case A: wordId có giá trị**
```html
<!-- wordId = 453 | wordEnglish = admit -->
<button onclick="saveWord(453, this)" ...>
```
✅ JSP render đúng → Vấn đề ở JavaScript hoặc Servlet

#### **Case B: wordId = 0**
```html
<!-- wordId = 0 | wordEnglish = admit -->
<button onclick="saveWord(0, this)" ...>
```
❌ Word object không có wordId → Vấn đề ở WordDAO

#### **Case C: wordId trống**
```html
<!-- wordId =  | wordEnglish = admit -->
<button onclick="saveWord(, this)" ...>
```
❌ wordId là null → Vấn đề ở WordDAO hoặc Model

---

## 🛠️ **TÙY THEO KẾT QUẢ:**

### **Nếu Case A (wordId = 453):**
Vấn đề là SaveWordServlet không nhận đúng parameter.

Check F12 Console → Network tab:
- Click Save button
- Xem request POST to `/SaveWordServlet`
- Check Form Data: `action=save&wordId=???`

**Fix:** Có thể là parameter name sai!

### **Nếu Case B hoặc C (wordId = 0 hoặc trống):**
WordDAO không set wordId vào Word object.

**Fix ngay:**

