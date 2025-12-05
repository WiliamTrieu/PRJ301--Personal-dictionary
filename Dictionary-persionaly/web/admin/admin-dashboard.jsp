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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
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
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #6b7280;
            margin-bottom: 12px;
        }
        .card-value {
            font-size: 32px;
            font-weight: 700;
            color: #2d5a3d;
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
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div>
                <h1 class="welcome-message">Xin chào, ${sessionScope.fullName}!</h1>
                <p style="color: #6b7280;">Admin Dashboard - Quản lý từ điển</p>
            </div>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-btn">Đăng xuất</a>
        </div>
        
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-title">Tổng số từ điển</div>
                <div class="card-value">-</div>
            </div>
            <div class="card">
                <div class="card-title">Đề xuất chờ duyệt</div>
                <div class="card-value">-</div>
            </div>
            <div class="card">
                <div class="card-title">Tổng số users</div>
                <div class="card-value">-</div>
            </div>
        </div>
        
        <div class="dashboard-menu">
            <a href="${pageContext.request.contextPath}/admin/manage-words.jsp" class="menu-item">
                <div class="menu-item-title">📚 Quản lý từ điển</div>
                <div class="menu-item-desc">Thêm, sửa, xóa từ trong từ điển</div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/approval-list.jsp" class="menu-item">
                <div class="menu-item-title">✅ Duyệt đề xuất</div>
                <div class="menu-item-desc">Xem và duyệt từ user đề xuất</div>
            </a>
            <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="menu-item">
                <div class="menu-item-title">🔍 Tra cứu từ</div>
                <div class="menu-item-desc">Tra cứu từ điển như user</div>
            </a>
        </div>
    </div>
</body>
</html>

