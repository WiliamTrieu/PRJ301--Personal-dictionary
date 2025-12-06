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
                    <button type="button" onclick="showLogoutConfirm()" class="logout-link">Đăng xuất</button>
                </div>
            </c:if>
        </div>
    </div>
</header>

<!-- Logout Confirmation Modal -->
<div id="logoutModal" class="logout-modal" style="display: none;">
    <div class="logout-modal-overlay" onclick="hideLogoutConfirm()"></div>
    <div class="logout-modal-content">
        <button type="button" class="modal-close" onclick="hideLogoutConfirm()" aria-label="Đóng">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                <path d="M18 6L6 18M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
        </button>
        
        <div class="modal-icon">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none">
                <circle cx="12" cy="12" r="10" stroke="#f59e0b" stroke-width="2"/>
                <path d="M12 8v4M12 16h.01" stroke="#f59e0b" stroke-width="2" stroke-linecap="round"/>
            </svg>
        </div>
        
        <h3 class="modal-title">Xác nhận đăng xuất</h3>
        <p class="modal-message">
            Bạn có chắc muốn đăng xuất khỏi hệ thống?<br>
            <strong>Bạn sẽ cần đăng nhập lại để tiếp tục sử dụng.</strong>
        </p>
        
        <div class="modal-actions">
            <button type="button" onclick="hideLogoutConfirm()" class="modal-btn btn-cancel">
                Hủy
            </button>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="modal-btn btn-confirm">
                Đồng ý
            </a>
        </div>
    </div>
</div>

<script>
    function showLogoutConfirm() {
        document.getElementById('logoutModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    
    function hideLogoutConfirm() {
        document.getElementById('logoutModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }
    
    // Close modal khi nhấn ESC
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            hideLogoutConfirm();
        }
    });
</script>

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
        border: none;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        font-family: inherit;
        cursor: pointer;
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
    
    /* Logout Modal Styles */
    .logout-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 9999;
        display: flex;
        align-items: center;
        justify-content: center;
        animation: fadeIn 0.2s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    .logout-modal-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        backdrop-filter: blur(4px);
    }
    
    .logout-modal-content {
        position: relative;
        background: white;
        border-radius: 16px;
        padding: 32px;
        max-width: 450px;
        width: 90%;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        animation: slideUp 0.3s ease-out;
        text-align: center;
    }
    
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .modal-close {
        position: absolute;
        top: 16px;
        right: 16px;
        background: transparent;
        border: none;
        color: #6b7280;
        cursor: pointer;
        padding: 4px;
        border-radius: 6px;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .modal-close:hover {
        background: #f3f4f6;
        color: #374151;
    }
    
    .modal-icon {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }
    
    .modal-title {
        font-size: 24px;
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 12px;
    }
    
    .modal-message {
        font-size: 15px;
        color: #6b7280;
        line-height: 1.6;
        margin-bottom: 28px;
    }
    
    .modal-message strong {
        color: #374151;
        font-weight: 600;
    }
    
    .modal-actions {
        display: flex;
        gap: 12px;
        justify-content: center;
    }
    
    .modal-btn {
        flex: 1;
        padding: 12px 24px;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        border: none;
        font-family: inherit;
    }
    
    .btn-cancel {
        background: #f3f4f6;
        color: #374151;
        border: 1px solid #e5e7eb;
    }
    
    .btn-cancel:hover {
        background: #e5e7eb;
        border-color: #d1d5db;
    }
    
    .btn-confirm {
        background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        color: white;
        box-shadow: 0 2px 8px rgba(220, 38, 38, 0.3);
    }
    
    .btn-confirm:hover {
        background: linear-gradient(135deg, #b91c1c 0%, #991b1b 100%);
        box-shadow: 0 4px 12px rgba(220, 38, 38, 0.4);
        transform: translateY(-2px);
    }
    
    @media (max-width: 480px) {
        .logout-modal-content {
            padding: 24px;
        }
        
        .modal-title {
            font-size: 20px;
        }
        
        .modal-actions {
            flex-direction: column;
        }
        
        .modal-btn {
            width: 100%;
        }
    }
</style>

