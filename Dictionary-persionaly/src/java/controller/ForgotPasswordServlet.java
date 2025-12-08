package controller;

import Dao.UserDAO;
import Dao.PasswordResetRequestDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ForgotPasswordServlet - Xử lý quên mật khẩu
 * Flow: User nhập username + security code + contact email
 * → Verify security code → Tạo request → Admin xử lý
 * 
 * @author PRJ301
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPasswordServlet"})
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Xử lý GET request - Hiển thị form quên mật khẩu
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
    
    /**
     * Xử lý POST request - Verify security code và tạo request
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String securityCode = request.getParameter("securityCode");
        String contactEmail = request.getParameter("contactEmail");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            securityCode == null || securityCode.trim().isEmpty() ||
            contactEmail == null || contactEmail.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.setAttribute("username", username);
            request.setAttribute("securityCode", securityCode);
            request.setAttribute("contactEmail", contactEmail);
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        username = username.trim();
        securityCode = securityCode.trim();
        contactEmail = contactEmail.trim();
        
        // Validate security code length
        if (securityCode.length() < 6) {
            request.setAttribute("error", "Mã bảo mật phải có ít nhất 6 ký tự!");
            request.setAttribute("username", username);
            request.setAttribute("contactEmail", contactEmail);
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        // Step 1: Verify username có tồn tại không
        User user = userDAO.getUserByUsername(username);
        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập không tồn tại!");
            request.setAttribute("username", username);
            request.setAttribute("contactEmail", contactEmail);
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Step 2: Verify security code
        boolean isValidSecurityCode = userDAO.verifySecurityCode(username, securityCode);
        if (!isValidSecurityCode) {
            request.setAttribute("error", "Mã bảo mật không đúng! Vui lòng kiểm tra lại.");
            request.setAttribute("username", username);
            request.setAttribute("contactEmail", contactEmail);
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Step 3: Tạo request trong database
        PasswordResetRequestDAO requestDAO = new PasswordResetRequestDAO();
        boolean created = requestDAO.createRequest(user.getUserId(), username, contactEmail);
        
        if (created) {
            // Thành công
            request.setAttribute("success", "Yêu cầu reset mật khẩu đã được gửi thành công!");
            System.out.println("[PASSWORD RESET REQUEST] User: " + username + ", Email: " + contactEmail);
        } else {
            // Thất bại
            request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại sau.");
            request.setAttribute("username", username);
            request.setAttribute("contactEmail", contactEmail);
        }
        
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}

