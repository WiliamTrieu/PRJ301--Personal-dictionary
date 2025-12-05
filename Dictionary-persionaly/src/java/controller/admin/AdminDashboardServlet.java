package controller.admin;

import Dao.WordDAO;
import Dao.WordSuggestionDAO;
import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AdminDashboardServlet - Load số liệu thống kê cho admin dashboard
 * 
 * @author PRJ301
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/AdminDashboardServlet"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Load statistics
        WordDAO wordDAO = new WordDAO();
        WordSuggestionDAO suggestionDAO = new WordSuggestionDAO();
        UserDAO userDAO = new UserDAO();
        
        int totalWords = wordDAO.countTotalWords();
        int pendingSuggestions = suggestionDAO.countPendingSuggestions();
        int totalUsers = userDAO.countTotalUsers();
        
        request.setAttribute("totalWords", totalWords);
        request.setAttribute("pendingSuggestions", pendingSuggestions);
        request.setAttribute("totalUsers", totalUsers);
        
        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }
}

