<%-- 
    Document   : approval-list
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
    <title>Duyệt đề xuất - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <c:if test="${suggestions == null}">
        <c:redirect url="${pageContext.request.contextPath}/admin/ApprovalListServlet"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Duyệt đề xuất từ</h1>
                <p style="color: #52796f; font-weight: 500;">
                    Đề xuất chờ duyệt: <strong>${pendingCount != null ? pendingCount : 0}</strong>
                </p>
            </div>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <!-- Action buttons -->
            <div class="action-bar">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="action-btn back-btn">
                ← Quay lại Dashboard
            </a>
            </div>
            
            <!-- Suggestions list -->
            <c:choose>
                <c:when test="${not empty suggestions && suggestions.size() > 0}">
                    <div class="suggestions-list">
                        <c:forEach var="suggestion" items="${suggestions}">
                            <div class="suggestion-card">
                                <div class="suggestion-header">
                                    <div class="suggestion-word">
                                        <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 8px;">
                                            <c:choose>
                                                <c:when test="${suggestion.suggestionType == 'edit'}">
                                                    <span class="badge badge-edit">
                                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" style="display: inline;">
                                                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                        CHỈNH SỬA
                                                    </span>
                                                    <span class="edit-info">
                                                        🔄 Sửa từ ID: ${suggestion.originalWordId}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-new">
                                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" style="display: inline;">
                                                            <path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                                        </svg>
                                                        MỚI
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <h3 class="word-english">${suggestion.wordEnglish}</h3>
                                        <p class="word-vietnamese">${suggestion.wordVietnamese}</p>
                                    </div>
                                    <div class="suggestion-meta">
                                        <p class="suggested-by">Đề xuất bởi: <strong>${suggestion.suggestedByName != null ? suggestion.suggestedByName : 'N/A'}</strong></p>
                                        <p class="suggestion-date">
                                            <fmt:formatDate value="${suggestion.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="suggestion-details">
                                    <c:if test="${not empty suggestion.pronunciation}">
                                        <p><strong>Phiên âm:</strong> ${suggestion.pronunciation}</p>
                                    </c:if>
                                    <c:if test="${not empty suggestion.wordType}">
                                        <p><strong>Loại từ:</strong> ${suggestion.wordType}</p>
                                    </c:if>
                                    <c:if test="${not empty suggestion.exampleSentence}">
                                        <p><strong>Ví dụ:</strong> ${suggestion.exampleSentence}</p>
                                        <c:if test="${not empty suggestion.exampleTranslation}">
                                            <p class="example-translation">${suggestion.exampleTranslation}</p>
                                        </c:if>
                                    </c:if>
                                </div>
                                
                                <div class="suggestion-actions">
                                    <form action="${pageContext.request.contextPath}/admin/ApprovalServlet" method="POST" class="approve-form">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="suggestionId" value="${suggestion.suggestionId}">
                                        <input type="hidden" name="reviewNote" value="">
                                        <button type="submit" class="approve-btn" onclick="return confirm('Bạn có chắc muốn chấp nhận đề xuất này?');">
                                            ✅ Chấp nhận
                                        </button>
                                    </form>
                                    
                                    <form action="${pageContext.request.contextPath}/admin/ApprovalServlet" method="POST" class="reject-form">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="suggestionId" value="${suggestion.suggestionId}">
                                        <input type="text" 
                                               name="reviewNote" 
                                               class="review-note-input" 
                                               placeholder="Lý do từ chối..." 
                                               required>
                                        <button type="submit" class="reject-btn">
                                            ❌ Từ chối
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-suggestions">
                        <div class="no-suggestions-icon">✅</div>
                        <h2 style="color: #52796f; margin: 16px 0 8px;">Không có đề xuất chờ duyệt</h2>
                        <p style="color: #6b7280;">
                            Tất cả đề xuất đã được duyệt hoặc chưa có đề xuất nào.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .suggestions-list {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }
        
        .suggestion-card {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 1px solid rgba(45, 90, 61, 0.1);
            transition: all 0.3s ease;
        }
        
        .suggestion-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(45, 90, 61, 0.15);
        }
        
        .suggestion-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 16px;
            flex-wrap: wrap;
            gap: 12px;
        }
        
        .suggestion-word {
            flex: 1;
        }
        
        .word-english {
            font-size: 24px;
            font-weight: 700;
            color: #1f4529;
            margin: 0 0 4px 0;
        }
        
        .word-vietnamese {
            font-size: 18px;
            color: #2d5a3d;
            margin: 0;
            font-weight: 500;
        }
        
        .suggestion-meta {
            text-align: right;
        }
        
        .suggested-by {
            color: #6b7280;
            font-size: 14px;
            margin: 0 0 4px 0;
        }
        
        .suggestion-date {
            color: #9ca3af;
            font-size: 13px;
            margin: 0;
        }
        
        .suggestion-details {
            margin-bottom: 20px;
            padding-top: 16px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
        }
        
        .suggestion-details p {
            margin: 8px 0;
            color: #374151;
            font-size: 15px;
        }
        
        .example-translation {
            color: #6b7280 !important;
            font-style: italic;
            margin-left: 24px !important;
        }
        
        .suggestion-actions {
            display: flex;
            gap: 12px;
            padding-top: 16px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
            flex-wrap: wrap;
        }
        
        .approve-form,
        .reject-form {
            display: flex;
            gap: 8px;
            flex: 1;
            min-width: 200px;
        }
        
        .review-note-input {
            flex: 1;
            padding: 10px 12px;
            border: 2px solid rgba(45, 90, 61, 0.2);
            border-radius: 6px;
            font-size: 14px;
        }
        
        .review-note-input:focus {
            outline: none;
            border-color: #dc2626;
        }
        
        .approve-btn,
        .reject-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            white-space: nowrap;
        }
        
        .approve-btn {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }
        
        .approve-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        
        .reject-btn {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            color: white;
        }
        
        .reject-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }
        
        .no-suggestions {
            text-align: center;
            padding: 48px 24px;
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
        }
        
        .no-suggestions-icon {
            font-size: 64px;
            margin-bottom: 16px;
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
        
        /* Suggestion Type Badges */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .badge-new {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
        }
        
        .badge-edit {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(245, 158, 11, 0.3);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.02);
                opacity: 0.95;
            }
        }
        
        .edit-info {
            font-size: 13px;
            color: #f59e0b;
            font-weight: 600;
            background: rgba(245, 158, 11, 0.1);
            padding: 4px 12px;
            border-radius: 8px;
        }
        
        @media (max-width: 768px) {
            .suggestion-header {
                flex-direction: column;
            }
            
            .suggestion-meta {
                text-align: left;
            }
            
            .suggestion-actions {
                flex-direction: column;
            }
            
            .approve-form,
            .reject-form {
                flex-direction: column;
            }
        }
    </style>
</body>
</html>

