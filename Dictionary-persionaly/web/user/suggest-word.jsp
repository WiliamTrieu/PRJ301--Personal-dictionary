<%-- 
    Document   : suggest-word
    Created on : Dec 5, 2025
    Author     : PRJ301
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đề xuất từ mới - Eden Dictionary</title>
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
                <h1 class="welcome-message">Đề xuất từ mới</h1>
                <p style="color: #52796f; font-weight: 500;">Gửi đề xuất từ chưa có trong từ điển</p>
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
            
            <!-- Form đề xuất từ -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/SuggestionServlet" method="POST" class="suggest-form">
                    <div class="form-group">
                        <label for="wordEnglish" class="form-label">
                            Từ tiếng Anh <span class="required">*</span>
                        </label>
                        <input type="text" 
                               id="wordEnglish" 
                               name="wordEnglish" 
                               class="form-input"
                               placeholder="VD: algorithm"
                               value="${wordEnglish != null ? wordEnglish : prefillWord}"
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
                               placeholder="VD: thuật toán"
                               value="${wordVietnamese}"
                               required>
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
                                   value="${pronunciation}">
                        </div>
                        
                        <div class="form-group">
                            <label for="wordType" class="form-label">
                                Loại từ
                            </label>
                            <select id="wordType" name="wordType" class="form-input">
                                <option value="">-- Chọn loại từ --</option>
                                <option value="noun" ${wordType == 'noun' ? 'selected' : ''}>Danh từ (noun)</option>
                                <option value="verb" ${wordType == 'verb' ? 'selected' : ''}>Động từ (verb)</option>
                                <option value="adjective" ${wordType == 'adjective' ? 'selected' : ''}>Tính từ (adjective)</option>
                                <option value="adverb" ${wordType == 'adverb' ? 'selected' : ''}>Trạng từ (adverb)</option>
                                <option value="preposition" ${wordType == 'preposition' ? 'selected' : ''}>Giới từ (preposition)</option>
                                <option value="conjunction" ${wordType == 'conjunction' ? 'selected' : ''}>Liên từ (conjunction)</option>
                                <option value="interjection" ${wordType == 'interjection' ? 'selected' : ''}>Thán từ (interjection)</option>
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
                                  placeholder="VD: This algorithm is very efficient.">${exampleSentence}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="exampleTranslation" class="form-label">
                            Bản dịch câu ví dụ (tiếng Việt)
                        </label>
                        <textarea id="exampleTranslation" 
                                  name="exampleTranslation" 
                                  class="form-textarea"
                                  rows="3"
                                  placeholder="VD: Thuật toán này rất hiệu quả.">${exampleTranslation}</textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="submit-btn">
                            ➕ Gửi đề xuất
                        </button>
                        <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="cancel-btn">
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
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 1px solid rgba(45, 90, 61, 0.1);
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
        
        .required {
            color: #dc2626;
        }
        
        .form-input,
        .form-textarea {
            padding: 12px 16px;
            border: 2px solid rgba(45, 90, 61, 0.2);
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
            background: #ffffff;
            color: #1f2937;
            transition: all 0.2s;
        }
        
        .form-input:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #2d5a3d;
            box-shadow: 0 0 0 4px rgba(45, 90, 61, 0.1);
            background: #f0fdf4;
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .form-actions {
            display: flex;
            gap: 16px;
            justify-content: flex-end;
            margin-top: 8px;
        }
        
        .submit-btn {
            padding: 14px 32px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.4);
        }
        
        .cancel-btn {
            padding: 14px 32px;
            background: white;
            color: #2d5a3d;
            border: 2px solid #2d5a3d;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            transition: all 0.3s;
        }
        
        .cancel-btn:hover {
            background: #2d5a3d;
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

