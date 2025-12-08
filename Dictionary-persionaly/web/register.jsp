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
                    
                    <!-- Security Code -->
                    <div class="security-code-section">
                        <div class="section-header">
                            <h3 class="section-title">🔐 Mã bảo mật</h3>
                            <button type="button" class="info-btn" onclick="showSecurityCodeInfo()">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                    <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                                    <path d="M12 16v-4M12 8h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                </svg>
                                Tại sao cần mã bảo mật?
                            </button>
                        </div>
                        
                        <div class="password-input-container">
                            <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z" fill="#9CA3AF"/>
                            </svg>
                            <input type="text" 
                                   id="securityCode" 
                                   name="securityCode" 
                                   placeholder="Nhập bất kỳ: chữ, số, ký tự (tối thiểu 6 ký tự)" 
                                   required 
                                   minlength="6"
                                   maxlength="50">
                            <div class="input-error" id="securityCodeError"></div>
                        </div>
                        
                        <div class="password-input-container">
                            <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" fill="#9CA3AF"/>
                            </svg>
                            <input type="text" 
                                   id="confirmSecurityCode" 
                                   name="confirmSecurityCode" 
                                   placeholder="Nhập lại mã bảo mật" 
                                   required>
                            <div class="input-error" id="confirmSecurityCodeError"></div>
                        </div>
                        
                        <div class="security-hint">
                            💡 <strong>Chỉ cần ≥6 ký tự bất kỳ,không được để trống!</strong><br>
                            VD: "MySecretCode123"v.v...
                        </div>
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
    
    <style>
        .security-code-section {
            margin: 24px 0;
            padding: 20px;
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            border-radius: 12px;
            border: 2px solid rgba(45, 90, 61, 0.2);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }
        
        .section-title {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
            color: #1f4529;
        }
        
        .info-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: white;
            border: 1px solid #2d5a3d;
            border-radius: 6px;
            color: #2d5a3d;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .info-btn:hover {
            background: #2d5a3d;
            color: white;
        }
        
        .security-hint {
            margin-top: 12px;
            padding: 12px;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 8px;
            font-size: 13px;
            color: #065f46;
            line-height: 1.5;
        }
    </style>
    
    <script>
        function showSecurityCodeInfo() {
            // Create modal overlay
            const overlay = document.createElement('div');
            overlay.className = 'security-modal-overlay';
            overlay.innerHTML = `
                <div class="security-modal">
                    <div class="security-modal-header">
                        <h2>🔐 Về Mã Bảo Mật</h2>
                        <button onclick="closeSecurityModal()" class="modal-close-btn">&times;</button>
                    </div>
                    <div class="security-modal-body">
                        <p style="margin-bottom: 16px;">
                            Mã bảo mật là mã riêng của bạn để xác thực danh tính khi quên mật khẩu.
                        </p>
                        
                        <h3 style="color: #dc2626; margin: 16px 0 8px;">⚠️ Lưu ý quan trọng:</h3>
                        <ul style="line-height: 1.8; margin-left: 20px;">
                            <li>Chỉ <strong>BẠN</strong> biết mã này</li>
                            <li>Cần nhớ để lấy lại mật khẩu</li>
                            <li>Admin không thể thấy mã này</li>
                            <li>Không được để lộ cho bất kỳ ai</li>
                        </ul>
                        
                        <h3 style="color: #2d5a3d; margin: 16px 0 8px;">✅ Quy tắc đơn giản:</h3>
                        <ul style="line-height: 1.8; margin-left: 20px;">
                            <li><strong>Tối thiểu 6 ký tự</strong></li>
                            <li><strong>Chữ, số, ký tự gì cũng được</strong></li>
                            <li><strong>Không được để trống</strong></li>
                        </ul>
                        
                        <h3 style="color: #2d5a3d; margin: 16px 0 8px;">💡 Ví dụ:</h3>
                        <ul style="line-height: 1.8; margin-left: 20px;">
                            <li>"MyDog123"</li>
                            <li>"HaNoi1995"</li>
                            <li>"Tên chó Milo"</li>
                            <li>"SecretCode@2025"</li>
                        </ul>
                        
                        <div style="margin-top: 20px; padding: 16px; background: #fef3c7; border-radius: 8px; border-left: 4px solid #f59e0b;">
                            <strong style="color: #92400e;">📌 Chọn mã dễ nhớ nhưng khó đoán!</strong>
                        </div>
                    </div>
                    <div class="security-modal-footer">
                        <button onclick="closeSecurityModal()" class="modal-ok-btn">Đã hiểu</button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(overlay);
            
            // Add CSS
            const style = document.createElement('style');
            style.textContent = `
                .security-modal-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.5);
                    backdrop-filter: blur(4px);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 10000;
                    animation: fadeIn 0.2s;
                }
                
                .security-modal {
                    background: white;
                    border-radius: 16px;
                    width: 90%;
                    max-width: 600px;
                    max-height: 90vh;
                    overflow-y: auto;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                    animation: slideUp 0.3s;
                }
                
                .security-modal-header {
                    padding: 24px;
                    border-bottom: 1px solid #e5e7eb;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }
                
                .security-modal-header h2 {
                    margin: 0;
                    color: #1f4529;
                    font-size: 24px;
                }
                
                .modal-close-btn {
                    width: 32px;
                    height: 32px;
                    border: none;
                    background: #f3f4f6;
                    border-radius: 6px;
                    font-size: 24px;
                    color: #6b7280;
                    cursor: pointer;
                    transition: all 0.2s;
                }
                
                .modal-close-btn:hover {
                    background: #fee2e2;
                    color: #dc2626;
                }
                
                .security-modal-body {
                    padding: 24px;
                    color: #374151;
                    line-height: 1.6;
                }
                
                .security-modal-footer {
                    padding: 16px 24px;
                    border-top: 1px solid #e5e7eb;
                    text-align: right;
                }
                
                .modal-ok-btn {
                    padding: 12px 32px;
                    background: linear-gradient(135deg, #2d5a3d 0%, #1f4529 100%);
                    color: white;
                    border: none;
                    border-radius: 8px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s;
                }
                
                .modal-ok-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
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
            `;
            document.head.appendChild(style);
        }
        
        function closeSecurityModal() {
            const overlay = document.querySelector('.security-modal-overlay');
            if (overlay) {
                overlay.style.opacity = '0';
                setTimeout(() => overlay.remove(), 200);
            }
        }
        
        // Close on click outside
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('security-modal-overlay')) {
                closeSecurityModal();
            }
        });
        
        // Close on ESC key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeSecurityModal();
            }
        });
    </script>
    
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
</body>
</html>

