<%-- 
    Document   : password-reset-requests
    Created on : Dec 8, 2025
    Author     : PRJ301
    Description: Admin page để xem và xử lý password reset requests
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Requests - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .main-content {
            flex: 1;
            padding: 32px 20px;
        }
        
        .reset-requests-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .page-header {
            background: white;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header-left h1 {
            font-size: 32px;
            font-weight: 700;
            color: #1f4529;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-subtitle {
            color: #6b7280;
            font-size: 15px;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .stats-badge {
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
        }
        
        .stats-number {
            font-size: 24px;
            font-weight: 700;
            display: block;
        }
        
        .alert {
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border-left: 4px solid #10b981;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #dc2626;
        }
        
        .requests-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        
        .request-card {
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 16px;
            padding: 24px;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .request-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        }
        
        .request-card:hover {
            border-color: #2d5a3d;
            box-shadow: 0 8px 24px rgba(45, 90, 61, 0.15);
            transform: translateY(-2px);
        }
        
        .request-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 16px;
        }
        
        .user-info {
            flex: 1;
        }
        
        .username {
            font-size: 18px;
            font-weight: 600;
            color: #1f4529;
            margin-bottom: 8px;
        }
        
        .user-badge {
            display: inline-block;
            padding: 4px 12px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
        }
        
        .request-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #374151;
        }
        
        .detail-icon {
            color: #6b7280;
        }
        
        .email-value {
            font-weight: 600;
            color: #2d5a3d;
        }
        
        .verified-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 8px;
            background: #d1fae5;
            color: #065f46;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
        }
        
        .time-info {
            color: #6b7280;
            font-size: 13px;
        }
        
        .request-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-complete {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        
        .btn-complete:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
        }
        
        .btn-complete:active {
            transform: translateY(0);
        }
        
        .btn-complete:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .empty-state {
            text-align: center;
            padding: 80px 32px;
            background: white;
            border-radius: 16px;
            border: 2px dashed #cbd5e1;
            animation: fadeIn 0.5s;
        }
        
        .empty-icon {
            font-size: 80px;
            margin-bottom: 24px;
            opacity: 0.6;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .empty-title {
            font-size: 24px;
            font-weight: 700;
            color: #374151;
            margin-bottom: 12px;
        }
        
        .empty-subtitle {
            color: #6b7280;
            font-size: 15px;
        }
        
        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 32px;
            justify-content: center;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            text-decoration: none;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.2);
        }
        
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(45, 90, 61, 0.3);
        }
        
        .refresh-btn {
            padding: 12px 24px;
            background: white;
            color: #2d5a3d;
            border: 2px solid #2d5a3d;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .refresh-btn:hover {
            background: #2d5a3d;
            color: white;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                gap: 20px;
                padding: 24px;
            }
            
            .header-left h1 {
                font-size: 24px;
            }
            
            .request-details {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .back-link, .refresh-btn {
                width: 100%;
                justify-content: center;
            }
            
            .main-content {
                padding: 20px 12px;
            }
        }
        
        @media (max-width: 480px) {
            .page-header {
                padding: 20px;
            }
            
            .header-left h1 {
                font-size: 20px;
            }
            
            .header-left h1 svg {
                width: 24px;
                height: 24px;
            }
            
            .request-card {
                padding: 16px;
            }
            
            .empty-icon {
                font-size: 60px;
            }
            
            .empty-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Check admin authentication -->
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <!-- Header -->
    <jsp:include page="../includes/header.jsp"/>
    
    <!-- Main Content -->
    <main class="main-content">
        <div class="reset-requests-container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="header-left">
                    <h1>
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" style="color: #ef4444;">
                            <path d="M12 2L2 7v10c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V7l-10-5z" fill="currentColor" opacity="0.2"/>
                            <path d="M12 2L2 7v10c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V7l-10-5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M9 12l2 2 4-4" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Password Reset Requests
                    </h1>
                    <p class="page-subtitle">
                        Quản lý yêu cầu reset mật khẩu từ users - Security code đã verified
                    </p>
                </div>
                <div class="header-right">
                    <div class="stats-badge">
                        <span class="stats-number">${totalRequests != null ? totalRequests : 0}</span>
                        <span style="font-size: 12px; opacity: 0.9;">Yêu cầu pending</span>
                    </div>
                </div>
            </div>
        
            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                        <path d="M8 12l2 2 4-4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <span>${success}</span>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                        <path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    </svg>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${empty requests}">
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-icon">🎉</div>
                        <h2 class="empty-title">Tuyệt vời! Không có yêu cầu nào</h2>
                        <p class="empty-subtitle">Hiện tại chưa có user nào yêu cầu reset mật khẩu</p>
                    </div>
                </c:when>
            <c:otherwise>
                <!-- Requests List -->
                <div class="requests-list">
                    <c:forEach var="req" items="${requests}">
                        <div class="request-card">
                            <div class="request-header">
                                <div class="user-info">
                                    <div class="username">
                                        🔴 <span class="user-badge">${req.username}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="request-details">
                                <div class="detail-item">
                                    <span class="detail-icon">👤</span>
                                    <strong>Username:</strong> ${req.username}
                                </div>
                                
                                <div class="detail-item">
                                    <span class="detail-icon">📧</span>
                                    <strong>Email:</strong> <span class="email-value">${req.contactEmail}</span>
                                </div>
                                
                                <div class="detail-item">
                                    <span class="detail-icon">🔒</span>
                                    <strong>Security Code:</strong> 
                                    <span class="verified-badge">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none">
                                            <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" fill="currentColor"/>
                                        </svg>
                                        Verified
                                    </span>
                                </div>
                                
                                <div class="detail-item">
                                    <span class="detail-icon">⏰</span>
                                    <strong>Yêu cầu lúc:</strong>
                                    <span class="time-info">
                                        <fmt:formatDate value="${req.requestedAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </div>
                            </div>
                            
                            <div class="request-actions">
                                <button class="btn btn-complete" onclick="confirmComplete(${req.requestId}, '${req.username}')">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="margin-right: 8px;">
                                        <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" fill="currentColor"/>
                                    </svg>
                                    Đã đọc
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="back-link">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                    <path d="M19 12H5M12 19l-7-7 7-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                Quay lại Dashboard
            </a>
            <button class="refresh-btn" onclick="location.reload()">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="display: inline; margin-right: 8px;">
                    <path d="M21.5 2v6h-6M2.5 22v-6h6M2 11.5a10 10 0 0 1 18.8-4.3M22 12.5a10 10 0 0 1-18.8 4.2" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                Refresh
            </button>
        </div>
    </div>
</main>
    
<!-- Footer -->
<jsp:include page="../includes/footer.jsp"/>
    
    <script>
        function confirmComplete(requestId, username) {
            // Beautiful confirmation dialog
            const message = 
                `🔐 XÁC NHẬN HOÀN THÀNH\n\n` +
                `User: ${username}\n\n` +
                `Bạn xác nhận là ĐÃ GỬI mật khẩu mới cho user này qua email?\n\n` +
                `✅ OK = Đã gửi xong (xóa request)\n` +
                `❌ Cancel = Chưa gửi (giữ lại request)`;
            
            const confirmed = confirm(message);
            
            if (confirmed) {
                // Show loading
                const button = event.target.closest('.btn-complete');
                const originalHTML = button.innerHTML;
                button.innerHTML = '<span style="opacity: 0.7;">Đang xử lý...</span>';
                button.disabled = true;
                
                // Submit form
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/PasswordResetServlet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'complete';
                
                const requestIdInput = document.createElement('input');
                requestIdInput.type = 'hidden';
                requestIdInput.name = 'requestId';
                requestIdInput.value = requestId;
                
                form.appendChild(actionInput);
                form.appendChild(requestIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.3s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);
        
        // Add animation on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.request-card');
            cards.forEach((card, index) => {
                card.style.animation = `fadeIn 0.5s ${index * 0.1}s both`;
            });
        });
    </script>
</body>
</html>

