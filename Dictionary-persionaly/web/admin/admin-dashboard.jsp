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
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Xin chào, ${sessionScope.fullName}!</h1>
                <p style="color: #52796f; font-weight: 500;">Admin Dashboard - Quản lý từ điển</p>
            </div>
            
            <div class="dashboard-cards">
            <div class="card">
                <div class="card-title">Tổng số từ điển</div>
                <div class="card-value">${totalWords != null ? totalWords : 0}</div>
            </div>
            <div class="card">
                <div class="card-title">Đề xuất chờ duyệt</div>
                <div class="card-value">${pendingSuggestions != null ? pendingSuggestions : 0}</div>
            </div>
            <div class="card">
                <div class="card-title">Tổng số users</div>
                <div class="card-value">${totalUsers != null ? totalUsers : 0}</div>
            </div>
        </div>
        
        <div class="dashboard-menu">
            <a href="${pageContext.request.contextPath}/admin/ManageWordsServlet" class="menu-item">
                <div class="menu-item-title">📚 Quản lý từ điển</div>
                <div class="menu-item-desc">Thêm, sửa, xóa từ trong từ điển</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/ApprovalListServlet" class="menu-item">
                <div class="menu-item-title">✅ Duyệt đề xuất</div>
                <div class="menu-item-desc">Xem và duyệt từ user đề xuất</div>
            </a>
            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="menu-item">
                <div class="menu-item-title">🔍 Tra cứu từ</div>
                <div class="menu-item-desc">Tra cứu từ điển như user</div>
            </a>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
</body>
</html>

