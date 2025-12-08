package controller;

import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RegisterServlet - Xử lý đăng ký user mới
 * 
 * @author PRJ301
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String agreeTerms = request.getParameter("agreeTerms");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate username format (chỉ cho phép chữ, số, underscore, dấu gạch ngang)
        if (!username.matches("^[a-zA-Z0-9_-]{3,50}$")) {
            request.setAttribute("error", "Tên đăng nhập chỉ được chứa chữ, số, gạch dưới và gạch ngang (3-50 ký tự)!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate password length
        if (password.length() < 8) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate password strength
        if (!password.matches(".*[A-Z].*") || !password.matches(".*[a-z].*") || !password.matches(".*[0-9].*")) {
            request.setAttribute("error", "Mật khẩu phải có chữ hoa, chữ thường và số!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate confirm password
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate terms agreement
        if (agreeTerms == null || !agreeTerms.equals("on")) {
            request.setAttribute("error", "Bạn phải đồng ý với Điều khoản sử dụng và Chính sách bảo mật!");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra username đã tồn tại chưa
        UserDAO userDAO = new UserDAO();
        if (userDAO.isUsernameExists(username.trim())) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại! Vui lòng chọn tên khác.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Đăng ký user
        boolean success = userDAO.registerUser(username.trim(), password, fullName.trim());
        
        if (success) {
            // Đăng ký thành công
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Đăng ký thất bại
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect về trang register
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}

