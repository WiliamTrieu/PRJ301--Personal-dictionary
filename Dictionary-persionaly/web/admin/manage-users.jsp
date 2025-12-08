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
    
    <script>
        function resetPassword(userId, email) {
            if (confirm('Bạn có chắc muốn reset mật khẩu cho user "' + email + '"?')) {
                // TODO: Implement reset password functionality
                alert('Chức năng reset mật khẩu sẽ được triển khai sau.');
            }
        }
    </script>
</body>
</html>

