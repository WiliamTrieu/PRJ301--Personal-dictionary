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

/**
 * AdminWordServlet - Xử lý CRUD từ điển cho Admin
 * 
 * @author PRJ301
 */
@WebServlet(name = "AdminWordServlet", urlPatterns = {"/admin/AdminWordServlet"})
public class AdminWordServlet extends HttpServlet {

    /**
     * Xử lý GET request - Hiển thị danh sách từ điển
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        WordDAO wordDAO = new WordDAO();
        
        if ("edit".equals(action)) {
            // Hiển thị form edit
            String wordIdStr = request.getParameter("id");
            if (wordIdStr != null) {
                try {
                    int wordId = Integer.parseInt(wordIdStr);
                    Word word = wordDAO.getWordById(wordId);
                    if (word != null) {
                        request.setAttribute("word", word);
                        request.getRequestDispatcher("../admin/edit-word.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Không tìm thấy từ!");
                        request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID không hợp lệ!");
                    request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            // Xóa từ
            String wordIdStr = request.getParameter("id");
            if (wordIdStr != null) {
                try {
                    int wordId = Integer.parseInt(wordIdStr);
                    boolean success = wordDAO.deleteWord(wordId);
                    if (success) {
                        request.setAttribute("success", "Xóa từ thành công!");
                    } else {
                        request.setAttribute("error", "Có lỗi xảy ra khi xóa từ!");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID không hợp lệ!");
                }
            }
            request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
        } else {
            // Hiển thị danh sách từ điển
            request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý POST request - Thêm hoặc cập nhật từ
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
        WordDAO wordDAO = new WordDAO();
        
        if ("add".equals(action)) {
            // Thêm từ mới
            Word word = createWordFromRequest(request);
            word.setCreatedBy(adminId);
            
            // Kiểm tra từ đã tồn tại chưa
            if (wordDAO.wordExists(word.getWordEnglish())) {
                request.setAttribute("error", "Từ này đã tồn tại trong từ điển!");
                request.setAttribute("wordEnglish", word.getWordEnglish());
                request.setAttribute("wordVietnamese", word.getWordVietnamese());
                request.setAttribute("pronunciation", word.getPronunciation());
                request.setAttribute("wordType", word.getWordType());
                request.setAttribute("exampleSentence", word.getExampleSentence());
                request.setAttribute("exampleTranslation", word.getExampleTranslation());
                request.getRequestDispatcher("../admin/add-word.jsp").forward(request, response);
                return;
            }
            
            boolean success = wordDAO.insertWord(word);
            if (success) {
                request.setAttribute("success", "Thêm từ thành công!");
                request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm từ!");
                request.setAttribute("wordEnglish", word.getWordEnglish());
                request.setAttribute("wordVietnamese", word.getWordVietnamese());
                request.setAttribute("pronunciation", word.getPronunciation());
                request.setAttribute("wordType", word.getWordType());
                request.setAttribute("exampleSentence", word.getExampleSentence());
                request.setAttribute("exampleTranslation", word.getExampleTranslation());
                request.getRequestDispatcher("../admin/add-word.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            // Cập nhật từ
            String wordIdStr = request.getParameter("wordId");
            if (wordIdStr == null) {
                request.setAttribute("error", "ID từ không hợp lệ!");
                request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
                return;
            }
            
            try {
                int wordId = Integer.parseInt(wordIdStr);
                Word word = createWordFromRequest(request);
                word.setWordId(wordId);
                word.setUpdatedBy(adminId);
                
                boolean success = wordDAO.updateWord(word);
                if (success) {
                    request.setAttribute("success", "Cập nhật từ thành công!");
                    request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi cập nhật từ!");
                    word = wordDAO.getWordById(wordId);
                    request.setAttribute("word", word);
                    request.getRequestDispatcher("../admin/edit-word.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID không hợp lệ!");
                request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("../admin/manage-words.jsp").forward(request, response);
        }
    }
    
    /**
     * Helper method: Tạo Word object từ request parameters
     */
    private Word createWordFromRequest(HttpServletRequest request) {
        Word word = new Word();
        
        String wordEnglish = request.getParameter("wordEnglish");
        String wordVietnamese = request.getParameter("wordVietnamese");
        
        if (wordEnglish != null && !wordEnglish.trim().isEmpty()) {
            word.setWordEnglish(wordEnglish.trim());
        }
        if (wordVietnamese != null && !wordVietnamese.trim().isEmpty()) {
            word.setWordVietnamese(wordVietnamese.trim());
        }
        
        String pronunciation = request.getParameter("pronunciation");
        if (pronunciation != null && !pronunciation.trim().isEmpty()) {
            word.setPronunciation(pronunciation.trim());
        }
        
        String wordType = request.getParameter("wordType");
        if (wordType != null && !wordType.trim().isEmpty()) {
            word.setWordType(wordType.trim());
        }
        
        String exampleSentence = request.getParameter("exampleSentence");
        if (exampleSentence != null && !exampleSentence.trim().isEmpty()) {
            word.setExampleSentence(exampleSentence.trim());
        }
        
        String exampleTranslation = request.getParameter("exampleTranslation");
        if (exampleTranslation != null && !exampleTranslation.trim().isEmpty()) {
            word.setExampleTranslation(exampleTranslation.trim());
        }
        
        return word;
    }
}

