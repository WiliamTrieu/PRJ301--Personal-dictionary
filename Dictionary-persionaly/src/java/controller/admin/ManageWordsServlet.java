package controller.admin;

import Dao.WordDAO;
import model.Word;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * ManageWordsServlet - Load danh sách từ điển cho trang manage-words.jsp
 * 
 * @author PRJ301
 */
@WebServlet(name = "ManageWordsServlet", urlPatterns = {"/admin/ManageWordsServlet"})
public class ManageWordsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Check for success/error messages from session (sau khi redirect từ AdminWordServlet)
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        
        if (successMessage != null) {
            request.setAttribute("success", successMessage);
            session.removeAttribute("successMessage"); // Clear message sau khi hiển thị
        }
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            session.removeAttribute("errorMessage"); // Clear message sau khi hiển thị
        }
        
        WordDAO wordDAO = new WordDAO();
        String keyword = request.getParameter("keyword");
        
        List<Word> words;
        if (keyword != null && !keyword.trim().isEmpty()) {
            words = wordDAO.searchWord(keyword.trim());
        } else {
            words = wordDAO.getAllWords(1, 100);
        }
        
        int totalWords = wordDAO.countTotalWords();
        
        request.setAttribute("words", words);
        request.setAttribute("totalWords", totalWords);
        request.getRequestDispatcher("/admin/manage-words.jsp").forward(request, response);
    }
}

