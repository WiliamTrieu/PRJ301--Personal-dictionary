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
}

