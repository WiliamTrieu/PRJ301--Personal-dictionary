package controller;

import Dao.WordDAO;
import model.Word;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * SearchServlet - Xử lý tìm kiếm từ điển
 * 
 * @author PRJ301
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

    /**
     * Xử lý GET request - Tìm kiếm từ
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy keyword từ request
        String keyword = request.getParameter("keyword");
        
        // Validate input
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập từ khóa tìm kiếm!");
            request.getRequestDispatcher("user/dashboard.jsp").forward(request, response);
            return;
        }
        
        keyword = keyword.trim();
        
        // Tìm kiếm từ điển
        WordDAO wordDAO = new WordDAO();
        List<Word> words = wordDAO.searchWord(keyword);
        
        // Set kết quả vào request
        request.setAttribute("keyword", keyword);
        request.setAttribute("words", words);
        request.setAttribute("resultCount", words.size());
        
        // Forward đến trang kết quả
        request.getRequestDispatcher("user/search-result.jsp").forward(request, response);
    }
    
    /**
     * Xử lý POST request (tương tự GET)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

