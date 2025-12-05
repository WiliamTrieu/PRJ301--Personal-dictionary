<%-- 
    Document   : user-dashboard
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
    <title>Tra cứu từ điển - Eden Dictionary</title>
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
                <h1 class="welcome-message">Xin chào, ${sessionScope.fullName}!</h1>
                <p style="color: #52796f; font-weight: 500;">Tra cứu từ điển Anh - Việt</p>
            </div>
            
            <div class="search-section">
                <h2 style="margin-bottom: 20px; color: #1f4529; font-weight: 600;">Tìm kiếm từ điển</h2>
            <form action="${pageContext.request.contextPath}/SearchServlet" method="GET" class="search-form">
                <input type="text" 
                       name="keyword" 
                       class="search-input" 
                       placeholder="Nhập từ tiếng Anh hoặc tiếng Việt..." 
                       required>
                <button type="submit" class="search-btn">Tìm kiếm</button>
            </form>
        </div>
        
        <div class="dashboard-menu">
            <a href="${pageContext.request.contextPath}/user/suggest-word.jsp" class="menu-item">
                <div class="menu-item-title">➕ Đề xuất từ mới</div>
                <div class="menu-item-desc">Đề xuất từ chưa có trong từ điển</div>
            </a>
            <a href="${pageContext.request.contextPath}/user/my-suggestions.jsp" class="menu-item">
                <div class="menu-item-title">📝 Đề xuất của tôi</div>
                <div class="menu-item-desc">Xem trạng thái đề xuất đã gửi</div>
            </a>
            <c:if test="${sessionScope.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp" class="menu-item">
                    <div class="menu-item-title">⚙️ Admin Panel</div>
                    <div class="menu-item-desc">Quản lý từ điển và duyệt đề xuất</div>
                </a>
            </c:if>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
</body>
</html>

