<%-- 
    Document   : search-result
    Created on : Dec 5, 2025
    Author     : PRJ301
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/autocomplete.css">
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
                           data-autocomplete="true"
                           autocomplete="off"
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
                            <!-- DEBUG: Check word object -->
                            <div style="display:none;">
                                word object: ${word}
                                wordId: ${word.wordId}
                                wordEnglish: ${word.wordEnglish}
                                getter test: ${word.getWordId()}
                            </div>
                            
                            <div class="word-card">
                                <div class="word-header">
                                    <h2 class="word-english">${word.wordEnglish}</h2>
                                    <c:if test="${not empty word.pronunciation and not fn:contains(word.pronunciation, '?')}">
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
                                
                                <!-- DEBUG: Check wordId value -->
                                <!-- wordId = ${word.wordId} | wordEnglish = ${word.wordEnglish} | Valid: ${word.wordId > 0} -->
                                
                                <!-- Word Actions -->
                                <div class="word-actions">
                                    <!-- Save to My Dictionary Button -->
                                    <c:if test="${word.wordId > 0}">
                                        <button onclick="saveWord(${word.wordId}, this)" 
                                                class="save-word-btn"
                                                data-word-id="${word.wordId}">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" class="star-icon">
                                                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            <span class="save-text">Lưu vào từ điển của tôi</span>
                                        </button>
                                    </c:if>
                                    
                                    <c:if test="${word.wordId <= 0}">
                                        <button class="save-word-btn" disabled style="opacity: 0.5; cursor: not-allowed;">
                                            <span>⚠️ Invalid word ID (${word.wordId})</span>
                                        </button>
                                    </c:if>
                                    
                                    <!-- Suggest Edit Button -->
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
                    <div class="empty-state">
                        <div class="empty-illustration">
                            <svg width="120" height="120" viewBox="0 0 120 120" fill="none">
                                <circle cx="60" cy="60" r="50" fill="#f0fdf4" stroke="#2d5a3d" stroke-width="2"/>
                                <circle cx="45" cy="50" r="12" fill="#2d5a3d"/>
                                <circle cx="75" cy="50" r="12" fill="#2d5a3d"/>
                                <path d="M40 75 Q60 65 80 75" stroke="#2d5a3d" stroke-width="3" stroke-linecap="round" fill="none"/>
                            </svg>
                        </div>
                        <h2 class="empty-title">Không tìm thấy từ "${keyword}"</h2>
                        <p class="empty-description">
                            Từ này chưa có trong từ điển. Bạn có muốn đóng góp không?
                        </p>
                        <div class="empty-actions">
                            <a href="${pageContext.request.contextPath}/user/suggest-word.jsp?word=${keyword}" 
                               class="btn-empty-primary">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                    <path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                </svg>
                                Đề xuất từ này
                            </a>
                            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" 
                               class="btn-empty-secondary">
                                Tìm từ khác
                            </a>
                        </div>
                        <div class="empty-tips">
                            <p class="tips-title">💡 Gợi ý:</p>
                            <ul class="tips-list">
                                <li>Kiểm tra chính tả của từ</li>
                                <li>Thử tìm từ đồng nghĩa</li>
                                <li>Tìm bằng tiếng Việt thay vì tiếng Anh</li>
                            </ul>
                        </div>
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
        
        /* Empty State Styles */
        .empty-state {
            text-align: center;
            padding: 60px 24px;
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 2px dashed rgba(45, 90, 61, 0.2);
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .empty-illustration {
            margin: 0 auto 24px;
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .empty-title {
            font-size: 28px;
            font-weight: 700;
            color: #1f4529;
            margin-bottom: 12px;
        }
        
        .empty-description {
            font-size: 16px;
            color: #6b7280;
            margin-bottom: 32px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .empty-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 32px;
        }
        
        .btn-empty-primary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .btn-empty-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.4);
        }
        
        .btn-empty-secondary {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 14px 28px;
            background: white;
            color: #2d5a3d;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            border: 2px solid #2d5a3d;
            transition: all 0.3s;
        }
        
        .btn-empty-secondary:hover {
            background: #2d5a3d;
            color: white;
            transform: translateY(-2px);
        }
        
        .empty-tips {
            background: rgba(45, 90, 61, 0.05);
            padding: 20px;
            border-radius: 12px;
            max-width: 400px;
            margin: 0 auto;
            text-align: left;
        }
        
        .tips-title {
            font-weight: 600;
            color: #2d5a3d;
            margin-bottom: 12px;
            font-size: 15px;
        }
        
        .tips-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .tips-list li {
            padding: 6px 0;
            color: #52796f;
            font-size: 14px;
            position: relative;
            padding-left: 20px;
        }
        
        .tips-list li::before {
            content: '•';
            position: absolute;
            left: 0;
            color: #2d5a3d;
            font-weight: bold;
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
            gap: 12px;
            justify-content: flex-end;
            flex-wrap: wrap;
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
        
        /* Save Word Button */
        .save-word-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        
        .save-word-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
        }
        
        .save-word-btn:active {
            transform: translateY(0);
        }
        
        .save-word-btn.saved {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }
        
        .save-word-btn.saved:hover {
            box-shadow: 0 6px 16px rgba(245, 158, 11, 0.4);
        }
        
        .star-icon {
            transition: transform 0.3s;
        }
        
        .save-word-btn:hover .star-icon {
            transform: scale(1.2) rotate(15deg);
        }
        
        /* Toast Notifications */
        .toast {
            position: fixed;
            top: 90px;
            right: 24px;
            padding: 16px 24px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            z-index: 10000;
            opacity: 0;
            transform: translateX(400px);
            transition: all 0.3s ease-out;
        }
        
        .toast.show {
            opacity: 1;
            transform: translateX(0);
        }
        
        .toast-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }
        
        .toast-info {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
        }
        
        .toast-error {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
        }
        
        @media (max-width: 768px) {
            .word-actions {
                justify-content: center;
            }
            
            .toast {
                right: 16px;
                left: 16px;
                top: 80px;
            }
        }
    </style>
    
    <script>
        // Context path for AJAX calls
        const contextPath = '${pageContext.request.contextPath}';
        
        // Save word to My Dictionary
        async function saveWord(wordId, button) {
            try {
                // Get wordId from data attribute (most reliable)
                const dataWordId = button.getAttribute('data-word-id');
                const finalId = dataWordId || wordId;
                
                console.log('saveWord called - wordId:', wordId, 'dataWordId:', dataWordId, 'finalId:', finalId);
                
                // Validate
                if (!finalId || isNaN(Number(finalId)) || Number(finalId) <= 0) {
                    console.error('Invalid wordId:', finalId);
                    showNotification('Invalid word ID', 'error');
                    return;
                }
                
                const response = await fetch(contextPath + '/SaveWordServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=save&wordId=' + finalId
                });
                
                const result = await response.json();
                
                if (result.success) {
                    // Update button UI
                    button.classList.add('saved');
                    button.querySelector('.save-text').textContent = 'Đã lưu ⭐';
                    button.querySelector('.star-icon path').setAttribute('fill', 'currentColor');
                    
                    // Change to unsave action
                    button.setAttribute('onclick', 'unsaveWord(' + finalId + ', this)');
                    
                    // Show success message
                    showNotification(result.message, 'success');
                } else {
                    showNotification(result.message, 'info');
                }
            } catch (error) {
                console.error('Error saving word:', error);
                showNotification('Không thể lưu từ. Vui lòng thử lại.', 'error');
            }
        }
        
        // Unsave word from My Dictionary
        async function unsaveWord(wordId, button) {
            try {
                // Get wordId from data attribute (most reliable)
                const dataWordId = button.getAttribute('data-word-id');
                const finalId = dataWordId || wordId;
                
                console.log('unsaveWord called - finalId:', finalId);
                
                if (!finalId || isNaN(Number(finalId)) || Number(finalId) <= 0) {
                    console.error('Invalid wordId:', finalId);
                    showNotification('Invalid word ID', 'error');
                    return;
                }
                
                const response = await fetch(contextPath + '/SaveWordServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=unsave&wordId=' + finalId
                });
                
                const result = await response.json();
                
                if (result.success) {
                    // Update button UI
                    button.classList.remove('saved');
                    button.querySelector('.save-text').textContent = 'Lưu vào từ điển của tôi';
                    button.querySelector('.star-icon path').setAttribute('fill', 'none');
                    
                    // Change back to save action
                    button.setAttribute('onclick', 'saveWord(' + finalId + ', this)');
                    
                    // Show success message
                    showNotification(result.message, 'info');
                }
            } catch (error) {
                console.error('Error unsaving word:', error);
                showNotification('Không thể xóa từ. Vui lòng thử lại.', 'error');
            }
        }
        
        // Show notification toast
        function showNotification(message, type) {
            // Create toast element
            const toast = document.createElement('div');
            toast.className = 'toast toast-' + type;
            toast.textContent = message;
            document.body.appendChild(toast);
            
            // Show toast
            setTimeout(() => toast.classList.add('show'), 100);
            
            // Hide and remove toast
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
        
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
    
    <!-- Autocomplete Script -->
    <script src="${pageContext.request.contextPath}/js/autocomplete.js"></script>
</body>
</html>

