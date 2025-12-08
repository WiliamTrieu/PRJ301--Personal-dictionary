<%-- 
    Document   : suggest-edit
    Created on : Dec 8, 2025
    Author     : PRJ301
    Description: User suggests EDIT to existing word
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đề xuất chỉnh sửa từ - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">✏️ Đề xuất chỉnh sửa từ</h1>
                <p style="color: #52796f; font-weight: 500;">
                    Bạn thấy từ "<strong>${param.wordEnglish}</strong>" có vấn đề? Hãy đề xuất chỉnh sửa!
                </p>
            </div>
            
            <!-- Success/Error messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>
            
            <!-- Form đề xuất chỉnh sửa -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/SuggestEditServlet" method="POST" class="suggest-form">
                    <!-- Hidden fields -->
                    <input type="hidden" name="originalWordId" value="${param.wordId}">
                    <input type="hidden" name="suggestionType" value="edit">
                    
                    <!-- Word English (readonly) -->
                    <div class="form-group">
                        <label for="wordEnglish" class="form-label">
                            Từ tiếng Anh <span class="readonly-label">(không thể sửa)</span>
                        </label>
                        <input type="text" 
                               id="wordEnglish" 
                               name="wordEnglish" 
                               class="form-input readonly-input"
                               value="${param.wordEnglish}"
                               readonly
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label for="wordVietnamese" class="form-label">
                            Nghĩa tiếng Việt <span class="required">*</span>
                        </label>
                        <input type="text" 
                               id="wordVietnamese" 
                               name="wordVietnamese" 
                               class="form-input"
                               placeholder="Sửa nghĩa tiếng Việt"
                               value="${param.wordVietnamese}"
                               required>
                        <p class="field-hint">💡 Sửa lại nghĩa chính xác hơn</p>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="pronunciation" class="form-label">
                                Phiên âm
                            </label>
                            <input type="text" 
                                   id="pronunciation" 
                                   name="pronunciation" 
                                   class="form-input"
                                   placeholder="VD: /ˈælɡərɪðəm/"
                                   value="${param.pronunciation}">
                        </div>
                        
                        <div class="form-group">
                            <label for="wordType" class="form-label">
                                Loại từ
                            </label>
                            <select id="wordType" name="wordType" class="form-input">
                                <option value="">-- Chọn loại từ --</option>
                                <option value="noun" ${param.wordType == 'noun' ? 'selected' : ''}>Danh từ (noun)</option>
                                <option value="verb" ${param.wordType == 'verb' ? 'selected' : ''}>Động từ (verb)</option>
                                <option value="adjective" ${param.wordType == 'adjective' ? 'selected' : ''}>Tính từ (adjective)</option>
                                <option value="adverb" ${param.wordType == 'adverb' ? 'selected' : ''}>Trạng từ (adverb)</option>
                                <option value="preposition" ${param.wordType == 'preposition' ? 'selected' : ''}>Giới từ (preposition)</option>
                                <option value="conjunction" ${param.wordType == 'conjunction' ? 'selected' : ''}>Liên từ (conjunction)</option>
                                <option value="interjection" ${param.wordType == 'interjection' ? 'selected' : ''}>Thán từ (interjection)</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="exampleSentence" class="form-label">
                            Câu ví dụ (tiếng Anh)
                        </label>
                        <textarea id="exampleSentence" 
                                  name="exampleSentence" 
                                  class="form-textarea"
                                  rows="3"
                                  placeholder="Sửa hoặc thêm câu ví dụ mới">${param.exampleSentence}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="exampleTranslation" class="form-label">
                            Bản dịch câu ví dụ (tiếng Việt)
                        </label>
                        <textarea id="exampleTranslation" 
                                  name="exampleTranslation" 
                                  class="form-textarea"
                                  rows="3"
                                  placeholder="Bản dịch câu ví dụ">${param.exampleTranslation}</textarea>
                    </div>
                    
                    <div class="info-box">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                            <path d="M12 16v-4M12 8h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        <div>
                            <strong>Lưu ý:</strong> Đề xuất của bạn sẽ được gửi tới admin để xem xét. 
                            Nếu được duyệt, từ này sẽ được cập nhật theo chỉnh sửa của bạn.
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="submit-btn">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Gửi đề xuất chỉnh sửa
                        </button>
                        <a href="javascript:history.back()" class="cancel-btn">
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .form-container {
            background: linear-gradient(135deg, #ffffff 0%, #fef3c7 100%);
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.15);
            border: 2px solid rgba(245, 158, 11, 0.2);
            max-width: 800px;
            margin: 0 auto;
        }
        
        .suggest-form {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #1f4529;
        }
        
        .readonly-label {
            font-size: 12px;
            font-weight: 500;
            color: #6b7280;
            font-style: italic;
        }
        
        .required {
            color: #dc2626;
        }
        
        .form-input,
        .form-textarea {
            padding: 12px 16px;
            border: 2px solid rgba(245, 158, 11, 0.3);
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
            background: #ffffff;
            color: #1f2937;
            transition: all 0.2s;
        }
        
        .readonly-input {
            background: #f3f4f6;
            color: #6b7280;
            cursor: not-allowed;
            border-color: #d1d5db;
        }
        
        .form-input:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #f59e0b;
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.1);
            background: #fffbeb;
        }
        
        .readonly-input:focus {
            border-color: #d1d5db;
            box-shadow: none;
            background: #f3f4f6;
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .field-hint {
            font-size: 13px;
            color: #6b7280;
            margin: 4px 0 0 0;
        }
        
        .info-box {
            display: flex;
            gap: 12px;
            padding: 16px;
            background: rgba(245, 158, 11, 0.1);
            border-left: 4px solid #f59e0b;
            border-radius: 8px;
            font-size: 14px;
            color: #92400e;
        }
        
        .info-box svg {
            flex-shrink: 0;
            color: #f59e0b;
        }
        
        .form-actions {
            display: flex;
            gap: 16px;
            justify-content: flex-end;
            margin-top: 8px;
        }
        
        .submit-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 32px;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(245, 158, 11, 0.4);
        }
        
        .cancel-btn {
            padding: 14px 32px;
            background: white;
            color: #f59e0b;
            border: 2px solid #f59e0b;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            transition: all 0.3s;
        }
        
        .cancel-btn:hover {
            background: #f59e0b;
            color: white;
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-weight: 500;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #10b981;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #dc2626;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .submit-btn,
            .cancel-btn {
                width: 100%;
            }
        }
    </style>
</body>
</html>

