package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.WordSuggestion;

/**
 * WordSuggestionDAO - Data Access Object cho bảng WordSuggestions
 * Xử lý các thao tác database liên quan đến đề xuất từ
 * 
 * @author PRJ301
 */
public class WordSuggestionDAO {
    
    private final DBContext dbContext;
    
    public WordSuggestionDAO() {
        dbContext = new DBContext();
    }
    
    /**
     * Thêm đề xuất từ mới
     * @param suggestion WordSuggestion object
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean insertSuggestion(WordSuggestion suggestion) {
        String sql = "INSERT INTO WordSuggestions (word_english, word_vietnamese, pronunciation, " +
                     "word_type, example_sentence, example_translation, suggested_by, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, suggestion.getWordEnglish());
            ps.setString(2, suggestion.getWordVietnamese());
            ps.setString(3, suggestion.getPronunciation());
            ps.setString(4, suggestion.getWordType());
            ps.setString(5, suggestion.getExampleSentence());
            ps.setString(6, suggestion.getExampleTranslation());
            ps.setInt(7, suggestion.getSuggestedBy());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.insertSuggestion: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
    
    /**
     * Lấy tất cả đề xuất của một user
     * @param userId ID của user
     * @return Danh sách WordSuggestion
     */
    public List<WordSuggestion> getSuggestionsByUser(int userId) {
        List<WordSuggestion> suggestions = new ArrayList<>();
        String sql = "SELECT suggestion_id, word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, suggested_by, status, reviewed_by, " +
                     "review_note, created_at, reviewed_at " +
                     "FROM WordSuggestions " +
                     "WHERE suggested_by = ? " +
                     "ORDER BY created_at DESC";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                WordSuggestion suggestion = mapResultSetToSuggestion(rs);
                suggestions.add(suggestion);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.getSuggestionsByUser: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return suggestions;
    }
    
    /**
     * Lấy tất cả đề xuất theo status (cho admin)
     * @param status Trạng thái (pending, approved, rejected)
     * @return Danh sách WordSuggestion
     */
    public List<WordSuggestion> getSuggestionsByStatus(String status) {
        List<WordSuggestion> suggestions = new ArrayList<>();
        String sql = "SELECT s.suggestion_id, s.word_english, s.word_vietnamese, s.pronunciation, " +
                     "s.word_type, s.example_sentence, s.example_translation, s.suggested_by, " +
                     "s.status, s.reviewed_by, s.review_note, s.created_at, s.reviewed_at, " +
                     "u.full_name AS suggested_by_name " +
                     "FROM WordSuggestions s " +
                     "LEFT JOIN Users u ON s.suggested_by = u.user_id " +
                     "WHERE s.status = ? " +
                     "ORDER BY s.created_at DESC";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                WordSuggestion suggestion = mapResultSetToSuggestion(rs);
                suggestion.setSuggestedByName(rs.getString("suggested_by_name"));
                suggestions.add(suggestion);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.getSuggestionsByStatus: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return suggestions;
    }
    
    /**
     * Lấy đề xuất theo ID
     * @param suggestionId ID của đề xuất
     * @return WordSuggestion object hoặc null
     */
    public WordSuggestion getSuggestionById(int suggestionId) {
        String sql = "SELECT suggestion_id, word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, suggested_by, status, reviewed_by, " +
                     "review_note, created_at, reviewed_at " +
                     "FROM WordSuggestions " +
                     "WHERE suggestion_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, suggestionId);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToSuggestion(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.getSuggestionById: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return null;
    }
    
    /**
     * Cập nhật trạng thái đề xuất (approve/reject)
     * @param suggestionId ID của đề xuất
     * @param status Trạng thái mới (approved/rejected)
     * @param reviewedBy ID của admin duyệt
     * @param reviewNote Ghi chú/ lý do
     * @return true nếu thành công
     */
    public boolean updateSuggestionStatus(int suggestionId, String status, int reviewedBy, String reviewNote) {
        String sql = "UPDATE WordSuggestions " +
                     "SET status = ?, reviewed_by = ?, review_note = ?, reviewed_at = GETDATE() " +
                     "WHERE suggestion_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, reviewedBy);
            ps.setString(3, reviewNote);
            ps.setInt(4, suggestionId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.updateSuggestionStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
    }
    
    /**
     * Đếm số đề xuất chờ duyệt
     * @return Số lượng đề xuất pending
     */
    public int countPendingSuggestions() {
        String sql = "SELECT COUNT(*) as total FROM WordSuggestions WHERE status = 'pending'";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordSuggestionDAO.countPendingSuggestions: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }
        
        return 0;
    }
    
    /**
     * Helper method: Map ResultSet to WordSuggestion object
     */
    private WordSuggestion mapResultSetToSuggestion(ResultSet rs) throws SQLException {
        WordSuggestion suggestion = new WordSuggestion();
        suggestion.setSuggestionId(rs.getInt("suggestion_id"));
        suggestion.setWordEnglish(rs.getString("word_english"));
        suggestion.setWordVietnamese(rs.getString("word_vietnamese"));
        suggestion.setPronunciation(rs.getString("pronunciation"));
        suggestion.setWordType(rs.getString("word_type"));
        suggestion.setExampleSentence(rs.getString("example_sentence"));
        suggestion.setExampleTranslation(rs.getString("example_translation"));
        suggestion.setSuggestedBy(rs.getInt("suggested_by"));
        suggestion.setStatus(rs.getString("status"));
        
        if (rs.getObject("reviewed_by") != null) {
            suggestion.setReviewedBy(rs.getInt("reviewed_by"));
        }
        
        suggestion.setReviewNote(rs.getString("review_note"));
        suggestion.setCreatedAt(rs.getTimestamp("created_at"));
        suggestion.setReviewedAt(rs.getTimestamp("reviewed_at"));
        
        return suggestion;
    }
}

