package Dao;

import java.sql.*;
import model.Word;

/**
 * DictionaryDAO - Data Access Object cho bảng Dictionary
 * Xử lý các thao tác database liên quan đến từ điển
 * 
 * @author PRJ301
 */
public class DictionaryDAO {
    private final DBContext dbContext;
    
    public DictionaryDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * UPDATE từ có sẵn trong Dictionary (dùng khi admin approve EDIT suggestion)
     * @param wordId ID của từ cần update
     * @param wordVietnamese Nghĩa tiếng Việt mới
     * @param pronunciation Phiên âm mới
     * @param wordType Loại từ mới
     * @param exampleSentence Câu ví dụ mới
     * @param exampleTranslation Bản dịch mới
     * @return true nếu update thành công
     */
    public boolean updateWord(int wordId, String wordVietnamese, String pronunciation,
                             String wordType, String exampleSentence, String exampleTranslation) {
        String sql = "UPDATE Dictionary SET " +
                     "word_vietnamese = ?, pronunciation = ?, word_type = ?, " +
                     "example_sentence = ?, example_translation = ?, updated_at = GETDATE() " +
                     "WHERE word_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, wordVietnamese);
            ps.setString(2, pronunciation);
            ps.setString(3, wordType);
            ps.setString(4, exampleSentence);
            ps.setString(5, exampleTranslation);
            ps.setInt(6, wordId);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("✅ UPDATED word in Dictionary - ID: " + wordId + " | New meaning: " + wordVietnamese);
                return true;
            } else {
                System.err.println("⚠️ No rows updated for word ID: " + wordId);
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error in DictionaryDAO.updateWord: " + e.getMessage());
            System.err.println("❌ SQL State: " + e.getSQLState());
            System.err.println("❌ Error Code: " + e.getErrorCode());
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
     * INSERT từ mới vào Dictionary (dùng khi admin approve NEW suggestion)
     * @param wordEnglish Từ tiếng Anh
     * @param wordVietnamese Nghĩa tiếng Việt
     * @param pronunciation Phiên âm
     * @param wordType Loại từ
     * @param exampleSentence Câu ví dụ
     * @param exampleTranslation Bản dịch
     * @param addedBy Admin ID
     * @return true nếu insert thành công
     */
    public boolean insertWord(String wordEnglish, String wordVietnamese, String pronunciation,
                             String wordType, String exampleSentence, String exampleTranslation,
                             int addedBy) {
        String sql = "INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, " +
                     "word_type, example_sentence, example_translation, added_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, wordEnglish);
            ps.setString(2, wordVietnamese);
            ps.setString(3, pronunciation);
            ps.setString(4, wordType);
            ps.setString(5, exampleSentence);
            ps.setString(6, exampleTranslation);
            ps.setInt(7, addedBy);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("✅ INSERTED new word into Dictionary: " + wordEnglish);
                return true;
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("❌ Error in DictionaryDAO.insertWord: " + e.getMessage());
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
     * CHECK từ có tồn tại không (để tránh duplicate)
     * @param wordEnglish Từ tiếng Anh
     * @return true nếu từ đã tồn tại
     */
    public boolean isWordExists(String wordEnglish) {
        String sql = "SELECT COUNT(*) as count FROM Dictionary WHERE word_english = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, wordEnglish);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in DictionaryDAO.isWordExists: " + e.getMessage());
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
        
        return false;
    }
    
    /**
     * Lấy word theo ID
     * @param wordId ID của word
     * @return Word object hoặc null
     */
    public Word getWordById(int wordId) {
        String sql = "SELECT word_id, word_english, word_vietnamese, pronunciation, " +
                     "word_type, example_sentence, example_translation " +
                     "FROM Dictionary WHERE word_id = ?";
        
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
                return word;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in DictionaryDAO.getWordById: " + e.getMessage());
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
}

