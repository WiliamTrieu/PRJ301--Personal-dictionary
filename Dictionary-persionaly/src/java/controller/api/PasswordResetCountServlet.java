package controller.api;

import Dao.PasswordResetRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * API endpoint to get pending password reset request count
 * 
 * @author PRJ301
 */
@WebServlet(name = "PasswordResetCountServlet", urlPatterns = {"/api/password-reset-count"})
public class PasswordResetCountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PasswordResetRequestDAO requestDAO = new PasswordResetRequestDAO();
        int count = requestDAO.countPendingRequests();
        
        PrintWriter out = response.getWriter();
        out.print("{\"count\": " + count + "}");
        out.flush();
    }
}

