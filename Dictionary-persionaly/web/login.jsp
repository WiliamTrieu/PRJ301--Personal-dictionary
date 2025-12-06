<%-- 
    Document   : login
    Created on : Dec 5, 2025, 8:46:11 PM
    Author     : trieu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eden - The workspace for creatives</title>
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
                <h2 class="tagline">The workspace for creatives</h2>
                <div class="description">
                    <p>Capture anything. Remember everything.</p>
                    <p>"A specialized dictionary for Intelligent Engineering"</p>
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
                <form class="waitlist-form" id="waitlistForm" method="POST" action="${pageContext.request.contextPath}/LoginServlet">
                    <div class="email-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="#9CA3AF"/>
                        </svg>
                        <input type="text" id="email" name="email" placeholder="Tên đăng nhập hoặc Email" value="${param.email != null ? param.email : ''}" required autocomplete="username">
                        <div class="input-error" id="emailError"></div>
                    </div>
                    <div class="password-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6z" fill="#9CA3AF"/>
                        </svg>
                        <input type="password" id="password" name="password" placeholder="Mật khẩu" required autocomplete="current-password">
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
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" id="rememberMe" name="rememberMe" value="true">
                            <span class="checkmark"></span>
                            <span class="remember-text">Ghi nhớ đăng nhập</span>
                        </label>
                        <a href="#" class="forgot-password-link">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="waitlist-btn" id="submitBtn">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M22 2L11 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <polygon points="22,2 15,22 11,13 2,9 22,2" fill="currentColor"/>
                        </svg>
                        <span>Log in</span>
                    </button>
                </form>
                
                <!-- Auth Switch -->
                <div class="auth-switch">
                    <span>Chưa có tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="auth-link">Đăng ký ngay</a>
                </div>
            </div>
            
            <div class="eden-footer">
                <a href="${pageContext.request.contextPath}/index.jsp" class="footer-link">← Về trang chủ</a>
                <span class="separator">|</span>
                <a href="#" class="footer-link">Reset password</a>
            </div>
        </div>
        
        <div class="background-effects">
            <div class="gradient-orb orb-1"></div>
            <div class="gradient-orb orb-2"></div>
            <div class="gradient-orb orb-3"></div>
        </div>
    </div>
    
    <script>
        // Password Toggle Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const passwordToggle = document.getElementById('passwordToggle');
            const eyeOpen = passwordToggle.querySelector('.eye-open');
            const eyeClosed = passwordToggle.querySelector('.eye-closed');
            
            passwordToggle.addEventListener('click', function() {
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeOpen.style.display = 'none';
                    eyeClosed.style.display = 'block';
                    passwordToggle.setAttribute('aria-label', 'Hide password');
                } else {
                    passwordInput.type = 'password';
                    eyeOpen.style.display = 'block';
                    eyeClosed.style.display = 'none';
                    passwordToggle.setAttribute('aria-label', 'Show password');
                }
            });
            
            // Real-time validation
            const emailInput = document.getElementById('email');
            const emailError = document.getElementById('emailError');
            const passwordError = document.getElementById('passwordError');
            const form = document.getElementById('waitlistForm');
            
            // Email validation
            emailInput.addEventListener('blur', function() {
                const email = emailInput.value.trim();
                if (!email) {
                    emailError.textContent = '';
                    return;
                }
                
                // Basic email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email) && email.length < 3) {
                    emailError.textContent = 'Vui lòng nhập email hợp lệ hoặc tên đăng nhập';
                    emailInput.style.borderColor = '#dc2626';
                } else {
                    emailError.textContent = '';
                    emailInput.style.borderColor = '#e5e7eb';
                }
            });
            
            emailInput.addEventListener('input', function() {
                if (emailInput.style.borderColor === 'rgb(220, 38, 38)') {
                    emailInput.style.borderColor = '#e5e7eb';
                    emailError.textContent = '';
                }
            });
            
            // Password validation
            passwordInput.addEventListener('blur', function() {
                const password = passwordInput.value;
                if (!password) {
                    passwordError.textContent = '';
                    return;
                }
                
                if (password.length < 3) {
                    passwordError.textContent = 'Mật khẩu phải có ít nhất 3 ký tự';
                    passwordInput.style.borderColor = '#dc2626';
                } else {
                    passwordError.textContent = '';
                    passwordInput.style.borderColor = '#e5e7eb';
                }
            });
            
            passwordInput.addEventListener('input', function() {
                if (passwordInput.style.borderColor === 'rgb(220, 38, 38)') {
                    passwordInput.style.borderColor = '#e5e7eb';
                    passwordError.textContent = '';
                }
            });
            
            // Form submission with better validation
            form.addEventListener('submit', function(e) {
                const email = emailInput.value.trim();
                const password = passwordInput.value;
                
                let hasError = false;
                
                // Clear previous errors
                emailError.textContent = '';
                passwordError.textContent = '';
                
                // Validate email
                if (!email) {
                    emailError.textContent = 'Vui lòng nhập tên đăng nhập hoặc email';
                    emailInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else {
                    emailInput.style.borderColor = '#e5e7eb';
                }
                
                // Validate password
                if (!password) {
                    passwordError.textContent = 'Vui lòng nhập mật khẩu';
                    passwordInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else if (password.length < 3) {
                    passwordError.textContent = 'Mật khẩu phải có ít nhất 3 ký tự';
                    passwordInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else {
                    passwordInput.style.borderColor = '#e5e7eb';
                }
                
                if (hasError) {
                e.preventDefault();
                    
                    // Scroll to first error
                    const firstError = document.querySelector('.input-error:not(:empty)');
                    if (firstError) {
                        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                    
                return false;
                }
                
                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span>Đang đăng nhập...</span>';
            });
            
            // Auto-hide error messages after 5 seconds
            const errorMessage = document.getElementById('errorMessage');
            if (errorMessage) {
                setTimeout(function() {
                    errorMessage.style.opacity = '0';
                    setTimeout(function() {
                        errorMessage.style.display = 'none';
                    }, 300);
                }, 5000);
            }
            
            // Load remembered email if exists
            const rememberedEmail = localStorage.getItem('eden_remembered_email');
            if (rememberedEmail && document.getElementById('rememberMe').checked === false) {
                emailInput.value = rememberedEmail;
            }
        });
    </script>
</body>
</html>
     