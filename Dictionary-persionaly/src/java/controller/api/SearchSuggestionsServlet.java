package controller.api;

import Dao.WordDAO;
import model.Word;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * SearchSuggestionsServlet - AJAX endpoint for autocomplete
 * Returns JSON array of word suggestions
 * 
 * @author PRJ301
 */
@WebServlet(name = "SearchSuggestionsServlet", urlPatterns = {"/api/search-suggestions"})
public class SearchSuggestionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Get query parameter
        String query = request.getParameter("q");
        
        PrintWriter out = response.getWriter();
        
        try {
            // Validate query
            if (query == null || query.trim().isEmpty() || query.trim().length() < 2) {
                // Return empty array if query too short
                out.print("[]");
                return;
            }
            
            query = query.trim();
            
            // Search for words
            WordDAO wordDAO = new WordDAO();
            List<Word> words = wordDAO.searchWord(query);
            
            // Build JSON response manually (no external library needed)
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            // Limit to 8 suggestions for better UX
            int limit = Math.min(words.size(), 8);
            
            for (int i = 0; i < limit; i++) {
                Word word = words.get(i);
                
                if (i > 0) {
                    json.append(",");
                }
                
                json.append("{");
                json.append("\"word_english\":\"").append(escapeJson(word.getWordEnglish())).append("\",");
                json.append("\"word_vietnamese\":\"").append(escapeJson(word.getWordVietnamese())).append("\",");
                json.append("\"pronunciation\":\"").append(escapeJson(word.getPronunciation() != null ? word.getPronunciation() : "")).append("\",");
                json.append("\"word_type\":\"").append(escapeJson(word.getWordType() != null ? word.getWordType() : "")).append("\"");
                json.append("}");
            }
            
            json.append("]");
            out.print(json.toString());
            
        } catch (Exception e) {
            System.err.println("Error in SearchSuggestionsServlet: " + e.getMessage());
            e.printStackTrace();
            out.print("[]");
        } finally {
            out.flush();
        }
    }
    
    /**
     * Helper method: Escape special characters for JSON
     * @param str String to escape
     * @return Escaped string
     */
    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}

