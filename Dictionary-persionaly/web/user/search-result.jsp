<%-- 
    Document   : search-result
    Created on : Dec 5, 2025
    Author     : PRJ301
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm - Eden Dictionary</title>
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
                <h1 class="welcome-message">Kết quả tìm kiếm</h1>
                <c:if test="${not empty keyword}">
                    <p style="color: #52796f; font-weight: 500;">
                        Tìm kiếm: "<strong>${keyword}</strong>"
                    </p>
                </c:if>
            </div>
            
            <!-- Search form lại -->
            <div class="search-section">
                <form action="${pageContext.request.contextPath}/SearchServlet" method="GET" class="search-form">
                    <input type="text" 
                           name="keyword" 
                           class="search-input" 
                           placeholder="Nhập từ tiếng Anh hoặc tiếng Việt..." 
                           value="${keyword}"
                           required>
                    <button type="submit" class="search-btn">Tìm kiếm</button>
                </form>
            </div>
            
            <!-- Kết quả tìm kiếm -->
            <c:choose>
                <c:when test="${not empty words and resultCount > 0}">
                    <div class="result-info">
                        <p style="color: #52796f; margin-bottom: 20px;">
                            Tìm thấy <strong>${resultCount}</strong> kết quả
                        </p>
                    </div>
                    
                    <div class="words-list">
                        <c:forEach var="word" items="${words}">
                            <div class="word-card">
                                <div class="word-header">
                                    <h2 class="word-english">${word.wordEnglish}</h2>
                                    <c:if test="${not empty word.pronunciation}">
                                        <span class="word-pronunciation">${word.pronunciation}</span>
                                    </c:if>
                                </div>
                                
                                <div class="word-meaning">
                                    <p class="word-vietnamese">${word.wordVietnamese}</p>
                                    <c:if test="${not empty word.wordType}">
                                        <span class="word-type">(${word.wordType})</span>
                                    </c:if>
                                </div>
                                
                                <c:if test="${not empty word.exampleSentence}">
                                    <div class="word-example">
                                        <p class="example-label">Ví dụ:</p>
                                        <p class="example-sentence">${word.exampleSentence}</p>
                                        <c:if test="${not empty word.exampleTranslation}">
                                            <p class="example-translation">${word.exampleTranslation}</p>
                                        </c:if>
                                    </div>
                                </c:if>
                                
                                <!-- Suggest Edit Button - FIXED -->
                                <div class="word-actions">
                                    <button onclick="suggestEditWord(this)" 
                                            class="edit-suggestion-btn"
                                            data-word-id="${word.wordId}"
                                            data-word-english="${word.wordEnglish}"
                                            data-word-vietnamese="${word.wordVietnamese}"
                                            data-pronunciation="${word.pronunciation}"
                                            data-word-type="${word.wordType}"
                                            data-example-sentence="${word.exampleSentence}"
                                            data-example-translation="${word.exampleTranslation}">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Đề xuất chỉnh sửa
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <div class="no-results-icon">🔍</div>
                        <h2 style="color: #52796f; margin: 16px 0 8px;">Không tìm thấy kết quả</h2>
                        <p style="color: #6b7280; margin-bottom: 24px;">
                            Không tìm thấy từ "<strong>${keyword}</strong>" trong từ điển.
                        </p>
                        <a href="${pageContext.request.contextPath}/user/suggest-word.jsp?word=${keyword}" 
                           class="suggest-link">
                            ➕ Đề xuất thêm từ này vào từ điển
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Button quay lại -->
            <div style="margin-top: 32px; text-align: center;">
                <a href="${pageContext.request.contextPath}/user/dashboard.jsp" 
                   class="back-btn">
                    ← Quay lại trang chủ
                </a>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .result-info {
            margin-bottom: 24px;
        }
        
        .words-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .word-card {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 1px solid rgba(45, 90, 61, 0.1);
            transition: all 0.3s ease;
        }
        
        .word-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(45, 90, 61, 0.15);
        }
        
        .word-header {
            display: flex;
            align-items: baseline;
            gap: 12px;
            margin-bottom: 12px;
        }
        
        .word-english {
            font-size: 28px;
            font-weight: 700;
            color: #1f4529;
            margin: 0;
        }
        
        .word-pronunciation {
            font-size: 16px;
            color: #52796f;
            font-style: italic;
        }
        
        .word-meaning {
            display: flex;
            align-items: baseline;
            gap: 8px;
            margin-bottom: 16px;
        }
        
        .word-vietnamese {
            font-size: 20px;
            font-weight: 600;
            color: #2d5a3d;
            margin: 0;
        }
        
        .word-type {
            font-size: 14px;
            color: #52796f;
            font-style: italic;
        }
        
        .word-example {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
        }
        
        .example-label {
            font-size: 14px;
            font-weight: 600;
            color: #52796f;
            margin-bottom: 8px;
        }
        
        .example-sentence {
            font-size: 16px;
            color: #1f2937;
            margin-bottom: 4px;
            font-style: italic;
        }
        
        .example-translation {
            font-size: 15px;
            color: #6b7280;
            margin: 0;
        }
        
        .no-results {
            text-align: center;
            padding: 48px 24px;
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
        }
        
        .no-results-icon {
            font-size: 64px;
            margin-bottom: 16px;
        }
        
        .suggest-link {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .suggest-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.4);
        }
        
        .back-btn {
            display: inline-block;
            padding: 12px 24px;
            background: white;
            color: #2d5a3d;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            border: 2px solid #2d5a3d;
            transition: all 0.3s;
        }
        
        .back-btn:hover {
            background: #2d5a3d;
            color: white;
        }
        
        /* Suggest Edit Button Styles */
        .word-actions {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
            display: flex;
            justify-content: flex-end;
        }
        
        .edit-suggestion-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }
        
        .edit-suggestion-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(245, 158, 11, 0.4);
        }
        
        .edit-suggestion-btn:active {
            transform: translateY(0);
        }
    </style>
    
    <script>
        function suggestEditWord(button) {
            // Get data from button attributes (safer method - no escaping issues)
            const wordId = button.getAttribute('data-word-id');
            const wordEnglish = button.getAttribute('data-word-english') || '';
            const wordVietnamese = button.getAttribute('data-word-vietnamese') || '';
            const pronunciation = button.getAttribute('data-pronunciation') || '';
            const wordType = button.getAttribute('data-word-type') || '';
            const exampleSentence = button.getAttribute('data-example-sentence') || '';
            const exampleTranslation = button.getAttribute('data-example-translation') || '';
            
            // Build URL with encoded parameters
            const params = new URLSearchParams({
                wordId: wordId,
                wordEnglish: wordEnglish,
                wordVietnamese: wordVietnamese,
                pronunciation: pronunciation,
                wordType: wordType,
                exampleSentence: exampleSentence,
                exampleTranslation: exampleTranslation
            });
            
            // Redirect to suggest-edit page
            window.location.href = '${pageContext.request.contextPath}/user/suggest-edit.jsp?' + params.toString();
        }
    </script>
</body>
</html>

