package controller.admin;

import Dao.WordSuggestionDAO;
import model.WordSuggestion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * ApprovalListServlet - Load danh sách đề xuất chờ duyệt
 * 
 * @author PRJ301
 */
@WebServlet(name = "ApprovalListServlet", urlPatterns = {"/admin/ApprovalListServlet"})
public class ApprovalListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        WordSuggestionDAO dao = new WordSuggestionDAO();
        
        // Lấy danh sách đề xuất chờ duyệt
        List<WordSuggestion> pendingSuggestions = dao.getSuggestionsByStatus("pending");
        
        // Đếm số lượng
        int pendingCount = dao.countPendingSuggestions();
        
        request.setAttribute("suggestions", pendingSuggestions);
        request.setAttribute("pendingCount", pendingCount);
        request.getRequestDispatcher("/admin/approval-list.jsp").forward(request, response);
    }
}

