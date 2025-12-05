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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .dashboard-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .welcome-message {
            font-size: 24px;
            color: #1f2937;
        }
        .logout-btn {
            padding: 10px 20px;
            background: #dc2626;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .logout-btn:hover {
            background: #b91c1c;
        }
        .search-section {
            background: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .search-form {
            display: flex;
            gap: 12px;
        }
        .search-input {
            flex: 1;
            padding: 16px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            font-size: 16px;
        }
        .search-input:focus {
            outline: none;
            border-color: #2d5a3d;
            box-shadow: 0 0 0 3px rgba(45, 90, 61, 0.1);
        }
        .search-btn {
            padding: 16px 32px;
            background: #2d5a3d;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
        }
        .search-btn:hover {
            background: #1f4529;
        }
        .dashboard-menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }
        .menu-item {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-decoration: none;
            color: #1f2937;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .menu-item-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .menu-item-desc {
            font-size: 14px;
            color: #6b7280;
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.user == null}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div>
                <h1 class="welcome-message">Xin chào, ${sessionScope.fullName}!</h1>
                <p style="color: #6b7280;">Tra cứu từ điển Anh - Việt</p>
            </div>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">Đăng xuất</a>
        </div>
        
        <div class="search-section">
            <h2 style="margin-bottom: 20px; color: #1f2937;">Tìm kiếm từ điển</h2>
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
    </div>
</body>
</html>

