<%-- 
    Document   : header
    Header component - Navigation bar
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="main-header">
    <div class="header-container">
        <div class="header-left">
            <c:choose>
                <c:when test="${sessionScope.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="logo-link">
                        <div class="logo-icon">
                            <svg width="24" height="24" viewBox="0 0 32 32" fill="none">
                                <circle cx="16" cy="16" r="16" fill="#2D5A3D"/>
                                <path d="M12 10L20 16L12 22V10Z" fill="white"/>
                            </svg>
                        </div>
                        <span class="logo-text">Eden Dictionary</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="logo-link">
                        <div class="logo-icon">
                            <svg width="24" height="24" viewBox="0 0 32 32" fill="none">
                                <circle cx="16" cy="16" r="16" fill="#2D5A3D"/>
                                <path d="M12 10L20 16L12 22V10Z" fill="white"/>
                            </svg>
                        </div>
                        <span class="logo-text">Eden Dictionary</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        
        <nav class="header-nav">
            <c:if test="${sessionScope.user != null}">
                <c:choose>
                    <c:when test="${sessionScope.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link">Trang chủ</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="nav-link">Trang chủ</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </nav>
        
        <div class="header-right">
            <c:if test="${sessionScope.user != null}">
                <div class="user-info">
                    <span class="user-name">${sessionScope.fullName}</span>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
                </div>
            </c:if>
        </div>
    </div>
</header>

<style>
    .main-header {
        background: linear-gradient(90deg, #2d5a3d 0%, #1f4529 100%);
        box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        position: sticky;
        top: 0;
        z-index: 1000;
        margin-bottom: 0;
    }
    
    .header-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 16px 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header-left {
        display: flex;
        align-items: center;
    }
    
    .logo-link {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
        color: #ffffff;
        transition: transform 0.2s, opacity 0.2s;
        cursor: pointer;
    }
    
    .logo-link:hover {
        opacity: 0.9;
        transform: scale(1.05);
    }
    
    .logo-icon {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #ffffff;
        border-radius: 50%;
        padding: 4px;
    }
    
    .logo-text {
        font-size: 20px;
        font-weight: 600;
        color: #ffffff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }
    
    .header-nav {
        display: flex;
        gap: 24px;
        align-items: center;
    }
    
    .nav-link {
        text-decoration: none;
        color: rgba(255, 255, 255, 0.9);
        font-size: 15px;
        font-weight: 500;
        transition: all 0.2s;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
    }
    
    .nav-link:hover {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-2px);
    }
    
    .admin-link {
        color: #fecaca;
        font-weight: 600;
        background: rgba(220, 38, 38, 0.2);
    }
    
    .admin-link:hover {
        color: #ffffff;
        background: rgba(220, 38, 38, 0.3);
    }
    
    .header-right {
        display: flex;
        align-items: center;
    }
    
    .user-info {
        display: flex;
        align-items: center;
        gap: 16px;
    }
    
    .user-name {
        color: #ffffff;
        font-weight: 500;
        font-size: 15px;
    }
    
    .logout-link {
        padding: 8px 16px;
        background: rgba(220, 38, 38, 0.9);
        color: white;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }
    
    .logout-link:hover {
        background: #dc2626;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }
    
    @media (max-width: 768px) {
        .header-container {
            flex-wrap: wrap;
            gap: 12px;
        }
        
        .header-nav {
            order: 3;
            width: 100%;
            justify-content: center;
            gap: 16px;
        }
        
        .header-right {
            margin-left: auto;
        }
    }
</style>

