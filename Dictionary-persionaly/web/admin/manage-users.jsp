<%-- 
    Document   : manage-users
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
    <title>Quản lý người dùng - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <c:if test="${usersWithStats == null}">
        <c:redirect url="${pageContext.request.contextPath}/admin/UserManagementServlet"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Quản lý người dùng</h1>
                <p style="color: #52796f; font-weight: 500;">Quản lý danh sách người dùng và thống kê đóng góp</p>
            </div>
            
            <!-- Success/Error messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <!-- Action buttons -->
            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/admin/AdminDashboardServlet" class="action-btn back-btn">
                    ← Quay lại Admin Panel
                </a>
            </div>
            
            <!-- Users list -->
            <div class="words-table-container">
                <div class="table-header">
                    <p style="color: #52796f; margin: 0;">
                        Tổng số người dùng: <strong>${totalUsers != null ? totalUsers : 0}</strong>
                    </p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty usersWithStats && usersWithStats.size() > 0}">
                        <div style="overflow-x: auto;">
                            <table class="users-table">
                                <thead>
                                    <tr>
                                        <th class="col-id">ID</th>
                                        <th class="col-account">Username/Account</th>
                                        <th class="col-name">Họ tên</th>
                                        <th class="col-password">Mật khẩu</th>
                                        <th class="col-contribution">Đóng góp</th>
                                        <th class="col-role">Vai trò</th>
                                        <th class="col-status">Trạng thái</th>
                                        <th class="col-date">Ngày tạo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="userStat" items="${usersWithStats}">
                                        <tr>
                                            <td class="text-center">${userStat.userId}</td>
                                            <td class="account-cell">${userStat.username}</td>
                                            <td>${userStat.fullName != null ? userStat.fullName : '-'}</td>
                                            <td class="password-cell">
                                                <span class="password-hidden">********</span>
                                                <button type="button" class="reset-password-btn" 
                                                        onclick="resetPassword(${userStat.userId}, '${userStat.username}')" 
                                                        title="Reset mật khẩu">
                                                    🔄 Reset
                                                </button>
                                            </td>
                                            <td class="text-center">
                                                <div class="contribution-wrapper">
                                                    <span class="contribution-badge">${userStat.contributionCount}</span>
                                                    <span class="contribution-label">từ</span>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <span class="role-badge role-${userStat.role}">
                                                    ${userStat.role == 'admin' ? 'Admin' : 'User'}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="status-badge ${userStat.status ? 'status-active' : 'status-inactive'}">
                                                    ${userStat.status ? 'Hoạt động' : 'Vô hiệu'}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatDate value="${userStat.createdAt}" pattern="dd/MM/yyyy"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            <p style="color: #6b7280;">Chưa có người dùng nào trong hệ thống.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
    
    <jsp:include page="../includes/footer.jsp"/>
    
    <style>
        .action-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        
        .action-btn {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .back-btn {
            background: white;
            color: #2d5a3d;
            border: 2px solid #2d5a3d;
        }
        
        .back-btn:hover {
            background: #2d5a3d;
            color: white;
        }
        
        .words-table-container {
            background: linear-gradient(135deg, #ffffff 0%, #f0fdf4 100%);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.1);
            border: 1px solid rgba(45, 90, 61, 0.1);
            overflow: hidden;
        }
        
        .table-header {
            padding: 20px 24px;
            border-bottom: 1px solid rgba(45, 90, 61, 0.1);
        }
        
        .users-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            min-width: 1000px;
        }
        
        .users-table thead {
            background: #f0fdf4;
        }
        
        .users-table th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: #1f4529;
            border-bottom: 2px solid rgba(45, 90, 61, 0.2);
        }
        
        .users-table td {
            padding: 16px;
            border-bottom: 1px solid rgba(45, 90, 61, 0.1);
            color: #374151;
            vertical-align: middle;
            word-wrap: break-word;
        }
        
        .users-table tbody tr:hover {
            background: #f0fdf4;
        }
        
        /* Column widths */
        .col-id {
            width: 60px;
            text-align: center !important;
        }
        
        .col-account {
            width: 200px;
        }
        
        .col-name {
            width: 180px;
        }
        
        .col-password {
            width: 200px;
        }
        
        .col-contribution {
            width: 130px;
            text-align: center !important;
        }
        
        .col-role {
            width: 110px;
            text-align: center !important;
        }
        
        .col-status {
            width: 130px;
            text-align: center !important;
        }
        
        .col-date {
            width: 120px;
            text-align: center !important;
        }
        
        .text-center {
            text-align: center !important;
        }
        
        .account-cell {
            font-weight: 500;
            color: #1f4529;
        }
        
        .password-cell {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: nowrap;
        }
        
        .password-hidden {
            font-family: monospace;
            color: #6b7280;
            font-size: 14px;
            white-space: nowrap;
        }
        
        .reset-password-btn {
            padding: 6px 12px;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
            white-space: nowrap;
            flex-shrink: 0;
        }
        
        .reset-password-btn:hover {
            background: #dbeafe;
            border-color: #93c5fd;
        }
        
        .contribution-wrapper {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
        
        .contribution-badge {
            display: inline-block;
            padding: 6px 14px;
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            border-radius: 16px;
            font-weight: 600;
            font-size: 14px;
            min-width: 35px;
            text-align: center;
        }
        
        .contribution-label {
            color: #6b7280;
            font-size: 13px;
            white-space: nowrap;
        }
        
        .role-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            white-space: nowrap;
        }
        
        .role-admin {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .role-user {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            white-space: nowrap;
        }
        
        .status-active {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-weight: 500;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #10b981;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #dc2626;
        }
        
        .no-results {
            padding: 48px 24px;
            text-align: center;
        }
        
        @media (max-width: 1200px) {
            .words-table-container {
                overflow-x: auto;
            }
            
            .users-table {
                min-width: 1000px;
            }
        }
        
        @media (max-width: 768px) {
            .users-table {
                font-size: 13px;
                min-width: 900px;
            }
            
            .users-table th,
            .users-table td {
                padding: 12px 8px;
            }
            
            .password-cell {
                flex-direction: column;
                align-items: flex-start;
                gap: 6px;
            }
            
            .reset-password-btn {
                font-size: 11px;
                padding: 4px 8px;
            }
        }
    </style>
    
    <!-- Reset Password Modal -->
    <div id="resetPasswordModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>🔄 Reset Mật Khẩu</h2>
                <button class="modal-close" onclick="closeResetModal()">&times;</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/UserManagementServlet" method="POST" class="modal-form" id="resetPasswordForm">
                <input type="hidden" name="action" value="resetPassword">
                <input type="hidden" name="userId" id="resetUserId">
                
                <div class="modal-body">
                    <p style="color: #374151; margin-bottom: 20px;">
                        Đang reset mật khẩu cho user: <strong id="resetUsername"></strong>
                    </p>
                    
                    <div class="form-group">
                        <label for="newPassword" class="form-label">
                            🔐 Mật khẩu mới <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="text" 
                               id="newPassword" 
                               name="newPassword" 
                               class="form-input" 
                               placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)"
                               required
                               minlength="6">
                        <div class="input-hint">
                            ⚠️ Mật khẩu sẽ được hiển thị plain text để bạn copy và gửi cho user
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="closeResetModal()">Hủy</button>
                    <button type="submit" class="btn-primary">✅ Reset Mật Khẩu</button>
                </div>
            </form>
        </div>
    </div>
    
    <style>
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            animation: fadeIn 0.2s ease-out;
        }
        
        .modal.active {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.3s ease-out;
        }
        
        .modal-header {
            padding: 24px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h2 {
            margin: 0;
            color: #1f4529;
            font-size: 20px;
            font-weight: 700;
        }
        
        .modal-close {
            width: 32px;
            height: 32px;
            border: none;
            background: #f3f4f6;
            border-radius: 6px;
            font-size: 24px;
            color: #6b7280;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .modal-close:hover {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .modal-body {
            padding: 24px;
        }
        
        .modal-form .form-group {
            margin-bottom: 0;
        }
        
        .modal-form .form-label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-weight: 600;
            font-size: 14px;
        }
        
        .modal-form .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.2s;
            font-family: 'Inter', sans-serif;
        }
        
        .modal-form .form-input:focus {
            outline: none;
            border-color: #2d5a3d;
            box-shadow: 0 0 0 3px rgba(45, 90, 61, 0.1);
        }
        
        .input-hint {
            font-size: 12px;
            color: #dc2626;
            margin-top: 8px;
            line-height: 1.4;
        }
        
        .modal-footer {
            padding: 16px 24px;
            border-top: 1px solid #e5e7eb;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        
        .btn-primary,
        .btn-secondary {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .btn-secondary {
            background: white;
            color: #374151;
            border: 2px solid #e5e7eb;
        }
        
        .btn-secondary:hover {
            background: #f3f4f6;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
    
    <script>
        function resetPassword(userId, username) {
            // Set form data
            document.getElementById('resetUserId').value = userId;
            document.getElementById('resetUsername').textContent = username;
            document.getElementById('newPassword').value = '';
            
            // Show modal
            document.getElementById('resetPasswordModal').classList.add('active');
        }
        
        function closeResetModal() {
            document.getElementById('resetPasswordModal').classList.remove('active');
        }
        
        // Close modal khi click bên ngoài
        window.onclick = function(event) {
            const modal = document.getElementById('resetPasswordModal');
            if (event.target === modal) {
                closeResetModal();
            }
        }
        
        // Close modal khi nhấn ESC
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeResetModal();
            }
        });
    </script>
</body>
</html>

