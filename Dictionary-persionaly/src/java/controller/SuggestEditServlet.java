package controller;

import Dao.WordSuggestionDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * SuggestEditServlet - User suggests EDIT to existing word
 * 
 * @author PRJ301
 */
@WebServlet(name = "SuggestEditServlet", urlPatterns = {"/SuggestEditServlet"})
public class SuggestEditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Get form data
        String originalWordIdStr = request.getParameter("originalWordId");
        String suggestionType = request.getParameter("suggestionType");
        String wordEnglish = request.getParameter("wordEnglish");
        String wordVietnamese = request.getParameter("wordVietnamese");
        String pronunciation = request.getParameter("pronunciation");
        String wordType = request.getParameter("wordType");
        String exampleSentence = request.getParameter("exampleSentence");
        String exampleTranslation = request.getParameter("exampleTranslation");
        
        // Validate required fields
        if (originalWordIdStr == null || originalWordIdStr.trim().isEmpty() ||
            wordEnglish == null || wordEnglish.trim().isEmpty() ||
            wordVietnamese == null || wordVietnamese.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("user/suggest-edit.jsp").forward(request, response);
            return;
        }
        
        try {
            int originalWordId = Integer.parseInt(originalWordIdStr);
            
            // Create edit suggestion
            WordSuggestionDAO suggestionDAO = new WordSuggestionDAO();
            boolean success = suggestionDAO.createEditSuggestion(
                originalWordId,
                wordEnglish.trim(),
                wordVietnamese.trim(),
                pronunciation != null ? pronunciation.trim() : null,
                wordType != null ? wordType.trim() : null,
                exampleSentence != null ? exampleSentence.trim() : null,
                exampleTranslation != null ? exampleTranslation.trim() : null,
                user.getUserId()
            );
            
            if (success) {
                System.out.println("✅ Edit suggestion created: " + wordEnglish + " by user " + user.getUsername());
                request.setAttribute("success", 
                    "Đề xuất chỉnh sửa đã được gửi thành công! " +
                    "Admin sẽ xem xét và phê duyệt.");
            } else {
                System.err.println("❌ Failed to create edit suggestion for: " + wordEnglish);
                request.setAttribute("error", 
                    "Có lỗi xảy ra khi gửi đề xuất. Vui lòng thử lại!");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid word ID: " + originalWordIdStr);
            request.setAttribute("error", "ID từ không hợp lệ!");
        }
        
        // Forward back to form
        request.getRequestDispatcher("user/suggest-edit.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to dashboard if accessed directly
        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
    }
}

