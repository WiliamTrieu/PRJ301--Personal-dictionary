<%-- 
    Document   : my-saved-words
    Created on : Dec 8, 2025
    Author     : PRJ301
    Description: User's personal vocabulary collection
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
    <title>Từ điển của tôi - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <%-- Redirect if accessed directly without data --%>
    <c:if test="${savedWords == null}">
        <c:redirect url="${pageContext.request.contextPath}/MySavedWordsServlet"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">⭐ Từ điển của tôi</h1>
                <p style="color: #52796f; font-weight: 500;">
                    Bộ từ vựng cá nhân của bạn - <strong>${totalCount}</strong> từ
                </p>
            </div>
            
            <!-- Statistics Card -->
            <c:if test="${totalCount > 0}">
                <div class="stats-card-personal" style="justify-content: center;">
                    <div class="stat-item-personal">
                        <div class="stat-icon-personal">📚</div>
                        <div class="stat-content-personal">
                            <div class="stat-number-personal">${totalCount}</div>
                            <div class="stat-label-personal">Tổng số từ đã lưu</div>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Saved Words List -->
            <c:choose>
                <c:when test="${not empty savedWords && totalCount > 0}">
                    <div class="saved-words-list">
                        <c:forEach var="saved" items="${savedWords}">
                            <div class="saved-word-card">
                                <div class="word-header">
                                    <div class="word-title">
                                        <h2 class="word-english">${saved.wordEnglish}</h2>
                                        <c:if test="${not empty saved.pronunciation and not fn:contains(saved.pronunciation, '?')}">
                                            <span class="word-pronunciation">${saved.pronunciation}</span>
                                        </c:if>
                                    </div>
                                    <button onclick="removeSavedWord(${saved.wordId}, this)" 
                                            class="unsave-btn"
                                            title="Xóa khỏi từ điển của tôi">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                            <path d="M18 6L6 18M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                        </svg>
                                    </button>
                                </div>
                                
                                <div class="word-meaning">
                                    <p class="word-vietnamese">${saved.wordVietnamese}</p>
                                    <c:if test="${not empty saved.wordType}">
                                        <span class="word-type">(${saved.wordType})</span>
                                    </c:if>
                                </div>
                                
                                <c:if test="${not empty saved.exampleSentence}">
                                    <div class="word-example">
                                        <p class="example-label">Ví dụ:</p>
                                        <p class="example-sentence">${saved.exampleSentence}</p>
                                        <c:if test="${not empty saved.exampleTranslation}">
                                            <p class="example-translation">${saved.exampleTranslation}</p>
                                        </c:if>
                                    </div>
                                </c:if>
                                
                                <!-- Personal Note -->
                                <c:if test="${not empty saved.personalNote}">
                                    <div class="personal-note">
                                        <span class="note-icon">📝</span>
                                        <span class="note-text">${saved.personalNote}</span>
                                    </div>
                                </c:if>
                                
                                <!-- Meta Info -->
                                <div class="word-meta">
                                    <span class="saved-date">
                                        Đã lưu: <fmt:formatDate value="${saved.savedAt}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state-saved">
                        <div class="empty-illustration-saved">
                            <svg width="140" height="140" viewBox="0 0 140 140" fill="none">
                                <circle cx="70" cy="70" r="50" fill="#f0fdf4" stroke="#2d5a3d" stroke-width="2"/>
                                <path d="M70 45 L80 65 L102 68 L86 83 L90 105 L70 95 L50 105 L54 83 L38 68 L60 65 Z" fill="#2d5a3d"/>
                            </svg>
                        </div>
                        <h2 class="empty-title-saved">Chưa có từ nào được lưu</h2>
                        <p class="empty-description-saved">
                            Bắt đầu xây dựng bộ từ vựng riêng của bạn!<br>
                            Tìm kiếm từ và click "⭐ Lưu vào từ điển của tôi"
                        </p>
                        <div class="empty-actions-saved">
                            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" 
                               class="btn-empty-primary-saved">
                                🔍 Tìm kiếm từ
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Back Button -->
            <div style="margin-top: 32px; text-align: center;">
                <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="back-btn-saved">
                    ← Quay lại trang chủ
                </a>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        /* Stats Card */
        .stats-card-personal {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }
        
        .stat-item-personal {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 24px;
            border-radius: 12px;
            border: 1px solid rgba(45, 90, 61, 0.1);
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
        }
        
        .stat-icon-personal {
            font-size: 32px;
        }
        
        .stat-number-personal {
            font-size: 32px;
            font-weight: 800;
            color: #2d5a3d;
        }
        
        .stat-label-personal {
            font-size: 13px;
            color: #6b7280;
            font-weight: 500;
        }
        
        /* Saved Words List */
        .saved-words-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .saved-word-card {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 1px solid rgba(45, 90, 61, 0.1);
            transition: all 0.3s;
        }
        
        .saved-word-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.15);
        }
        
        .word-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }
        
        .word-title {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .word-english {
            font-size: 24px;
            font-weight: 700;
            color: #1f4529;
            margin: 0;
        }
        
        .word-pronunciation {
            font-size: 16px;
            color: #52796f;
            font-style: italic;
        }
        
        .unsave-btn {
            background: #fee2e2;
            color: #dc2626;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .unsave-btn:hover {
            background: #dc2626;
            color: white;
            transform: rotate(90deg);
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
        
        /* Personal Note */
        .personal-note {
            margin-top: 12px;
            padding: 12px 16px;
            background: rgba(245, 158, 11, 0.1);
            border-left: 4px solid #f59e0b;
            border-radius: 8px;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }
        
        .note-icon {
            font-size: 16px;
        }
        
        .note-text {
            color: #92400e;
            font-size: 14px;
            line-height: 1.6;
        }
        
        /* Meta Info */
        .word-meta {
            margin-top: 16px;
            padding-top: 12px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .saved-date {
            color: #6b7280;
            font-size: 13px;
        }
        
        .mastery-badge {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
        }
        
        /* Empty State */
        .empty-state-saved {
            text-align: center;
            padding: 60px 24px;
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 2px dashed rgba(45, 90, 61, 0.2);
        }
        
        .empty-illustration-saved {
            margin: 0 auto 24px;
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .empty-title-saved {
            font-size: 28px;
            font-weight: 700;
            color: #1f4529;
            margin-bottom: 12px;
        }
        
        .empty-description-saved {
            font-size: 16px;
            color: #6b7280;
            margin-bottom: 32px;
            line-height: 1.8;
        }
        
        .empty-actions-saved {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        
        .btn-empty-primary-saved {
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
        
        .btn-empty-primary-saved:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.4);
        }
        
        .back-btn-saved {
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
        
        .back-btn-saved:hover {
            background: #2d5a3d;
            color: white;
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
        
        /* Responsive */
        @media (max-width: 768px) {
            .stats-card-personal {
                grid-template-columns: 1fr;
            }
            
            .word-title {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .toast {
                right: 16px;
                left: 16px;
            }
        }
    </style>
    
    <script>
        // Remove word from saved words
        async function removeSavedWord(wordId, button) {
            if (!confirm('Bạn có chắc muốn xóa từ này khỏi từ điển của bạn?')) {
                return;
            }
            
            try {
                const response = await fetch('${pageContext.request.contextPath}/SaveWordServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=unsave&wordId=${wordId}`
                });
                
                const result = await response.json();
                
                if (result.success) {
                    // Remove card with animation
                    const card = button.closest('.saved-word-card');
                    card.style.opacity = '0';
                    card.style.transform = 'translateX(100px)';
                    
                    setTimeout(() => {
                        card.remove();
                        
                        // Reload if no words left
                        const remaining = document.querySelectorAll('.saved-word-card').length;
                        if (remaining === 0) {
                            location.reload();
                        }
                    }, 300);
                    
                    showNotification('Đã xóa khỏi từ điển của bạn', 'info');
                } else {
                    showNotification('Không thể xóa từ này', 'error');
                }
            } catch (error) {
                console.error('Error removing word:', error);
                showNotification('Đã xảy ra lỗi', 'error');
            }
        }
        
        // Show notification toast
        function showNotification(message, type) {
            const toast = document.createElement('div');
            toast.className = `toast toast-${type}`;
            toast.textContent = message;
            document.body.appendChild(toast);
            
            setTimeout(() => toast.classList.add('show'), 100);
            
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
    </script>
</body>
</html>

