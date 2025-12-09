package model;

import java.sql.Timestamp;

/**
 * UserSavedWord Model - User's personal vocabulary
 * Each user has their own saved words collection
 * 
 * @author PRJ301
 */
public class UserSavedWord {
    private int savedId;
    private int userId;
    private int wordId;
    private String personalNote;
    private int masteryLevel;  // 0-5
    private int timesReviewed;
    private Timestamp lastReviewed;
    private Timestamp savedAt;
    
    // Word details (for display)
    private String wordEnglish;
    private String wordVietnamese;
    private String pronunciation;
    private String wordType;
    private String exampleSentence;
    private String exampleTranslation;
    
    // Constructors
    public UserSavedWord() {
    }
    
    public UserSavedWord(int savedId, int userId, int wordId, String personalNote,
                        int masteryLevel, int timesReviewed, Timestamp lastReviewed,
                        Timestamp savedAt) {
        this.savedId = savedId;
        this.userId = userId;
        this.wordId = wordId;
        this.personalNote = personalNote;
        this.masteryLevel = masteryLevel;
        this.timesReviewed = timesReviewed;
        this.lastReviewed = lastReviewed;
        this.savedAt = savedAt;
    }
    
    // Getters and Setters
    public int getSavedId() {
        return savedId;
    }
    
    public void setSavedId(int savedId) {
        this.savedId = savedId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getWordId() {
        return wordId;
    }
    
    public void setWordId(int wordId) {
        this.wordId = wordId;
    }
    
    public String getPersonalNote() {
        return personalNote;
    }
    
    public void setPersonalNote(String personalNote) {
        this.personalNote = personalNote;
    }
    
    public int getMasteryLevel() {
        return masteryLevel;
    }
    
    public void setMasteryLevel(int masteryLevel) {
        this.masteryLevel = masteryLevel;
    }
    
    public int getTimesReviewed() {
        return timesReviewed;
    }
    
    public void setTimesReviewed(int timesReviewed) {
        this.timesReviewed = timesReviewed;
    }
    
    public Timestamp getLastReviewed() {
        return lastReviewed;
    }
    
    public void setLastReviewed(Timestamp lastReviewed) {
        this.lastReviewed = lastReviewed;
    }
    
    public Timestamp getSavedAt() {
        return savedAt;
    }
    
    public void setSavedAt(Timestamp savedAt) {
        this.savedAt = savedAt;
    }
    
    // Word details
    public String getWordEnglish() {
        return wordEnglish;
    }
    
    public void setWordEnglish(String wordEnglish) {
        this.wordEnglish = wordEnglish;
    }
    
    public String getWordVietnamese() {
        return wordVietnamese;
    }
    
    public void setWordVietnamese(String wordVietnamese) {
        this.wordVietnamese = wordVietnamese;
    }
    
    public String getPronunciation() {
        return pronunciation;
    }
    
    public void setPronunciation(String pronunciation) {
        this.pronunciation = pronunciation;
    }
    
    public String getWordType() {
        return wordType;
    }
    
    public void setWordType(String wordType) {
        this.wordType = wordType;
    }
    
    public String getExampleSentence() {
        return exampleSentence;
    }
    
    public void setExampleSentence(String exampleSentence) {
        this.exampleSentence = exampleSentence;
    }
    
    public String getExampleTranslation() {
        return exampleTranslation;
    }
    
    public void setExampleTranslation(String exampleTranslation) {
        this.exampleTranslation = exampleTranslation;
    }
    
    @Override
    public String toString() {
        return "UserSavedWord{" +
                "savedId=" + savedId +
                ", userId=" + userId +
                ", wordId=" + wordId +
                ", wordEnglish='" + wordEnglish + '\'' +
                ", masteryLevel=" + masteryLevel +
                ", savedAt=" + savedAt +
                '}';
    }
}

