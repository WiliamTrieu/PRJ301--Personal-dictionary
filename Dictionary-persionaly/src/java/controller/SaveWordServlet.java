package controller;

import Dao.UserSavedWordDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * SaveWordServlet - Handle save/unsave words
 * AJAX endpoint for "My Dictionary" feature
 * @author PRJ301
 */
@WebServlet(name = "SaveWordServlet", urlPatterns = {"/SaveWordServlet"})
public class SaveWordServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Check login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\":false,\"message\":\"Vui lòng đăng nhập\"}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        String wordIdStr = request.getParameter("wordId");
        
        // DEBUG: Log received parameters
        System.out.println("🔍 SaveWordServlet - Received:");
        System.out.println("  - action: " + action);
        System.out.println("  - wordIdStr: '" + wordIdStr + "'");
        System.out.println("  - userId: " + userId);
        
        // Validate
        if (wordIdStr == null || wordIdStr.trim().isEmpty()) {
            System.err.println("❌ Invalid word ID: empty or null");
            out.print("{\"success\":false,\"message\":\"Invalid word ID (empty)\"}");
            return;
        }
        
        try {
            int wordId = Integer.parseInt(wordIdStr);
            
            // Validate wordId > 0
            if (wordId <= 0) {
                System.err.println("❌ Invalid word ID: " + wordId + " (must be > 0)");
                out.print("{\"success\":false,\"message\":\"Invalid word ID (must be positive)\"}");
                return;
            }
            
            System.out.println("✅ Valid wordId: " + wordId);
            UserSavedWordDAO dao = new UserSavedWordDAO();
            boolean success = false;
            String message = "";
            
            if ("save".equals(action)) {
                // Save word
                String note = request.getParameter("note");
                success = dao.saveWord(userId, wordId, note);
                message = success ? "Đã lưu vào từ điển của tôi! ⭐" : "Từ này đã được lưu rồi!";
                
            } else if ("unsave".equals(action)) {
                // Remove word
                success = dao.unsaveWord(userId, wordId);
                message = success ? "Đã xóa khỏi từ điển của tôi" : "Không thể xóa từ này";
                
            } else {
                out.print("{\"success\":false,\"message\":\"Invalid action\"}");
                return;
            }
            
            // Return JSON response
            out.print("{\"success\":" + success + ",\"message\":\"" + message + "\"}");
            
        } catch (NumberFormatException e) {
            out.print("{\"success\":false,\"message\":\"Invalid word ID format\"}");
        } catch (Exception e) {
            System.err.println("Error in SaveWordServlet: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Đã xảy ra lỗi\"}");
        } finally {
            out.flush();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if word is saved (for UI state)
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"saved\":false}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String wordIdStr = request.getParameter("wordId");
        
        if (wordIdStr != null) {
            try {
                int wordId = Integer.parseInt(wordIdStr);
                UserSavedWordDAO dao = new UserSavedWordDAO();
                boolean saved = dao.isWordSaved(userId, wordId);
                out.print("{\"saved\":" + saved + "}");
            } catch (NumberFormatException e) {
                out.print("{\"saved\":false}");
            }
        } else {
            out.print("{\"saved\":false}");
        }
        
        out.flush();
    }
}

