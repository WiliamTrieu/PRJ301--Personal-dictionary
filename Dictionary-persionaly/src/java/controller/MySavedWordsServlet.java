package controller;

import Dao.UserSavedWordDAO;
import model.UserSavedWord;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * MySavedWordsServlet - Display user's personal vocabulary
 * @author PRJ301
 */
@WebServlet(name = "MySavedWordsServlet", urlPatterns = {"/MySavedWordsServlet"})
public class MySavedWordsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        
        // Get saved words
        UserSavedWordDAO dao = new UserSavedWordDAO();
        List<UserSavedWord> savedWords = dao.getSavedWords(userId);
        int totalCount = savedWords.size();
        
        // Set attributes
        request.setAttribute("savedWords", savedWords);
        request.setAttribute("totalCount", totalCount);
        
        // Forward to JSP
        request.getRequestDispatcher("/user/my-saved-words.jsp").forward(request, response);
    }
}

