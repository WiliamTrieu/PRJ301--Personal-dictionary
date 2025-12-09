package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.UserSavedWord;

/**
 * UserSavedWordDAO - Personal vocabulary for each user
 * @author PRJ301
 */
public class UserSavedWordDAO {
    private final DBContext dbContext;
    
    public UserSavedWordDAO() {
        this.dbContext = new DBContext();
    }
    
    /**
     * Save a word to user's personal dictionary
     */
    public boolean saveWord(int userId, int wordId, String personalNote) {
        String sql = "INSERT INTO UserSavedWords (user_id, word_id, personal_note) VALUES (?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, wordId);
            ps.setString(3, personalNote);
            
            int rows = ps.executeUpdate();
            System.out.println("✅ User " + userId + " saved word " + wordId);
            return rows > 0;
            
        } catch (SQLException e) {
            if (e.getErrorCode() == 2627) { // Unique constraint violation
                System.out.println("⚠️ Word already saved by user");
            } else {
                System.err.println("Error saving word: " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }
    
    /**
     * Remove a word from user's saved words
     */
    public boolean unsaveWord(int userId, int wordId) {
        String sql = "DELETE FROM UserSavedWords WHERE user_id = ? AND word_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, wordId);
            
            int rows = ps.executeUpdate();
            System.out.println("✅ User " + userId + " unsaved word " + wordId);
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error unsaving word: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Check if user has saved a word
     */
    public boolean isWordSaved(int userId, int wordId) {
        String sql = "SELECT COUNT(*) as count FROM UserSavedWords WHERE user_id = ? AND word_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, wordId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking saved word: " + e.getMessage());
        }
        return false;
    }
    
    /**
     * Get all saved words for a user with full word details
     */
    public List<UserSavedWord> getSavedWords(int userId) {
        List<UserSavedWord> savedWords = new ArrayList<>();
        String sql = "SELECT sw.saved_id, sw.user_id, sw.word_id, sw.personal_note, " +
                     "sw.mastery_level, sw.times_reviewed, sw.last_reviewed, sw.saved_at, " +
                     "d.word_english, d.word_vietnamese, d.pronunciation, d.word_type, " +
                     "d.example_sentence, d.example_translation " +
                     "FROM UserSavedWords sw " +
                     "INNER JOIN Dictionary d ON sw.word_id = d.word_id " +
                     "WHERE sw.user_id = ? " +
                     "ORDER BY sw.saved_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserSavedWord sw = new UserSavedWord();
                    sw.setSavedId(rs.getInt("saved_id"));
                    sw.setUserId(rs.getInt("user_id"));
                    sw.setWordId(rs.getInt("word_id"));
                    sw.setPersonalNote(rs.getString("personal_note"));
                    sw.setMasteryLevel(rs.getInt("mastery_level"));
                    sw.setTimesReviewed(rs.getInt("times_reviewed"));
                    sw.setLastReviewed(rs.getTimestamp("last_reviewed"));
                    sw.setSavedAt(rs.getTimestamp("saved_at"));
                    
                    // Word details
                    sw.setWordEnglish(rs.getString("word_english"));
                    sw.setWordVietnamese(rs.getString("word_vietnamese"));
                    sw.setPronunciation(rs.getString("pronunciation"));
                    sw.setWordType(rs.getString("word_type"));
                    sw.setExampleSentence(rs.getString("example_sentence"));
                    sw.setExampleTranslation(rs.getString("example_translation"));
                    
                    savedWords.add(sw);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting saved words: " + e.getMessage());
            e.printStackTrace();
        }
        
        return savedWords;
    }
    
    /**
     * Count total saved words for a user
     */
    public int countSavedWords(int userId) {
        String sql = "SELECT COUNT(*) as count FROM UserSavedWords WHERE user_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error counting saved words: " + e.getMessage());
        }
        return 0;
    }
    
    /**
     * Update personal note for a saved word
     */
    public boolean updateNote(int userId, int wordId, String newNote) {
        String sql = "UPDATE UserSavedWords SET personal_note = ? WHERE user_id = ? AND word_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newNote);
            ps.setInt(2, userId);
            ps.setInt(3, wordId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating note: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update mastery level
     */
    public boolean updateMasteryLevel(int userId, int wordId, int level) {
        String sql = "UPDATE UserSavedWords SET mastery_level = ? WHERE user_id = ? AND word_id = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, level);
            ps.setInt(2, userId);
            ps.setInt(3, wordId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating mastery level: " + e.getMessage());
            return false;
        }
    }
}

