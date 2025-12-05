package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Word;

/**
 * WordDAO - Data Access Object cho bảng Dictionary
 * Xử lý các thao tác database liên quan đến từ điển
 * 
 * @author PRJ301
 */
public class WordDAO {
    
    private final DBContext dbContext;
    
    public WordDAO() {
        dbContext = new DBContext();
    }
    
    /**
     * Tìm kiếm từ điển theo keyword (tìm trong cả tiếng Anh và tiếng Việt)
     * @param keyword Từ khóa tìm kiếm
     * @return Danh sách Word tìm được
     */
    public List<Word> searchWord(String keyword) {
        List<Word> words = new ArrayList<>();
        String sql = "SELECT word_id, word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, created_by, created_at, " +
                     "updated_at, updated_by " +
                     "FROM Dictionary " +
                     "WHERE word_english LIKE ? OR word_vietnamese LIKE ? " +
                     "ORDER BY word_english";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Word word = new Word();
                word.setWordId(rs.getInt("word_id"));
                word.setWordEnglish(rs.getString("word_english"));
                word.setWordVietnamese(rs.getString("word_vietnamese"));
                word.setPronunciation(rs.getString("pronunciation"));
                word.setWordType(rs.getString("word_type"));
                word.setExampleSentence(rs.getString("example_sentence"));
                word.setExampleTranslation(rs.getString("example_translation"));
                word.setCreatedBy(rs.getInt("created_by"));
                word.setCreatedAt(rs.getTimestamp("created_at"));
                word.setUpdatedAt(rs.getTimestamp("updated_at"));
                if (rs.getObject("updated_by") != null) {
                    word.setUpdatedBy(rs.getInt("updated_by"));
                }
                
                words.add(word);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.searchWord: " + e.getMessage());
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
        
        return words;
    }
    
    /**
     * Lấy từ điển theo ID
     * @param wordId ID của từ
     * @return Word object hoặc null nếu không tìm thấy
     */
    public Word getWordById(int wordId) {
        String sql = "SELECT word_id, word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, created_by, created_at, " +
                     "updated_at, updated_by " +
                     "FROM Dictionary " +
                     "WHERE word_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, wordId);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Word word = new Word();
                word.setWordId(rs.getInt("word_id"));
                word.setWordEnglish(rs.getString("word_english"));
                word.setWordVietnamese(rs.getString("word_vietnamese"));
                word.setPronunciation(rs.getString("pronunciation"));
                word.setWordType(rs.getString("word_type"));
                word.setExampleSentence(rs.getString("example_sentence"));
                word.setExampleTranslation(rs.getString("example_translation"));
                word.setCreatedBy(rs.getInt("created_by"));
                word.setCreatedAt(rs.getTimestamp("created_at"));
                word.setUpdatedAt(rs.getTimestamp("updated_at"));
                if (rs.getObject("updated_by") != null) {
                    word.setUpdatedBy(rs.getInt("updated_by"));
                }
                
                return word;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.getWordById: " + e.getMessage());
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
     * Lấy tất cả từ điển (có phân trang)
     * @param page Số trang (bắt đầu từ 1)
     * @param pageSize Số lượng từ mỗi trang
     * @return Danh sách Word
     */
    public List<Word> getAllWords(int page, int pageSize) {
        List<Word> words = new ArrayList<>();
        String sql = "SELECT word_id, word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, created_by, created_at, " +
                     "updated_at, updated_by " +
                     "FROM Dictionary " +
                     "ORDER BY word_english " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Word word = new Word();
                word.setWordId(rs.getInt("word_id"));
                word.setWordEnglish(rs.getString("word_english"));
                word.setWordVietnamese(rs.getString("word_vietnamese"));
                word.setPronunciation(rs.getString("pronunciation"));
                word.setWordType(rs.getString("word_type"));
                word.setExampleSentence(rs.getString("example_sentence"));
                word.setExampleTranslation(rs.getString("example_translation"));
                word.setCreatedBy(rs.getInt("created_by"));
                word.setCreatedAt(rs.getTimestamp("created_at"));
                word.setUpdatedAt(rs.getTimestamp("updated_at"));
                if (rs.getObject("updated_by") != null) {
                    word.setUpdatedBy(rs.getInt("updated_by"));
                }
                
                words.add(word);
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.getAllWords: " + e.getMessage());
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
        
        return words;
    }
    
    /**
     * Đếm tổng số từ trong từ điển
     * @return Tổng số từ
     */
    public int countTotalWords() {
        String sql = "SELECT COUNT(*) as total FROM Dictionary";
        
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
            System.err.println("Error in WordDAO.countTotalWords: " + e.getMessage());
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
}

