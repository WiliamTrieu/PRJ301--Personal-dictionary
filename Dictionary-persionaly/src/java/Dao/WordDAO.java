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
                
                // Get word_id FIRST and validate
                int wordId = rs.getInt("word_id");
                if (wordId <= 0) {
                    System.err.println("⚠️ SKIPPING word with invalid ID: " + wordId + " (word: " + rs.getString("word_english") + ")");
                    continue; // Skip this word
                }
                
                word.setWordId(wordId);
                word.setWordEnglish(rs.getString("word_english"));
                word.setWordVietnamese(rs.getString("word_vietnamese"));
                word.setPronunciation(rs.getString("pronunciation"));
                word.setWordType(rs.getString("word_type"));
                word.setExampleSentence(rs.getString("example_sentence"));
                word.setExampleTranslation(rs.getString("example_translation"));
                
                // Handle nullable created_by safely
                if (rs.getObject("created_by") != null) {
                    word.setCreatedBy(rs.getInt("created_by"));
                } else {
                    word.setCreatedBy(0); // Default value for nullable field
                }
                
                word.setCreatedAt(rs.getTimestamp("created_at"));
                word.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                if (rs.getObject("updated_by") != null) {
                    word.setUpdatedBy(rs.getInt("updated_by"));
                }
                
                // DEBUG: Log word details
                System.out.println("✅ Found word: '" + word.getWordEnglish() + "' | ID: " + wordId + " | Valid: " + (wordId > 0) + " | Getter: " + word.getWordId());
                
                words.add(word);
            }
            
            System.out.println("📊 Total results for '" + keyword + "': " + words.size() + " word(s)");
            
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
    
    /**
     * Thêm từ mới vào từ điển
     * @param word Word object
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean insertWord(Word word) {
        String sql = "INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, " +
                     "example_sentence, example_translation, created_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, word.getWordEnglish());
            ps.setString(2, word.getWordVietnamese());
            ps.setString(3, word.getPronunciation());
            ps.setString(4, word.getWordType());
            ps.setString(5, word.getExampleSentence());
            ps.setString(6, word.getExampleTranslation());
            ps.setInt(7, word.getCreatedBy());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.insertWord: " + e.getMessage());
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
     * Cập nhật từ điển
     * @param word Word object với thông tin cập nhật
     * @return true nếu thành công
     */
    public boolean updateWord(Word word) {
        String sql = "UPDATE Dictionary SET word_english = ?, word_vietnamese = ?, pronunciation = ?, " +
                     "word_type = ?, example_sentence = ?, example_translation = ?, " +
                     "updated_by = ?, updated_at = GETDATE() " +
                     "WHERE word_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, word.getWordEnglish());
            ps.setString(2, word.getWordVietnamese());
            ps.setString(3, word.getPronunciation());
            ps.setString(4, word.getWordType());
            ps.setString(5, word.getExampleSentence());
            ps.setString(6, word.getExampleTranslation());
            ps.setInt(7, word.getUpdatedBy());
            ps.setInt(8, word.getWordId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.updateWord: " + e.getMessage());
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
     * Xóa từ khỏi từ điển
     * @param wordId ID của từ cần xóa
     * @return true nếu thành công
     */
    public boolean deleteWord(int wordId) {
        String sql = "DELETE FROM Dictionary WHERE word_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, wordId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.deleteWord: " + e.getMessage());
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
     * Kiểm tra từ đã tồn tại chưa
     * @param wordEnglish Từ tiếng Anh
     * @return true nếu đã tồn tại
     */
    public boolean wordExists(String wordEnglish) {
        String sql = "SELECT COUNT(*) as count FROM Dictionary WHERE LOWER(word_english) = LOWER(?)";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, wordEnglish.trim());
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.wordExists: " + e.getMessage());
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
     * Đếm số từ mà một user đã tạo
     * @param userId ID của user
     * @return Số lượng từ đã tạo
     */
    public int countWordsByUser(int userId) {
        String sql = "SELECT COUNT(*) as total FROM Dictionary WHERE created_by = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = dbContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            System.err.println("Error in WordDAO.countWordsByUser: " + e.getMessage());
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

