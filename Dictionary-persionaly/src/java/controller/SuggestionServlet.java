package controller;

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
 * SuggestionServlet - Xử lý đề xuất từ mới
 * 
 * @author PRJ301
 */
@WebServlet(name = "SuggestionServlet", urlPatterns = {"/SuggestionServlet"})
public class SuggestionServlet extends HttpServlet {

    /**
     * Xử lý GET request - Hiển thị form đề xuất hoặc danh sách đề xuất
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("my-suggestions".equals(action)) {
            // ===== XEM DANH SÁCH ĐỀ XUẤT CỦA USER =====
            int userId = (Integer) session.getAttribute("userId");
            WordSuggestionDAO dao = new WordSuggestionDAO();
            
            // Lấy status filter từ parameter
            String statusFilter = request.getParameter("status");
            
            // Lấy suggestions theo filter
            List<WordSuggestion> suggestions;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                // Filter theo status cụ thể
                suggestions = dao.getSuggestionsByUserAndStatus(userId, statusFilter.trim());
            } else {
                // Lấy TẤT CẢ (không filter)
                suggestions = dao.getSuggestionsByUser(userId);
            }
            
            // ===== TÍNH TOÁN STATISTICS =====
            // Lấy tất cả suggestions để đếm
            List<WordSuggestion> allSuggestions = dao.getSuggestionsByUser(userId);
            
            int totalCount = allSuggestions.size();
            int pendingCount = 0;
            int approvedCount = 0;
            int rejectedCount = 0;
            
            for (WordSuggestion s : allSuggestions) {
                switch (s.getStatus().toLowerCase()) {
                    case "pending":
                        pendingCount++;
                        break;
                    case "approved":
                        approvedCount++;
                        break;
                    case "rejected":
                        rejectedCount++;
                        break;
                }
            }
            
            // Set attributes
            request.setAttribute("suggestions", suggestions);
            request.setAttribute("statusFilter", statusFilter);
            
            // Statistics
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("approvedCount", approvedCount);
            request.setAttribute("rejectedCount", rejectedCount);
            
            request.getRequestDispatcher("user/my-suggestions.jsp").forward(request, response);
            
        } else {
            // Hiển thị form đề xuất mới
            String prefillWord = request.getParameter("word");
            if (prefillWord != null) {
                request.setAttribute("prefillWord", prefillWord);
            }
            request.getRequestDispatcher("user/suggest-word.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý POST request - Lưu đề xuất từ mới
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        
        // Lấy thông tin từ form
        String wordEnglish = request.getParameter("wordEnglish");
        String wordVietnamese = request.getParameter("wordVietnamese");
        String pronunciation = request.getParameter("pronunciation");
        String wordType = request.getParameter("wordType");
        String exampleSentence = request.getParameter("exampleSentence");
        String exampleTranslation = request.getParameter("exampleTranslation");
        
        // Validate required fields
        if (wordEnglish == null || wordEnglish.trim().isEmpty() ||
            wordVietnamese == null || wordVietnamese.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ từ tiếng Anh và tiếng Việt!");
            request.setAttribute("wordEnglish", wordEnglish);
            request.setAttribute("wordVietnamese", wordVietnamese);
            request.setAttribute("pronunciation", pronunciation);
            request.setAttribute("wordType", wordType);
            request.setAttribute("exampleSentence", exampleSentence);
            request.setAttribute("exampleTranslation", exampleTranslation);
            request.getRequestDispatcher("user/suggest-word.jsp").forward(request, response);
            return;
        }
        
        // Tạo WordSuggestion object
        WordSuggestion suggestion = new WordSuggestion();
        suggestion.setWordEnglish(wordEnglish.trim());
        suggestion.setWordVietnamese(wordVietnamese.trim());
        suggestion.setPronunciation(pronunciation != null ? pronunciation.trim() : null);
        suggestion.setWordType(wordType != null && !wordType.trim().isEmpty() ? wordType.trim() : null);
        suggestion.setExampleSentence(exampleSentence != null && !exampleSentence.trim().isEmpty() ? exampleSentence.trim() : null);
        suggestion.setExampleTranslation(exampleTranslation != null && !exampleTranslation.trim().isEmpty() ? exampleTranslation.trim() : null);
        suggestion.setSuggestedBy(userId);
        
        // Lưu vào database
        WordSuggestionDAO dao = new WordSuggestionDAO();
        boolean success = dao.insertSuggestion(suggestion);
        
        if (success) {
            request.setAttribute("success", "Đề xuất từ của bạn đã được gửi thành công! Vui lòng chờ admin duyệt.");
            request.getRequestDispatcher("user/suggest-word.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi gửi đề xuất. Vui lòng thử lại!");
            request.setAttribute("wordEnglish", wordEnglish);
            request.setAttribute("wordVietnamese", wordVietnamese);
            request.setAttribute("pronunciation", pronunciation);
            request.setAttribute("wordType", wordType);
            request.setAttribute("exampleSentence", exampleSentence);
            request.setAttribute("exampleTranslation", exampleTranslation);
            request.getRequestDispatcher("user/suggest-word.jsp").forward(request, response);
        }
    }
}

