<%-- 
    Document   : register
    Created on : Dec 5, 2025
    Author     : Eden Dictionary Team
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="login-page">
    <div class="eden-container">
        <div class="eden-card">
            <div class="eden-logo">
                <div class="logo-icon">
                    <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
                        <circle cx="16" cy="16" r="16" fill="#2D5A3D"/>
                        <path d="M12 10L20 16L12 22V10Z" fill="white"/>
                    </svg>
                </div>
                <h1 class="brand-name">Eden dictionary <span class="beta">BETA</span></h1>
            </div>
            
            <div class="eden-content">
                <h2 class="tagline">Tạo tài khoản mới</h2>
                <div class="description">
                    <p>Đăng ký để bắt đầu sử dụng Eden Dictionary</p>
                    <p>Từ điển cá nhân hóa chuyên nghiệp</p>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="error-message" id="errorMessage">
                        <svg class="error-icon" width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                            <path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        <span>${error}</span>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="success-message" id="successMessage">
                        <svg class="success-icon" width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                            <path d="M8 12l2 2 4-4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <span>${success}</span>
                    </div>
                </c:if>
                
                <form class="waitlist-form" id="registerForm" method="POST" action="${pageContext.request.contextPath}/RegisterServlet">
                    <!-- Username -->
                    <div class="email-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="#9CA3AF"/>
                        </svg>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               placeholder="Tên đăng nhập (3-50 ký tự)" 
                               value="${param.username != null ? param.username : ''}" 
                               required 
                               autocomplete="username"
                               pattern="[a-zA-Z0-9_-]{3,50}"
                               title="Chỉ được chứa chữ, số, gạch dưới và gạch ngang (3-50 ký tự)">
                        <div class="input-error" id="usernameError"></div>
                    </div>
                    
                    <!-- Full Name -->
                    <div class="email-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="#9CA3AF"/>
                        </svg>
                        <input type="text" 
                               id="fullName" 
                               name="fullName" 
                               placeholder="Họ và tên" 
                               value="${param.fullName != null ? param.fullName : ''}" 
                               required 
                               autocomplete="name">
                        <div class="input-error" id="fullNameError"></div>
                    </div>
                    
                    <!-- Password -->
                    <div class="password-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6z" fill="#9CA3AF"/>
                        </svg>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               placeholder="Mật khẩu (tối thiểu 8 ký tự)" 
                               required 
                               autocomplete="new-password">
                        <button type="button" class="password-toggle" id="passwordToggle" aria-label="Show password">
                            <svg class="eye-icon eye-open" width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <svg class="eye-icon eye-closed" width="20" height="20" viewBox="0 0 24 24" fill="none" style="display: none;">
                                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <line x1="1" y1="1" x2="23" y2="23" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </button>
                        <div class="input-error" id="passwordError"></div>
                    </div>
                    
                    <!-- Password Strength Indicator -->
                    <div class="password-strength" id="passwordStrength" style="display: none;">
                        <div class="strength-bar">
                            <div class="strength-bar-fill" id="strengthBar"></div>
                        </div>
                        <div class="strength-text" id="strengthText"></div>
                    </div>
                    
                    <!-- Confirm Password -->
                    <div class="password-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM12 17c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zM15.1 8H8.9V6c0-1.71 1.39-3.1 3.1-3.1s3.1 1.39 3.1 3.1v2z" fill="#9CA3AF"/>
                        </svg>
                        <input type="password" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               placeholder="Xác nhận mật khẩu" 
                               required 
                               autocomplete="new-password">
                        <button type="button" class="password-toggle" id="confirmPasswordToggle" aria-label="Show password">
                            <svg class="eye-icon eye-open" width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <svg class="eye-icon eye-closed" width="20" height="20" viewBox="0 0 24 24" fill="none" style="display: none;">
                                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <line x1="1" y1="1" x2="23" y2="23" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </button>
                        <div class="input-error" id="confirmPasswordError"></div>
                    </div>
                    
                    <!-- Terms Agreement -->
                    <div class="form-options" style="justify-content: flex-start; margin-top: 8px;">
                        <label class="remember-me">
                            <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                            <span class="checkmark"></span>
                            <span class="remember-text">Tôi đồng ý với <a href="#" class="terms-link">Điều khoản sử dụng</a> và <a href="#" class="terms-link">Chính sách bảo mật</a></span>
                        </label>
                    </div>
                    
                    <!-- Submit Button -->
                    <button type="submit" class="waitlist-btn" id="submitBtn">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M22 2L11 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <polygon points="22,2 15,22 11,13 2,9 22,2" fill="currentColor"/>
                        </svg>
                        <span>Đăng ký</span>
                    </button>
                </form>
                
                <!-- Auth Switch -->
                <div class="auth-switch">
                    <span>Đã có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="auth-link">Đăng nhập ngay</a>
                </div>
            </div>
            
            <div class="eden-footer">
                <a href="${pageContext.request.contextPath}/index.jsp" class="footer-link">← Về trang chủ</a>
            </div>
        </div>
        
        <div class="background-effects">
            <div class="gradient-orb orb-1"></div>
            <div class="gradient-orb orb-2"></div>
            <div class="gradient-orb orb-3"></div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>

