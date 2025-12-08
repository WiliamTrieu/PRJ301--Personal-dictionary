<%-- 
    Document   : forgot-password
    Created on : Dec 8, 2025
    Author     : PRJ301
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - Eden Dictionary</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
                <h2 class="tagline">Quên mật khẩu?</h2>
                <div class="description">
                    <p>Nhập tên đăng nhập, mã bảo mật và email để admin hỗ trợ</p>
                    <div style="margin-top: 12px; padding: 12px; background: #fef3c7; border-radius: 8px; font-size: 13px; color: #92400e;">
                        💡 <strong>Mã bảo mật</strong> là mã riêng bạn đã đặt khi đăng ký
                    </div>
                </div>

                <!-- Alert Messages -->
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
                        <div style="line-height: 1.6;">
                            <strong>Yêu cầu đã được ghi nhận!</strong><br>
                            <span style="font-size: 14px;">
                                Vui lòng liên hệ Admin để reset mật khẩu:<br>
                                📧 Email: <strong>Trieulinhnk2@gmail.com</strong><br>
                                📱 Phone: <strong>0365757739</strong>
                            </span>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty success}">
                    <!-- Form -->
                    <form class="waitlist-form" id="forgotPasswordForm" method="POST" action="${pageContext.request.contextPath}/ForgotPasswordServlet">
                        <div class="email-input-container">
                            <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="#9CA3AF"/>
                            </svg>
                            <input type="text" 
                                   id="username" 
                                   name="username" 
                                   placeholder="Tên đăng nhập của bạn" 
                                   value="${username}"
                                   required>
                            <div class="input-error" id="usernameError"></div>
                        </div>

                        <div class="email-input-container">
                            <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z" fill="#9CA3AF"/>
                            </svg>
                            <input type="text" 
                                   id="securityCode" 
                                   name="securityCode" 
                                   placeholder="Nhập mã bảo mật của bạn"
                                   value="${securityCode}"
                                   required
                                   minlength="6">
                            <div class="input-error" id="securityCodeError"></div>
                        </div>

                        <div class="email-input-container">
                            <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" fill="#9CA3AF"/>
                                <path d="M22 6l-10 7L2 6" stroke="white" stroke-width="1.5"/>
                            </svg>
                            <input type="email" 
                                   id="contactEmail" 
                                   name="contactEmail" 
                                   placeholder="Email để admin liên hệ bạn"
                                   value="${contactEmail}"
                                   required>
                            <div class="input-error" id="contactEmailError"></div>
                        </div>

                        <button type="submit" class="waitlist-btn" id="submitBtn">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M22 2L11 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <polygon points="22,2 15,22 11,13 2,9 22,2" fill="currentColor"/>
                            </svg>
                            <span>Gửi yêu cầu</span>
                        </button>
                    </form>
                </c:if>

                <!-- Auth Switch -->
                <div class="auth-switch">
                    <span>Đã nhớ lại mật khẩu?</span>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="auth-link">Đăng nhập ngay</a>
                </div>
            </div>
            
            <div class="eden-footer">
                <a href="${pageContext.request.contextPath}/login.jsp" class="footer-link">← Quay lại đăng nhập</a>
                <span class="separator">|</span>
                <a href="${pageContext.request.contextPath}/index.jsp" class="footer-link">Trang chủ</a>
            </div>
        </div>
        
        <div class="background-effects">
            <div class="gradient-orb orb-1"></div>
            <div class="gradient-orb orb-2"></div>
            <div class="gradient-orb orb-3"></div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('forgotPasswordForm');
            if (!form) return;
            
            const usernameInput = document.getElementById('username');
            const securityCodeInput = document.getElementById('securityCode');
            const contactEmailInput = document.getElementById('contactEmail');
            const usernameError = document.getElementById('usernameError');
            const securityCodeError = document.getElementById('securityCodeError');
            const contactEmailError = document.getElementById('contactEmailError');
            const submitBtn = document.getElementById('submitBtn');
            
            // Real-time validation cho username
            usernameInput.addEventListener('blur', function() {
                const username = usernameInput.value.trim();
                if (!username) {
                    usernameError.textContent = '';
                    return;
                }
                
                if (username.length < 3) {
                    usernameError.textContent = 'Tên đăng nhập phải có ít nhất 3 ký tự';
                    usernameInput.style.borderColor = '#dc2626';
                } else {
                    usernameError.textContent = '';
                    usernameInput.style.borderColor = '#e5e7eb';
                }
            });
            
            usernameInput.addEventListener('input', function() {
                if (usernameInput.style.borderColor === 'rgb(220, 38, 38)') {
                    usernameInput.style.borderColor = '#e5e7eb';
                    usernameError.textContent = '';
                }
            });
            
            // Real-time validation cho security code
            securityCodeInput.addEventListener('blur', function() {
                const securityCode = securityCodeInput.value.trim();
                if (!securityCode) {
                    securityCodeError.textContent = '';
                    return;
                }
                
                if (securityCode.length < 6) {
                    securityCodeError.textContent = 'Mã bảo mật phải có ít nhất 6 ký tự';
                    securityCodeInput.style.borderColor = '#dc2626';
                } else {
                    securityCodeError.textContent = '';
                    securityCodeInput.style.borderColor = '#e5e7eb';
                }
            });
            
            securityCodeInput.addEventListener('input', function() {
                if (securityCodeInput.style.borderColor === 'rgb(220, 38, 38)') {
                    securityCodeInput.style.borderColor = '#e5e7eb';
                    securityCodeError.textContent = '';
                }
            });
            
            // Real-time validation cho contact email
            contactEmailInput.addEventListener('blur', function() {
                const email = contactEmailInput.value.trim();
                if (!email) {
                    contactEmailError.textContent = '';
                    return;
                }
                
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    contactEmailError.textContent = 'Email không hợp lệ';
                    contactEmailInput.style.borderColor = '#dc2626';
                } else {
                    contactEmailError.textContent = '';
                    contactEmailInput.style.borderColor = '#e5e7eb';
                }
            });
            
            contactEmailInput.addEventListener('input', function() {
                if (contactEmailInput.style.borderColor === 'rgb(220, 38, 38)') {
                    contactEmailInput.style.borderColor = '#e5e7eb';
                    contactEmailError.textContent = '';
                }
            });
            
            // Form submission validation
            form.addEventListener('submit', function(e) {
                const username = usernameInput.value.trim();
                const securityCode = securityCodeInput.value.trim();
                const contactEmail = contactEmailInput.value.trim();
                
                let hasError = false;
                
                // Clear previous errors
                usernameError.textContent = '';
                securityCodeError.textContent = '';
                contactEmailError.textContent = '';
                
                // Validate username
                if (!username) {
                    usernameError.textContent = 'Vui lòng nhập tên đăng nhập';
                    usernameInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else if (username.length < 3) {
                    usernameError.textContent = 'Tên đăng nhập phải có ít nhất 3 ký tự';
                    usernameInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else {
                    usernameInput.style.borderColor = '#e5e7eb';
                }
                
                // Validate security code
                if (!securityCode) {
                    securityCodeError.textContent = 'Vui lòng nhập mã bảo mật';
                    securityCodeInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else if (securityCode.length < 6) {
                    securityCodeError.textContent = 'Mã bảo mật phải có ít nhất 6 ký tự';
                    securityCodeInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else {
                    securityCodeInput.style.borderColor = '#e5e7eb';
                }
                
                // Validate contact email
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!contactEmail) {
                    contactEmailError.textContent = 'Vui lòng nhập email liên hệ';
                    contactEmailInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else if (!emailRegex.test(contactEmail)) {
                    contactEmailError.textContent = 'Email không hợp lệ';
                    contactEmailInput.style.borderColor = '#dc2626';
                    hasError = true;
                } else {
                    contactEmailInput.style.borderColor = '#e5e7eb';
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
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span>Đang gửi yêu cầu...</span>';
            });
            
            // Auto-hide error/success messages after 10 seconds
            const errorMessage = document.getElementById('errorMessage');
            if (errorMessage) {
                setTimeout(function() {
                    errorMessage.style.opacity = '0';
                    setTimeout(function() {
                        errorMessage.style.display = 'none';
                    }, 300);
                }, 10000);
            }
            
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                setTimeout(function() {
                    successMessage.style.opacity = '0';
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 300);
                }, 15000);
            }
        });
    </script>
</body>
</html>
