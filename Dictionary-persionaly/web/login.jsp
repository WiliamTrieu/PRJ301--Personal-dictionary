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
<body>
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
                    <div style="background: #fee2e2; color: #dc2626; padding: 12px; border-radius: 8px; margin-bottom: 16px;">
                        ${error}
                    </div>
                </c:if>
                <form class="waitlist-form" id="waitlistForm" method="POST" action="${pageContext.request.contextPath}/LoginServlet">
                    <div class="email-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <polyline points="22,6 12,13 2,6" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <input type="email" id="email" name="email" placeholder="Your account" required>
                    </div>
                    <div class="email-input-container">
                        <svg class="email-icon" width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <polyline points="22,6 12,13 2,6" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <input type="password" id="password" name="password" placeholder="Your password" required>
                    </div>
                    <button type="submit" class="waitlist-btn">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M22 2L11 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <polygon points="22,2 15,22 11,13 2,9 22,2" fill="currentColor"/>
                        </svg>
                        Log in
                    </button>
                </form>
            </div>
            
            <div class="eden-footer">
                <a href="#" class="footer-link">Sign in</a>
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
        // Form validation và submit handling
        document.getElementById('waitlistForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
                return false;
            }
        });
    </script>
</body>
</html>
     