<%-- 
    Document   : index
    Landing Page - Trang chủ công khai Eden Dictionary
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Eden Dictionary - Từ điển Anh-Việt chuyên ngành IT dành cho Software Engineer Việt Nam">
    <meta name="keywords" content="từ điển IT, từ điển lập trình, English Vietnamese Dictionary, Software Engineering">
    <title>Eden Dictionary - Từ điển IT cho Developer Việt Nam</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="landing-page">
    
    <!-- Navigation Bar -->
    <nav class="landing-nav">
        <div class="nav-container">
            <div class="nav-logo">
                <div class="logo-icon">
                    <svg width="28" height="28" viewBox="0 0 32 32" fill="none">
                        <circle cx="16" cy="16" r="16" fill="#2D5A3D"/>
                        <path d="M12 10L20 16L12 22V10Z" fill="white"/>
                    </svg>
                </div>
                <span class="logo-text">Eden Dictionary</span>
            </div>
            
            <div class="nav-links">
                <a href="#home" class="nav-link">Home</a>
                <a href="#about" class="nav-link">About Us</a>
                <a href="#contact" class="nav-link">Contact</a>
            </div>
            
            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav-login">Log in</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn-nav-signup">SIGN UP</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero-section">
        <div class="hero-container">
            <div class="hero-content">
                <div class="hero-badge">🚀 Từ điển mới dành cho Developer</div>
                <h1 class="hero-title">
                    Từ điển IT<br>
                    <span class="gradient-text">cho Developer Việt Nam</span>
                </h1>
                <p class="hero-subtitle">
                    Tra cứu thuật ngữ lập trình chính xác, đóng góp cộng đồng,<br>
                    học tập và phát triển cùng hàng ngàn developer khác
                </p>
                <div class="hero-cta">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-primary">
                        <span>Bắt đầu ngay</span>
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                            <path d="M7.5 15L12.5 10L7.5 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                    <a href="#features" class="btn-secondary">Tìm hiểu thêm</a>
                </div>
                
                <!-- Statistics -->
                <div class="hero-stats">
                    <div class="stat-item">
                        <div class="stat-number">1,000+</div>
                        <div class="stat-label">Thuật ngữ IT</div>
                    </div>
                    <div class="stat-divider"></div>
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Developer</div>
                    </div>
                    <div class="stat-divider"></div>
                    <div class="stat-item">
                        <div class="stat-number">95%</div>
                        <div class="stat-label">Độ chính xác</div>
                    </div>
                </div>
            </div>
            
            <!-- Hero Visual -->
            <div class="hero-visual">
                <div class="visual-card card-1">
                    <div class="card-icon">🔍</div>
                    <div class="card-text">
                        <strong>Algorithm</strong><br>
                        Thuật toán
                    </div>
                </div>
                <div class="visual-card card-2">
                    <div class="card-icon">💻</div>
                    <div class="card-text">
                        <strong>Backend</strong><br>
                        Phần máy chủ
                    </div>
                </div>
                <div class="visual-card card-3">
                    <div class="card-icon">⚡</div>
                    <div class="card-text">
                        <strong>API</strong><br>
                        Giao diện lập trình ứng dụng
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
        <div class="section-container">
            <div class="section-header">
                <h2 class="section-title">Tính năng nổi bật</h2>
                <p class="section-subtitle">Mọi thứ bạn cần để tra cứu và học thuật ngữ IT hiệu quả</p>
            </div>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">📚</div>
                    <h3 class="feature-title">Từ điển chuyên ngành</h3>
                    <p class="feature-desc">Tập trung vào thuật ngữ lập trình, công nghệ thông tin và Software Engineering với định nghĩa chính xác</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3 class="feature-title">Tìm kiếm thông minh</h3>
                    <p class="feature-desc">Tìm từ Anh-Việt, Việt-Anh nhanh chóng với gợi ý tự động và kết quả chính xác</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">✨</div>
                    <h3 class="feature-title">Đóng góp cộng đồng</h3>
                    <p class="feature-desc">Đề xuất từ mới, bổ sung nghĩa, giúp từ điển ngày càng phong phú hơn</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3 class="feature-title">Thống kê cá nhân</h3>
                    <p class="feature-desc">Theo dõi lịch sử tìm kiếm, số từ đã đóng góp và tiến độ học tập của bạn</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h3 class="feature-title">Giao diện trực quan</h3>
                    <p class="feature-desc">Thiết kế đơn giản, dễ sử dụng, tập trung vào trải nghiệm người dùng tốt nhất</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3 class="feature-title">Miễn phí 100%</h3>
                    <p class="feature-desc">Hoàn toàn miễn phí cho mọi developer Việt Nam, không giới hạn số lần tra cứu</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="how-section">
        <div class="section-container">
            <div class="section-header">
                <h2 class="section-title">Cách thức hoạt động</h2>
                <p class="section-subtitle">Ba bước đơn giản để bắt đầu sử dụng Eden Dictionary</p>
            </div>
            
            <div class="steps-container">
                <div class="step-item">
                    <div class="step-number">1</div>
                    <div class="step-content">
                        <h3 class="step-title">Đăng nhập tài khoản</h3>
                        <p class="step-desc">Tạo tài khoản miễn phí hoặc đăng nhập để bắt đầu sử dụng</p>
                    </div>
                </div>
                
                <div class="step-arrow">→</div>
                
                <div class="step-item">
                    <div class="step-number">2</div>
                    <div class="step-content">
                        <h3 class="step-title">Tra cứu từ vựng</h3>
                        <p class="step-desc">Tìm kiếm thuật ngữ IT bất cứ lúc nào, mọi nơi</p>
                    </div>
                </div>
                
                <div class="step-arrow">→</div>
                
                <div class="step-item">
                    <div class="step-number">3</div>
                    <div class="step-content">
                        <h3 class="step-title">Đóng góp & Học tập</h3>
                        <p class="step-desc">Đề xuất từ mới và học hỏi từ cộng đồng</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Us Section -->
    <section id="about" class="about-section">
        <div class="section-container">
            <div class="about-content">
                <div class="about-text">
                    <h2 class="section-title">Về Eden Dictionary</h2>
                    <p class="about-description">
                        Eden Dictionary là dự án từ điển Anh-Việt chuyên ngành IT được xây dựng 
                        <strong>bởi developer, vì developer</strong>. Chúng tôi hiểu rằng việc tra cứu 
                        thuật ngữ lập trình chính xác là vô cùng quan trọng trong quá trình học tập và làm việc.
                    </p>
                    <p class="about-description">
                        Với sứ mệnh <strong>giúp developer Việt Nam tiếp cận kiến thức công nghệ dễ dàng hơn</strong>, 
                        chúng tôi tập trung vào việc cung cấp định nghĩa chính xác, dễ hiểu và cập nhật liên tục 
                        từ cộng đồng.
                    </p>
                    
                    <div class="about-features">
                        <div class="about-feature-item">
                            <div class="feature-check">✓</div>
                            <div>
                                <strong>Chính xác</strong>
                                <p>Định nghĩa được kiểm duyệt bởi admin</p>
                            </div>
                        </div>
                        <div class="about-feature-item">
                            <div class="feature-check">✓</div>
                            <div>
                                <strong>Cộng đồng</strong>
                                <p>Mọi developer đều có thể đóng góp</p>
                            </div>
                        </div>
                        <div class="about-feature-item">
                            <div class="feature-check">✓</div>
                            <div>
                                <strong>Miễn phí</strong>
                                <p>100% miễn phí cho mọi người</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="about-visual">
                    <div class="about-stats-card">
                        <div class="stat-big">
                            <div class="stat-big-number">1,000+</div>
                            <div class="stat-big-label">Thuật ngữ IT</div>
                        </div>
                        <div class="stat-big">
                            <div class="stat-big-number">500+</div>
                            <div class="stat-big-label">Developer</div>
                        </div>
                        <div class="stat-big">
                            <div class="stat-big-number">95%</div>
                            <div class="stat-big-label">Độ chính xác</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section">
        <div class="section-container">
            <div class="section-header">
                <h2 class="section-title">Liên hệ với chúng tôi</h2>
                <p class="section-subtitle">Có câu hỏi hoặc góp ý? Chúng tôi luôn sẵn sàng lắng nghe!</p>
            </div>
            
            <div class="contact-content">
                <div class="contact-info">
                    <div class="contact-item">
                        <div class="contact-icon">📧</div>
                        <div class="contact-details">
                            <h3>Email</h3>
                            <p>Trieulinhnk2@gmail.com</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">📱</div>
                        <div class="contact-details">
                            <h3>Điện thoại</h3>
                            <p>0365757739</p>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">🌐</div>
                        <div class="contact-details">
                            <h3>Social Media</h3>
                            <div class="contact-social">
                                <a href="#" class="social-btn">Facebook</a>
                                <a href="#" class="social-btn">GitHub</a>
                                <a href="#" class="social-btn">LinkedIn</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="contact-form-wrapper">
                    <form class="contact-form">
                        <div class="form-group">
                            <label for="name">Họ và tên</label>
                            <input type="text" id="name" name="name" placeholder="Nguyễn Văn A" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="message">Tin nhắn</label>
                            <textarea id="message" name="message" rows="5" placeholder="Nội dung tin nhắn của bạn..." required></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit">
                            Gửi tin nhắn
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                                <path d="M7.5 15L12.5 10L7.5 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="cta-container">
            <h2 class="cta-title">Sẵn sàng bắt đầu?</h2>
            <p class="cta-subtitle">Tham gia cùng hàng trăm developer đang sử dụng Eden Dictionary</p>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-cta">
                Đăng nhập ngay
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="landing-footer">
        <div class="footer-container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3 class="footer-title">Về Eden Dictionary</h3>
                    <p class="footer-text">
                        Từ điển Anh-Việt chuyên ngành IT dành cho Software Engineer Việt Nam.
                        Được xây dựng bởi developer, vì developer.
                    </p>
                </div>
                
                <div class="footer-section">
                    <h3 class="footer-title">Liên hệ</h3>
                    <p class="footer-text">
                        Email: Trieulinhnk2@gmail.com<br>
                        Điện thoại: 0365757739
                    </p>
                </div>
                
                <div class="footer-section">
                    <h3 class="footer-title">Theo dõi</h3>
                    <div class="footer-social">
                        <a href="#" class="social-link">Facebook</a>
                        <a href="#" class="social-link">GitHub</a>
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

    <!-- Smooth Scroll Script -->
    <script>
        // Smooth scroll cho anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>

