<%-- 
    Document   : admin-dashboard
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
    <title>Admin Dashboard - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <c:choose>
        <c:when test="${totalWords == null}">
            <jsp:useBean id="wordDAO" class="Dao.WordDAO"/>
            <jsp:useBean id="suggestionDAO" class="Dao.WordSuggestionDAO"/>
            <jsp:useBean id="userDAO" class="Dao.UserDAO"/>
            <c:set var="totalWords" value="${wordDAO.countTotalWords()}"/>
            <c:set var="pendingSuggestions" value="${suggestionDAO.countPendingSuggestions()}"/>
            <c:set var="totalUsers" value="${userDAO.countTotalUsers()}"/>
        </c:when>
    </c:choose>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Xin chào, ${sessionScope.fullName}!</h1>
                <p style="color: #52796f; font-weight: 500;">Admin Dashboard - Quản lý từ điển</p>
            </div>
            
            <div class="dashboard-menu">
            <a href="${pageContext.request.contextPath}/admin/ManageWordsServlet" class="menu-item card-merged">
                <div class="menu-item-header">
                    <div class="menu-item-title">📚 Quản lý từ điển</div>
                    <div class="menu-item-value">${totalWords != null ? totalWords : 0}</div>
                </div>
                <div class="menu-item-desc">Thêm, sửa, xóa từ trong từ điển</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/ApprovalListServlet" class="menu-item card-merged">
                <div class="menu-item-header">
                    <div class="menu-item-title">✅ Duyệt đề xuất</div>
                    <div class="menu-item-badge ${pendingSuggestions != null && pendingSuggestions > 0 ? 'badge-alert' : ''}">
                        ${pendingSuggestions != null ? pendingSuggestions : 0}
                    </div>
                </div>
                <div class="menu-item-desc">Xem và duyệt từ user đề xuất</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/UserManagementServlet" class="menu-item card-merged">
                <div class="menu-item-header">
                    <div class="menu-item-title">👥 Quản lý người dùng</div>
                    <div class="menu-item-value">${totalUsers != null ? totalUsers : 0}</div>
                </div>
                <div class="menu-item-desc">Xem và quản lý danh sách người dùng</div>
            </a>
            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="menu-item">
                <div class="menu-item-title">🔍 Tra cứu từ</div>
                <div class="menu-item-desc">Tra cứu từ điển như user</div>
            </a>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .card-merged {
            position: relative;
        }
        
        .menu-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .menu-item-value {
            font-size: 32px;
            font-weight: 700;
            color: #2d5a3d;
            text-shadow: 0 2px 4px rgba(45, 90, 61, 0.1);
        }
        
        .menu-item-badge {
            display: inline-block;
            padding: 8px 16px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            border-radius: 20px;
            font-size: 18px;
            font-weight: 700;
            min-width: 40px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(45, 90, 61, 0.3);
        }
        
        .badge-alert {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 4px 8px rgba(45, 90, 61, 0.3);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 6px 12px rgba(220, 38, 38, 0.5);
            }
        }
        
        .card-merged:hover .menu-item-value {
            transform: scale(1.1);
            transition: transform 0.3s;
        }
        
        .card-merged:hover .menu-item-badge {
            transform: scale(1.1);
            transition: transform 0.3s;
        }
    </style>
</body>
</html>

