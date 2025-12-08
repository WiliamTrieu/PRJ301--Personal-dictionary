package controller.admin;

import Dao.PasswordResetRequestDAO;
import model.PasswordResetRequest;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * PasswordResetServlet - Admin xem và xử lý password reset requests
 * 
 * @author PRJ301
 */
@WebServlet(name = "PasswordResetServlet", urlPatterns = {"/admin/PasswordResetServlet"})
public class PasswordResetServlet extends HttpServlet {

    /**
     * GET - Hiển thị danh sách requests
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin auth
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }
        
        // Lấy danh sách pending requests
        PasswordResetRequestDAO requestDAO = new PasswordResetRequestDAO();
        List<PasswordResetRequest> requests = requestDAO.getPendingRequests();
        
        request.setAttribute("requests", requests);
        request.setAttribute("totalRequests", requests.size());
        
        request.getRequestDispatcher("/admin/password-reset-requests.jsp").forward(request, response);
    }
    
    /**
     * POST - Xử lý actions (mark as read, complete)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check admin auth
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String requestIdStr = request.getParameter("requestId");
        
        if (action == null || requestIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/PasswordResetServlet");
            return;
        }
        
        try {
            int requestId = Integer.parseInt(requestIdStr);
            PasswordResetRequestDAO requestDAO = new PasswordResetRequestDAO();
            
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "markRead":
                    success = requestDAO.markAsRead(requestId);
                    message = success ? "Đã đánh dấu là đã đọc" : "Có lỗi xảy ra";
                    break;
                    
                case "complete":
                    success = requestDAO.markAsCompleted(requestId);
                    message = success ? "Đã xác nhận hoàn thành" : "Có lỗi xảy ra";
                    break;
                    
                default:
                    message = "Hành động không hợp lệ";
            }
            
            if (success) {
                request.setAttribute("success", message);
            } else {
                request.setAttribute("error", message);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Request ID không hợp lệ");
        }
        
        // Reload page
        doGet(request, response);
    }
}

