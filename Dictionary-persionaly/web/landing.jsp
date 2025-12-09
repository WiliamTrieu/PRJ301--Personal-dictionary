<%-- 
    Document   : landing
    Created on : Dec 8, 2025
    Author     : PRJ301
    Description: Landing page for Eden Dictionary - Premium Dark Theme
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Từ điển Anh-Việt cá nhân - Học từ vựng theo cách của bạn">
    <title>Eden Dictionary - Từ điển Cá nhân</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #1a3a2a;
            --primary: #2d5a3d;
            --primary-light: #3d7a52;
            --accent: #c9a962;
            --text-light: #f5f5f5;
            --text-muted: rgba(255,255,255,0.7);
            --bg-dark: #162a1f;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--text-light);
            background: var(--primary-dark);
            overflow-x: hidden;
        }
        
        /* Noise Texture Overlay */
        .noise-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 9999;
            opacity: 0.03;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
        }
        
        /* Twinkling Stars Effect */
        .stars-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
            overflow: hidden;
        }
        
        .star {
            position: absolute;
            width: 2px;
            height: 2px;
            background: #fff;
            border-radius: 50%;
            opacity: 0;
            animation: twinkle var(--duration) ease-in-out infinite;
            animation-delay: var(--delay);
        }
        
        .star.large {
            width: 3px;
            height: 3px;
            box-shadow: 0 0 6px 1px rgba(255, 255, 255, 0.3);
        }
        
        .star.medium {
            width: 2px;
            height: 2px;
            box-shadow: 0 0 4px 1px rgba(255, 255, 255, 0.2);
        }
        
        @keyframes twinkle {
            0%, 100% {
                opacity: 0;
                transform: scale(0.5);
            }
            50% {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        /* Shooting star effect */
        .shooting-star {
            position: absolute;
            width: 100px;
            height: 1px;
            background: linear-gradient(90deg, rgba(255,255,255,0.8), transparent);
            opacity: 0;
            animation: shoot 3s ease-out infinite;
            transform: rotate(-45deg);
        }
        
        @keyframes shoot {
            0% {
                opacity: 0;
                transform: translateX(0) translateY(0) rotate(-45deg);
            }
            5% {
                opacity: 1;
            }
            20% {
                opacity: 0;
                transform: translateX(300px) translateY(300px) rotate(-45deg);
            }
            100% {
                opacity: 0;
            }
        }
        
        /* Header */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: var(--primary-dark);
            padding: 20px 0;
            transition: all 0.3s;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        
        .header.scrolled {
            padding: 15px 0;
            background: rgba(26, 58, 42, 0.98);
            backdrop-filter: blur(20px);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-family: 'Inter', sans-serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .logo-icon {
            width: 32px;
            height: 32px;
            background: var(--text-light);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-dark);
            font-weight: 700;
            font-size: 18px;
        }
        
        .nav-buttons {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            cursor: pointer;
        }
        
        .btn-ghost {
            background: transparent;
            color: var(--text-light);
            padding: 10px 20px;
        }
        
        .btn-ghost:hover {
            background: rgba(255,255,255,0.1);
        }
        
        .btn-outline {
            background: transparent;
            color: var(--text-light);
            border: 1px solid rgba(255,255,255,0.3);
        }
        
        .btn-outline:hover {
            background: var(--text-light);
            color: var(--primary-dark);
        }
        
        .btn-primary {
            background: var(--text-light);
            color: var(--primary-dark);
        }
        
        .btn-primary:hover {
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        
        /* Hero Section */
        .hero {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 120px 24px 80px;
            background: var(--primary-dark);
            position: relative;
        }
        
        .hero-content {
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }
        
        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(36px, 6vw, 56px);
            font-weight: 400;
            line-height: 1.3;
            margin-bottom: 30px;
            color: var(--text-light);
            font-style: italic;
        }
        
        .hero-title .static-line {
            display: block;
            margin-bottom: 10px;
        }
        
        .hero-title .typing-line {
            display: block;
        }
        
        /* Typing Cursor - follows text */
        .typing-cursor {
            display: inline-block;
            width: 3px;
            height: 1em;
            background: var(--accent);
            margin-left: 2px;
            animation: cursorBlink 1s infinite;
            vertical-align: baseline;
        }
        
        @keyframes cursorBlink {
            0%, 50% { opacity: 1; }
            51%, 100% { opacity: 0; }
        }
        
        .hero-subtitle {
            font-size: 18px;
            color: var(--text-muted);
            margin-bottom: 50px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.8;
        }
        
        .hero-subtitle strong {
            color: var(--text-light);
        }
        
        .hero-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .hero-note {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 16px;
        }
        
        /* Floating Cards */
        .floating-cards {
            position: relative;
            width: 100%;
            max-width: 1200px;
            height: 400px;
            margin: 60px auto 0;
            perspective: 1000px;
        }
        
        .float-card {
            position: absolute;
            background: rgba(255,255,255,0.95);
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            color: #333;
            transition: all 0.4s ease;
        }
        
        .float-card:hover {
            transform: translateY(-10px) scale(1.02);
        }
        
        .float-card.card-1 {
            left: 5%;
            top: 20%;
            width: 200px;
            animation: floatCard1 6s ease-in-out infinite;
        }
        
        .float-card.card-2 {
            left: 35%;
            top: 30%;
            width: 280px;
            z-index: 2;
            animation: floatCard2 5s ease-in-out infinite;
        }
        
        .float-card.card-3 {
            right: 5%;
            top: 10%;
            width: 240px;
            animation: floatCard3 7s ease-in-out infinite;
        }
        
        @keyframes floatCard1 {
            0%, 100% { transform: translateY(0) rotate(-2deg); }
            50% { transform: translateY(-15px) rotate(0deg); }
        }
        
        @keyframes floatCard2 {
            0%, 100% { transform: translateY(0) rotate(1deg); }
            50% { transform: translateY(-20px) rotate(-1deg); }
        }
        
        @keyframes floatCard3 {
            0%, 100% { transform: translateY(0) rotate(2deg); }
            50% { transform: translateY(-12px) rotate(0deg); }
        }
        
        .card-word {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 4px;
        }
        
        .card-ipa {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }
        
        .card-meaning {
            font-size: 16px;
            color: var(--primary);
        }
        
        .card-tag {
            display: inline-block;
            padding: 4px 12px;
            background: var(--primary-light);
            color: white;
            border-radius: 12px;
            font-size: 12px;
            margin-top: 10px;
        }
        
        /* Features Section */
        .features {
            padding: 120px 24px;
            background: var(--bg-dark);
            position: relative;
        }
        
        .features-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 80px;
        }
        
        .section-tag {
            display: inline-block;
            padding: 8px 20px;
            background: rgba(201, 169, 98, 0.2);
            color: var(--accent);
            border-radius: 25px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 24px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 48px;
            font-weight: 400;
            color: var(--text-light);
            margin-bottom: 16px;
            font-style: italic;
        }
        
        .section-header p {
            font-size: 18px;
            color: var(--text-muted);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        
        .feature-card {
            padding: 40px 30px;
            background: rgba(255,255,255,0.03);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.08);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.4s;
        }
        
        .feature-card:hover {
            transform: translateY(-8px);
            border-color: rgba(255,255,255,0.15);
            background: rgba(255,255,255,0.05);
        }
        
        .feature-card:hover::before {
            opacity: 1;
        }
        
        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 24px;
        }
        
        .feature-card h3 {
            font-size: 22px;
            font-weight: 600;
            color: var(--text-light);
            margin-bottom: 12px;
        }
        
        .feature-card p {
            color: var(--text-muted);
            line-height: 1.7;
            font-size: 15px;
        }
        
        /* Stats Section */
        .stats {
            padding: 80px 24px;
            background: var(--primary-dark);
        }
        
        .stats-container {
            max-width: 1000px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px;
            text-align: center;
        }
        
        .stat-item {
            padding: 30px;
        }
        
        .stat-number {
            font-family: 'Playfair Display', serif;
            font-size: 56px;
            font-weight: 400;
            color: var(--accent);
            display: block;
            font-style: italic;
        }
        
        .stat-label {
            font-size: 15px;
            color: var(--text-muted);
            margin-top: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* CTA Section */
        .cta {
            padding: 140px 24px;
            background: var(--primary);
            position: relative;
            overflow: hidden;
        }
        
        .cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.8' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
            opacity: 0.05;
        }
        
        .cta-container {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
            position: relative;
            z-index: 1;
        }
        
        .cta h2 {
            font-family: 'Playfair Display', serif;
            font-size: 52px;
            font-weight: 400;
            margin-bottom: 24px;
            color: var(--text-light);
            font-style: italic;
        }
        
        .cta p {
            font-size: 20px;
            margin-bottom: 50px;
            color: var(--text-muted);
        }
        
        .btn-cta {
            background: var(--text-light);
            color: var(--primary-dark);
            padding: 18px 50px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 30px;
        }
        
        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        
        /* Footer */
        .footer {
            padding: 60px 24px 40px;
            background: var(--bg-dark);
            border-top: 1px solid rgba(255,255,255,0.05);
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 60px;
        }
        
        .footer-brand {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }
        
        .footer-logo {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .footer-social {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }
        
        .footer-social a {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .footer-social a:hover {
            background: var(--accent);
            color: var(--primary-dark);
        }
        
        .footer-links {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
        }
        
        .footer-column h4 {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-light);
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .footer-column ul {
            list-style: none;
        }
        
        .footer-column li {
            margin-bottom: 12px;
        }
        
        .footer-column a {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.3s;
            font-size: 15px;
        }
        
        .footer-column a:hover {
            color: var(--accent);
        }
        
        .footer-bottom {
            max-width: 1200px;
            margin: 60px auto 0;
            padding-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.05);
            text-align: left;
            color: var(--text-muted);
            font-size: 14px;
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .floating-cards {
                display: none;
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 32px;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .section-header h2 {
                font-size: 36px;
            }
            
            .cta h2 {
                font-size: 36px;
            }
            
            .nav-buttons .btn-ghost {
                display: none;
            }
            
            .footer-links {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Noise Overlay -->
    <div class="noise-overlay"></div>
    
    <!-- Twinkling Stars -->
    <div class="stars-container" id="starsContainer"></div>
    
    <!-- Header -->
    <header class="header" id="header">
        <div class="header-content">
            <a href="#" class="logo">
                <span class="logo-icon">E</span>
                Eden Dictionary
            </a>
            <nav class="nav-buttons">
                <a href="#features" class="btn btn-ghost">Tính năng</a>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">
                    Đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">
                    Đăng ký ngay
                </a>
            </nav>
        </div>
    </header>
    
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1 class="hero-title">
                <span class="static-line">Từ điển Cá Nhân</span>
                <span class="typing-line"><span id="typingText"></span><span class="typing-cursor"></span></span>
            </h1>
            <p class="hero-subtitle">
                Tra cứu, lưu từ yêu thích, và xây dựng kho từ vựng riêng với <strong>Eden Dictionary</strong> - 
                nơi bạn học từ vựng theo cách của riêng mình.
            </p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">
                    Bắt đầu ngay
                </a>
            </div>
            <p class="hero-note">Miễn phí hoàn toàn. Không cần thẻ tín dụng.</p>
        </div>
        
        <!-- Floating Cards -->
        <div class="floating-cards">
            <div class="float-card card-1">
                <div class="card-word">hello</div>
                <div class="card-ipa">/həˈləʊ/</div>
                <div class="card-meaning">xin chào</div>
                <span class="card-tag">Đã lưu ⭐</span>
            </div>
            
            <div class="float-card card-2">
                <div class="card-word">facilitate</div>
                <div class="card-ipa">/fəˈsɪlɪteɪt/</div>
                <div class="card-meaning">tạo điều kiện, hỗ trợ</div>
                <span class="card-tag">TOEFL</span>
            </div>
            
            <div class="float-card card-3">
                <div class="card-word">algorithm</div>
                <div class="card-ipa">/ˈælɡərɪðəm/</div>
                <div class="card-meaning">thuật toán</div>
                <span class="card-tag">Tech</span>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section class="stats">
        <div class="stats-container">
            <div class="stat-item">
                <span class="stat-number" data-target="1500">0</span>
                <span class="stat-label">Từ vựng</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" data-target="500">0</span>
                <span class="stat-label">Người dùng</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" data-target="150">0</span>
                <span class="stat-label">Đề xuất mới</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" data-target="99">0</span>
                <span class="stat-label">% Hài lòng</span>
            </div>
        </div>
    </section>
    
    <!-- Features Section -->
    <section class="features" id="features">
        <div class="features-container">
            <div class="section-header">
                <span class="section-tag">✨ Tính năng</span>
                <h2>Tại sao chọn Eden?</h2>
                <p>Không chỉ là từ điển, mà là nơi bạn xây dựng kho từ vựng của riêng mình</p>
            </div>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3>Tra cứu thông minh</h3>
                    <p>Tìm kiếm nhanh với gợi ý tự động. Hỗ trợ cả Anh-Việt và Việt-Anh.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">⭐</div>
                    <h3>Lưu từ yêu thích</h3>
                    <p>Xây dựng bộ từ vựng riêng. Thêm ghi chú cá nhân cho mỗi từ.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">➕</div>
                    <h3>Đóng góp từ mới</h3>
                    <p>Đề xuất từ chưa có trong từ điển. Cộng đồng sẽ review và bổ sung.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">✏️</div>
                    <h3>Chỉnh sửa linh hoạt</h3>
                    <p>Đề xuất sửa định nghĩa chưa chính xác. Cải thiện chất lượng từ điển.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Theo dõi tiến độ</h3>
                    <p>Xem số từ đã lưu, đề xuất đã duyệt, và lịch sử học tập của bạn.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🌐</div>
                    <h3>Cộng đồng học tập</h3>
                    <p>Cùng ngàn người dùng xây dựng từ điển hoàn hảo nhất.</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- CTA Section -->
    <section class="cta">
        <div class="cta-container">
            <h2>Sẵn sàng bắt đầu?</h2>
            <p>Tham gia Eden Dictionary ngay hôm nay - Hoàn toàn miễn phí!</p>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-cta">
                Đăng ký miễn phí →
            </a>
        </div>
    </section>
    
    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-brand">
                <div>
                    <div class="footer-logo">
                        <span class="logo-icon">E</span>
                        Eden Dictionary

                    </div>
                    <div class="footer-social">
                        <a href="#" title="Facebook">f</a>
                        <a href="#" title="Twitter">𝕏</a>
                        <a href="#" title="Instagram">◎</a>
                    </div>
                </div>
            </div>
            
            <div class="footer-links">
                <div class="footer-column">
                    <h4>Hỗ trợ</h4>
                    <ul>
                        <li><a href="#">Email: Trieulinhnk2@gmail.com</a></li>
                        <li><a href="#">Điện thoại: 0365757739</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h4>Pháp lý</h4>
                    <ul>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            © 2025 Eden Dictionary. Tất cả quyền được bảo lưu.
        </div>
    </footer>
    
    <script>
        // ==========================================
        // 1. TYPING EFFECT
        // ==========================================
        const phrases = [
            'Học Theo Cách Của Bạn',
            'Lưu Từ Yêu Thích',
            'Xây Dựng Vốn Từ Riêng',
            'Tra Cứu Thông Minh'
        ];
        let phraseIndex = 0;
        let charIndex = 0;
        let isDeleting = false;
        let typingSpeed = 80;
        
        function typeEffect() {
            const currentPhrase = phrases[phraseIndex];
            const typingText = document.getElementById('typingText');
            
            if (isDeleting) {
                typingText.textContent = currentPhrase.substring(0, charIndex - 1);
                charIndex--;
                typingSpeed = 40;
            } else {
                typingText.textContent = currentPhrase.substring(0, charIndex + 1);
                charIndex++;
                typingSpeed = 80;
            }
            
            if (!isDeleting && charIndex === currentPhrase.length) {
                typingSpeed = 2500; // Pause at end
                isDeleting = true;
            } else if (isDeleting && charIndex === 0) {
                isDeleting = false;
                phraseIndex = (phraseIndex + 1) % phrases.length;
                typingSpeed = 500; // Pause before next word
            }
            
            setTimeout(typeEffect, typingSpeed);
        }
        
        // Start typing
        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(typeEffect, 800);
        });
        
        // ==========================================
        // 2. COUNTER ANIMATION
        // ==========================================
        let countersAnimated = false;
        
        function animateCounters() {
            if (countersAnimated) return;
            countersAnimated = true;
            
            const counters = document.querySelectorAll('.stat-number');
            counters.forEach(counter => {
                const target = parseInt(counter.getAttribute('data-target'));
                const duration = 2000;
                const step = target / (duration / 16);
                let current = 0;
                
                const updateCounter = () => {
                    current += step;
                    if (current < target) {
                        counter.textContent = Math.floor(current);
                        requestAnimationFrame(updateCounter);
                    } else {
                        const label = counter.parentElement.querySelector('.stat-label').textContent;
                        counter.textContent = target + (label.includes('%') ? '%' : '+');
                    }
                };
                
                updateCounter();
            });
        }
        
        // ==========================================
        // 3. SCROLL EFFECTS
        // ==========================================
        const statsSection = document.querySelector('.stats');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounters();
                }
            });
        }, { threshold: 0.5 });
        
        observer.observe(statsSection);
        
        // Header scroll
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
        
        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
        
        // ==========================================
        // 4. TWINKLING STARS EFFECT
        // ==========================================
        function createStars() {
            const container = document.getElementById('starsContainer');
            const numberOfStars = 80; // Số lượng sao
            
            for (let i = 0; i < numberOfStars; i++) {
                const star = document.createElement('div');
                star.className = 'star';
                
                // Random size
                const sizeClass = Math.random() > 0.7 ? 'large' : (Math.random() > 0.5 ? 'medium' : '');
                if (sizeClass) star.classList.add(sizeClass);
                
                // Random position
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                
                // Random animation timing
                star.style.setProperty('--duration', (2 + Math.random() * 3) + 's');
                star.style.setProperty('--delay', Math.random() * 5 + 's');
                
                container.appendChild(star);
            }
            
            // Add shooting stars
            for (let i = 0; i < 3; i++) {
                const shootingStar = document.createElement('div');
                shootingStar.className = 'shooting-star';
                shootingStar.style.left = (20 + Math.random() * 60) + '%';
                shootingStar.style.top = (10 + Math.random() * 30) + '%';
                shootingStar.style.animationDelay = (i * 5 + Math.random() * 3) + 's';
                container.appendChild(shootingStar);
            }
        }
        
        // Create stars on page load
        createStars();
    </script>
</body>
</html>
