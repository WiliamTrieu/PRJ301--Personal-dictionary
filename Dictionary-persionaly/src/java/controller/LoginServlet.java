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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(email.trim(), password);
        
        if (user != null) {
            // Đăng nhập thành công
            // Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());
            
            // Phân luồng theo role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                // Redirect đến trang admin dashboard JSP
                response.sendRedirect(request.getContextPath() + "/admin/admin-dashboard.jsp");
            } else {
                // Redirect đến trang user
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
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
                response.sendRedirect(request.getContextPath() + "/admin/admin-dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }
        } else {
            // Chưa đăng nhập, redirect về login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}

