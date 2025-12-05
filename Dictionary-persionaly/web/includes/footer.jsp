<%-- 
    Document   : footer
    Footer component - Thông tin mẫu
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h3 class="footer-title">Về Eden Dictionary</h3>
                <p class="footer-text">
                    Eden Dictionary là từ điển Anh - Việt chuyên ngành dành cho Intelligent Engineering. 
                    Chúng tôi cung cấp công cụ tra cứu từ vựng chính xác và đầy đủ.
                </p>
            </div>
            
            <div class="footer-section">
                <h3 class="footer-title">Liên hệ</h3>
                <p class="footer-text">
                    Email: Trieulinhnk2@gmail.com<br>
                    Điện thoại: 0365757739<br>
                    Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM
                </p>
            </div>
            
            <div class="footer-section">
                <h3 class="footer-title">Thông tin</h3>
                <ul class="footer-links">
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Hỗ trợ</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3 class="footer-title">Theo dõi chúng tôi</h3>
                <div class="social-links">
                    <a href="#" class="social-link">Facebook</a>
                    <a href="#" class="social-link">Twitter</a>
                    <a href="#" class="social-link">LinkedIn</a>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p class="footer-copyright">
                &copy; 2025 Eden Dictionary. Tất cả quyền được bảo lưu.
            </p>
        </div>
    </div>
</footer>

<style>
    .main-footer {
        background: #1f2937;
        color: #e5e7eb;
        margin-top: 60px;
        padding: 0;
    }
    
    .footer-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 48px 24px 24px;
    }
    
    .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 32px;
        margin-bottom: 32px;
    }
    
    .footer-section {
        display: flex;
        flex-direction: column;
    }
    
    .footer-title {
        font-size: 18px;
        font-weight: 600;
        color: #ffffff;
        margin-bottom: 16px;
    }
    
    .footer-text {
        font-size: 14px;
        line-height: 1.6;
        color: #d1d5db;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links li {
        margin-bottom: 12px;
    }
    
    .footer-links a {
        color: #d1d5db;
        text-decoration: none;
        font-size: 14px;
        transition: color 0.2s;
    }
    
    .footer-links a:hover {
        color: #2d5a3d;
    }
    
    .social-links {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    
    .social-link {
        color: #d1d5db;
        text-decoration: none;
        font-size: 14px;
        transition: color 0.2s;
    }
    
    .social-link:hover {
        color: #2d5a3d;
    }
    
    .footer-bottom {
        border-top: 1px solid #374151;
        padding-top: 24px;
        text-align: center;
    }
    
    .footer-copyright {
        font-size: 14px;
        color: #9ca3af;
        margin: 0;
    }
    
    @media (max-width: 768px) {
        .footer-content {
            grid-template-columns: 1fr;
            gap: 24px;
        }
        
        .footer-container {
            padding: 32px 16px 16px;
        }
    }
</style>

