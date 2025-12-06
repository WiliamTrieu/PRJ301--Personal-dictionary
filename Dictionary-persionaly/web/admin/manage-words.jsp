<%-- 
    Document   : manage-words
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
    <title>Quản lý từ điển - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <c:if test="${sessionScope.user == null || sessionScope.role != 'admin'}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
    </c:if>
    
    <c:if test="${words == null}">
        <c:redirect url="${pageContext.request.contextPath}/admin/ManageWordsServlet"/>
    </c:if>
    
    <jsp:include page="../includes/header.jsp"/>
    
    <main class="main-content">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1 class="welcome-message">Quản lý từ điển</h1>
                <p style="color: #52796f; font-weight: 500;">Thêm, sửa, xóa từ trong từ điển</p>
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
                <a href="${pageContext.request.contextPath}/admin/add-word.jsp" class="action-btn add-btn">
                    ➕ Thêm từ mới
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="action-btn back-btn">
                    ← Quay lại Dashboard
                </a>
            </div>
            
            <!-- Search and filter -->
            <div class="search-filter-bar">
                <form action="${pageContext.request.contextPath}/admin/ManageWordsServlet" method="GET" class="search-form-inline">
                    <input type="text" 
                           name="keyword" 
                           class="search-input-inline" 
                           placeholder="Tìm kiếm từ..." 
                           value="${param.keyword}">
                    <button type="submit" class="search-btn-inline">🔍 Tìm</button>
                    <c:if test="${not empty param.keyword}">
                        <a href="${pageContext.request.contextPath}/admin/ManageWordsServlet" class="clear-search-btn">✕ Xóa bộ lọc</a>
                    </c:if>
                </form>
            </div>
            
            <!-- Words list -->
            
            <div class="words-table-container">
                <div class="table-header">
                    <p style="color: #52796f; margin: 0;">
                        Tổng số từ: <strong>${totalWords != null ? totalWords : 0}</strong>
                    </p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty words}">
                        <table class="words-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Từ tiếng Anh</th>
                                    <th>Nghĩa tiếng Việt</th>
                                    <th>Loại từ</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="word" items="${words}">
                                    <tr>
                                        <td>${word.wordId}</td>
                                        <td class="word-cell">${word.wordEnglish}</td>
                                        <td class="word-cell">${word.wordVietnamese}</td>
                                        <td>${word.wordType != null ? word.wordType : '-'}</td>
                                        <td class="action-cell">
                                            <a href="${pageContext.request.contextPath}/admin/AdminWordServlet?action=edit&id=${word.wordId}" 
                                               class="action-link edit-link">✏️ Sửa</a>
                                            <a href="${pageContext.request.contextPath}/admin/AdminWordServlet?action=delete&id=${word.wordId}" 
                                               class="action-link delete-link"
                                               onclick="return confirm('Bạn có chắc muốn xóa từ này?');">🗑️ Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            <p style="color: #6b7280;">
                                <c:choose>
                                    <c:when test="${not empty param.keyword}">
                                        Không tìm thấy từ nào với từ khóa "${param.keyword}".
                                    </c:when>
                                    <c:otherwise>
                                        Chưa có từ nào trong từ điển. Hãy thêm từ mới!
                                    </c:otherwise>
                                </c:choose>
                            </p>
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
        
        .add-btn {
            background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(45, 90, 61, 0.4);
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
        
        .search-filter-bar {
            margin-bottom: 24px;
        }
        
        .search-form-inline {
            display: flex;
            gap: 12px;
            max-width: 500px;
        }
        
        .search-input-inline {
            flex: 1;
            padding: 12px 16px;
            border: 2px solid rgba(45, 90, 61, 0.2);
            border-radius: 8px;
            font-size: 15px;
        }
        
        .search-input-inline:focus {
            outline: none;
            border-color: #2d5a3d;
            box-shadow: 0 0 0 4px rgba(45, 90, 61, 0.1);
        }
        
        .search-btn-inline {
            padding: 12px 24px;
            background: #2d5a3d;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .search-btn-inline:hover {
            background: #1f4529;
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
        
        .words-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .words-table thead {
            background: #f0fdf4;
        }
        
        .words-table th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: #1f4529;
            border-bottom: 2px solid rgba(45, 90, 61, 0.2);
        }
        
        .words-table td {
            padding: 16px;
            border-bottom: 1px solid rgba(45, 90, 61, 0.1);
            color: #374151;
        }
        
        .words-table tbody tr:hover {
            background: #f0fdf4;
        }
        
        .word-cell {
            font-weight: 500;
            color: #1f4529;
        }
        
        .action-cell {
            display: flex;
            gap: 12px;
        }
        
        .action-link {
            text-decoration: none;
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        
        .edit-link {
            color: #2563eb;
            background: #eff6ff;
        }
        
        .edit-link:hover {
            background: #dbeafe;
        }
        
        .delete-link {
            color: #dc2626;
            background: #fee2e2;
        }
        
        .delete-link:hover {
            background: #fecaca;
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
        
        @media (max-width: 768px) {
            .words-table {
                font-size: 14px;
            }
            
            .words-table th,
            .words-table td {
                padding: 12px 8px;
            }
            
            .action-cell {
                flex-direction: column;
                gap: 8px;
            }
        }
    </style>
</body>
</html>

