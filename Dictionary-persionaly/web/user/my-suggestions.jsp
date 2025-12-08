<%-- 
    Document   : my-suggestions
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
    <title>Đề xuất của tôi - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <%-- Redirect về Servlet nếu truy cập trực tiếp JSP (không có totalCount) --%>
    <c:if test="${totalCount == null}">
        <c:redirect url="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Đề xuất của tôi</h1>
                <p style="color: #52796f; font-weight: 500;">Xem trạng thái các đề xuất bạn đã gửi</p>
            </div>
            
            <!-- Statistics Summary -->
            <c:if test="${totalCount > 0}">
                <div class="statistics-summary">
                    <div class="stat-card">
                        <div class="stat-number">${totalCount}</div>
                        <div class="stat-label">Tổng số đề xuất</div>
                    </div>
                    <div class="stat-card stat-pending">
                        <div class="stat-number">${pendingCount}</div>
                        <div class="stat-label">⏳ Chờ duyệt</div>
                    </div>
                    <div class="stat-card stat-approved">
                        <div class="stat-number">${approvedCount}</div>
                        <div class="stat-label">✅ Đã chấp nhận</div>
                    </div>
                    <div class="stat-card stat-rejected">
                        <div class="stat-number">${rejectedCount}</div>
                        <div class="stat-label">❌ Đã từ chối</div>
                    </div>
                </div>
            </c:if>
            
            <!-- Tabs filter -->
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions" 
                   class="filter-tab ${empty param.status ? 'active' : ''}">
                    Tất cả <span class="tab-count">(${totalCount})</span>
                </a>
                <a href="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions&status=pending" 
                   class="filter-tab ${param.status == 'pending' ? 'active' : ''}">
                    Chờ duyệt <span class="tab-count">(${pendingCount})</span>
                </a>
                <a href="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions&status=approved" 
                   class="filter-tab ${param.status == 'approved' ? 'active' : ''}">
                    Đã chấp nhận <span class="tab-count">(${approvedCount})</span>
                </a>
                <a href="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions&status=rejected" 
                   class="filter-tab ${param.status == 'rejected' ? 'active' : ''}">
                    Đã từ chối <span class="tab-count">(${rejectedCount})</span>
                </a>
            </div>
            
            <!-- List đề xuất -->
            <c:choose>
                <c:when test="${not empty suggestions}">
                    <div class="suggestions-list">
                        <c:forEach var="suggestion" items="${suggestions}">
                            <div class="suggestion-card status-${suggestion.status}">
                                    <div class="suggestion-header">
                                        <div class="suggestion-word">
                                            <h3 class="word-english">${suggestion.wordEnglish}</h3>
                                            <p class="word-vietnamese">${suggestion.wordVietnamese}</p>
                                        </div>
                                        <div class="suggestion-status">
                                            <c:choose>
                                                <c:when test="${suggestion.status == 'pending'}">
                                                    <span class="status-badge pending">⏳ Chờ duyệt</span>
                                                </c:when>
                                                <c:when test="${suggestion.status == 'approved'}">
                                                    <span class="status-badge approved">✅ Đã chấp nhận</span>
                                                </c:when>
                                                <c:when test="${suggestion.status == 'rejected'}">
                                                    <span class="status-badge rejected">❌ Đã từ chối</span>
                                                </c:when>
                                            </c:choose>
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
                                    
                                    <div class="suggestion-footer">
                                        <span class="suggestion-date">
                                            Gửi ngày: 
                                            <fmt:formatDate value="${suggestion.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                        
                                        <c:if test="${suggestion.status == 'rejected' && not empty suggestion.reviewNote}">
                                            <div class="rejection-note">
                                                <strong>Lý do từ chối:</strong> ${suggestion.reviewNote}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-suggestions">
                        <div class="no-suggestions-icon">📝</div>
                        <h2 style="color: #52796f; margin: 16px 0 8px;">Chưa có đề xuất nào</h2>
                        <p style="color: #6b7280; margin-bottom: 24px;">
                            Bạn chưa gửi đề xuất nào. Hãy đề xuất từ mới ngay!
                        </p>
                        <a href="${pageContext.request.contextPath}/SuggestionServlet" class="suggest-link">
                            ➕ Đề xuất từ mới
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Button quay lại -->
            <div style="margin-top: 32px; text-align: center;">
                <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="back-btn">
                    ← Quay lại trang chủ
                </a>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        /* Statistics Summary */
        .statistics-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            padding: 24px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 2px solid rgba(45, 90, 61, 0.1);
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(45, 90, 61, 0.15);
        }
        
        .stat-card.stat-pending {
            border-color: #fbbf24;
            background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%);
        }
        
        .stat-card.stat-approved {
            border-color: #10b981;
            background: linear-gradient(135deg, #f0fdf4 0%, #d1fae5 100%);
        }
        
        .stat-card.stat-rejected {
            border-color: #ef4444;
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: 800;
            color: #1f4529;
            margin-bottom: 8px;
        }
        
        .stat-card.stat-pending .stat-number {
            color: #92400e;
        }
        
        .stat-card.stat-approved .stat-number {
            color: #065f46;
        }
        
        .stat-card.stat-rejected .stat-number {
            color: #991b1b;
        }
        
        .stat-label {
            font-size: 14px;
            font-weight: 600;
            color: #52796f;
        }
        
        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 10px 20px;
            background: white;
            color: #52796f;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            border: 2px solid rgba(45, 90, 61, 0.2);
            transition: all 0.2s;
        }
        
        .filter-tab:hover {
            background: #f0fdf4;
            border-color: #2d5a3d;
        }
        
        .filter-tab.active {
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            border-color: #2d5a3d;
        }
        
        /* Tab count badge */
        .tab-count {
            font-size: 12px;
            font-weight: 700;
            opacity: 0.8;
            margin-left: 4px;
        }
        
        .filter-tab.active .tab-count {
            opacity: 1;
        }
        
        .suggestions-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
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
        
        .suggestion-status {
            flex-shrink: 0;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
        }
        
        .status-badge.pending {
            background: #fef3c7;
            color: #92400e;
        }
        
        .status-badge.approved {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-badge.rejected {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .suggestion-details {
            margin-bottom: 16px;
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
        
        .suggestion-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 16px;
            border-top: 1px solid rgba(45, 90, 61, 0.1);
            flex-wrap: wrap;
            gap: 12px;
        }
        
        .suggestion-date {
            color: #6b7280;
            font-size: 14px;
        }
        
        .rejection-note {
            width: 100%;
            padding: 12px;
            background: #fee2e2;
            border-left: 4px solid #dc2626;
            border-radius: 4px;
            color: #991b1b;
            font-size: 14px;
            margin-top: 12px;
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
        
        @media (max-width: 768px) {
            .suggestion-header {
                flex-direction: column;
            }
            
            .suggestion-status {
                width: 100%;
            }
            
            .filter-tabs {
                justify-content: center;
            }
        }
    </style>
</body>
</html>

