package controller.admin;

import Dao.WordDAO;
import Dao.WordSuggestionDAO;
import Dao.UserDAO;
import model.Word;
import model.WordSuggestion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * ApprovalServlet - Xử lý duyệt đề xuất từ cho Admin
 * 
 * @author PRJ301
 */
@WebServlet(name = "ApprovalServlet", urlPatterns = {"/admin/ApprovalServlet"})
public class ApprovalServlet extends HttpServlet {

    /**
     * Xử lý POST request - Duyệt hoặc từ chối đề xuất
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        int adminId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String suggestionIdStr = request.getParameter("suggestionId");
        
        if (suggestionIdStr == null || suggestionIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID đề xuất không hợp lệ!");
            request.getRequestDispatcher("../admin/ApprovalListServlet").forward(request, response);
            return;
        }
        
        try {
            int suggestionId = Integer.parseInt(suggestionIdStr);
            WordSuggestionDAO suggestionDAO = new WordSuggestionDAO();
            WordSuggestion suggestion = suggestionDAO.getSuggestionById(suggestionId);
            
            if (suggestion == null) {
                request.setAttribute("error", "Không tìm thấy đề xuất!");
                request.getRequestDispatcher("../admin/ApprovalListServlet").forward(request, response);
                return;
            }
            
            if ("approve".equals(action)) {
                // Approve đề xuất
                // 1. Thêm vào Dictionary
                Word word = new Word();
                word.setWordEnglish(suggestion.getWordEnglish());
                word.setWordVietnamese(suggestion.getWordVietnamese());
                word.setPronunciation(suggestion.getPronunciation());
                word.setWordType(suggestion.getWordType());
                word.setExampleSentence(suggestion.getExampleSentence());
                word.setExampleTranslation(suggestion.getExampleTranslation());
                word.setCreatedBy(suggestion.getSuggestedBy());
                
                WordDAO wordDAO = new WordDAO();
                boolean wordAdded = wordDAO.insertWord(word);
                
                if (wordAdded) {
                    // 2. Cập nhật trạng thái đề xuất
                    String reviewNote = request.getParameter("reviewNote");
                    if (reviewNote == null) reviewNote = "";
                    boolean statusUpdated = suggestionDAO.updateSuggestionStatus(
                        suggestionId, "approved", adminId, reviewNote);
                    
                    if (statusUpdated) {
                        request.setAttribute("success", "Đã chấp nhận và thêm từ vào từ điển!");
                    } else {
                        request.setAttribute("error", "Đã thêm từ nhưng không cập nhật được trạng thái!");
                    }
                } else {
                    request.setAttribute("error", "Không thể thêm từ vào từ điển!");
                }
                
            } else if ("reject".equals(action)) {
                // Reject đề xuất
                String reviewNote = request.getParameter("reviewNote");
                if (reviewNote == null || reviewNote.trim().isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập lý do từ chối!");
                    request.setAttribute("suggestion", suggestion);
                    request.getRequestDispatcher("../admin/approval-list.jsp").forward(request, response);
                    return;
                }
                
                boolean statusUpdated = suggestionDAO.updateSuggestionStatus(
                    suggestionId, "rejected", adminId, reviewNote.trim());
                
                if (statusUpdated) {
                    request.setAttribute("success", "Đã từ chối đề xuất!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi từ chối đề xuất!");
                }
            }
            
            // Redirect về trang approval list
            response.sendRedirect(request.getContextPath() + "/admin/ApprovalListServlet");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ!");
            request.getRequestDispatcher("../admin/ApprovalListServlet").forward(request, response);
        }
    }
}

