package controller;

import Dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LoginServlet - Xử lý đăng nhập
 * 
 * @author PRJ301
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Xử lý POST request từ form login
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(username.trim(), password);
        
        if (user != null) {
            // Đăng nhập thành công
            // Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());
            
            // Xử lý "Remember Me" - tăng session timeout
            String rememberMe = request.getParameter("rememberMe");
            if ("true".equals(rememberMe)) {
                // Nếu user chọn "Remember Me", tăng session timeout lên 7 ngày (604800 seconds)
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
            } else {
                // Mặc định session timeout là 30 phút (theo web.xml)
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
            }
            
            // Phân luồng theo role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                // Redirect đến trang admin dashboard trực quan (có search box)
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                // Redirect đến trang user
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }
        } else {
            // Đăng nhập thất bại - không cho biết cụ thể là username hay password sai
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng. Vui lòng thử lại!");
            request.setAttribute("username", username); // Giữ lại username để user không phải nhập lại
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý GET request (redirect về login page nếu chưa đăng nhập)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu đã đăng nhập, redirect đến dashboard tương ứng
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String role = (String) session.getAttribute("role");
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }
        } else {
            // Chưa đăng nhập, redirect về login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}

