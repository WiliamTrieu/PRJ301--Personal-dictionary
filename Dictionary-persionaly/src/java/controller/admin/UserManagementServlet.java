package controller.admin;

import Dao.UserDAO;
import Dao.WordDAO;
import model.User;
import model.UserWithStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * UserManagementServlet - Load danh sách users với thống kê đóng góp
 * 
 * @author PRJ301
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/admin/UserManagementServlet"})
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        WordDAO wordDAO = new WordDAO();
        
        // Lấy danh sách users
        List<User> users = userDAO.getAllUsers();
        
        // Tạo danh sách users với stats
        List<UserWithStats> usersWithStats = new ArrayList<>();
        for (User user : users) {
            int contributionCount = wordDAO.countWordsByUser(user.getUserId());
            usersWithStats.add(new UserWithStats(user, contributionCount));
        }
        
        request.setAttribute("usersWithStats", usersWithStats);
        request.setAttribute("totalUsers", users.size());
        
        request.getRequestDispatcher("/admin/manage-users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("resetPassword".equals(action)) {
            // ===== ADMIN RESET PASSWORD CHO USER =====
            String userIdStr = request.getParameter("userId");
            String newPassword = request.getParameter("newPassword");
            
            // Validate input
            if (userIdStr == null || newPassword == null || newPassword.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                doGet(request, response);
                return;
            }
            
            // Validate password strength
            if (newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
                doGet(request, response);
                return;
            }
            
            try {
                int userId = Integer.parseInt(userIdStr);
                UserDAO userDAO = new UserDAO();
                
                // Get user info để log
                User user = userDAO.getUserById(userId);
                if (user == null) {
                    request.setAttribute("error", "Không tìm thấy user!");
                    doGet(request, response);
                    return;
                }
                
                // Reset password
                boolean success = userDAO.resetPassword(userId, newPassword);
                
                if (success) {
                    request.setAttribute("success", 
                        "Đã reset mật khẩu cho user: " + user.getUsername() + 
                        ". Vui lòng thông báo mật khẩu mới cho user!");
                    
                    // Log activity
                    System.out.println("[ADMIN RESET PASSWORD] Admin reset password for user: " + user.getUsername());
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi reset mật khẩu!");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "User ID không hợp lệ!");
            }
        }
        
        // Reload danh sách users
        doGet(request, response);
    }
}

