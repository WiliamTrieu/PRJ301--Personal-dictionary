<%-- 
    Document   : admin-dashboard
    Created on : Dec 5, 2025
    Author     : PRJ301
    Description: Trang dashboard trực quan cho admin - có search box
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Eden Dictionary</title>
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
                <p style="color: #52796f; font-weight: 500;">Admin Dashboard - Tìm kiếm và quản lý từ điển</p>
            </div>
            
            <!-- Search Section - Luôn hiện hữu trong dashboard hiện đại -->
            <div class="search-section">
                <h2 style="margin-bottom: 20px; color: #1f4529; font-weight: 600;">Tìm kiếm từ điển</h2>
                <form action="${pageContext.request.contextPath}/SearchServlet" method="GET" class="search-form">
                    <input type="text" 
                           name="keyword" 
                           class="search-input" 
                           placeholder="Nhập từ tiếng Anh hoặc tiếng Việt..." 
                           required>
                    <button type="submit" class="search-btn">🔍 Tìm kiếm</button>
                </form>
            </div>
            
            <!-- Dashboard Menu - Navigation Cards -->
            <div class="dashboard-menu">
                <a href="${pageContext.request.contextPath}/admin/AdminDashboardServlet" class="menu-item">
                    <div class="menu-item-title">⚙️ Admin Panel</div>
                    <div class="menu-item-desc">Quản lý từ điển và duyệt đề xuất</div>
                </a>
                <a href="${pageContext.request.contextPath}/admin/PasswordResetServlet" class="menu-item" style="position: relative;">
                    <div class="menu-item-title">
                        🔐 Password Reset Requests
                        <span id="resetRequestBadge" class="notification-badge" style="display: none;"></span>
                    </div>
                    <div class="menu-item-desc">Xử lý yêu cầu reset mật khẩu từ users</div>
                </a>
                <a href="${pageContext.request.contextPath}/MySavedWordsServlet" class="menu-item card-highlighted">
                    <div class="menu-item-title">⭐ Từ điển của tôi</div>
                    <div class="menu-item-desc">Bộ từ vựng cá nhân của bạn</div>
                </a>
                <a href="${pageContext.request.contextPath}/user/suggest-word.jsp" class="menu-item">
                    <div class="menu-item-title">➕ Đề xuất từ mới</div>
                    <div class="menu-item-desc">Đề xuất từ chưa có trong từ điển</div>
                </a>
                <a href="${pageContext.request.contextPath}/SuggestionServlet?action=my-suggestions" class="menu-item">
                    <div class="menu-item-title">📝 Đề xuất của tôi</div>
                    <div class="menu-item-desc">Xem trạng thái đề xuất đã gửi</div>
                </a>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .notification-badge {
            display: inline-block;
            padding: 4px 8px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            margin-left: 8px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
                transform: scale(1);
            }
            50% {
                opacity: 0.8;
                transform: scale(1.05);
            }
        }
    </style>
    
    <script>
        // Fetch password reset request count on page load
        document.addEventListener('DOMContentLoaded', function() {
            fetch('${pageContext.request.contextPath}/api/password-reset-count')
                .then(response => response.json())
                .then(data => {
                    const badge = document.getElementById('resetRequestBadge');
                    if (data.count > 0) {
                        badge.textContent = data.count;
                        badge.style.display = 'inline-block';
                    }
                })
                .catch(error => {
                    console.log('Could not fetch reset request count:', error);
                    // Fallback: Check if there are any requests by calling the servlet
                    // This is optional - we can just show the menu item without a badge
                });
        });
    </script>
</body>
</html>

