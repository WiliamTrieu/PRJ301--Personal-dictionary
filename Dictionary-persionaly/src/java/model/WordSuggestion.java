package model;

import java.sql.Timestamp;

/**
 * WordSuggestion Model - Đại diện cho bảng WordSuggestions trong database
 * 
 * @author PRJ301
 */
public class WordSuggestion {
    private int suggestionId;
    private String wordEnglish;
    private String wordVietnamese;
    private String pronunciation;
    private String wordType;
    private String exampleSentence;
    private String exampleTranslation;
    private int suggestedBy;
    private String status; // pending, approved, rejected
    private Integer reviewedBy;
    private String reviewNote;
    private Timestamp createdAt;
    private Timestamp reviewedAt;
    
    // NEW FIELDS for Suggest Edit feature
    private String suggestionType; // 'new' or 'edit'
    private Integer originalWordId; // ID of original word (for 'edit' type)
    
    // Additional fields for display (joined from Users table)
    private String suggestedByName;
    private String reviewerName;
    
    // Constructors
    public WordSuggestion() {
    }
    
    public WordSuggestion(int suggestionId, String wordEnglish, String wordVietnamese,
                         String pronunciation, String wordType, String exampleSentence,
                         String exampleTranslation, int suggestedBy, String status,
                         Timestamp createdAt) {
        this.suggestionId = suggestionId;
        this.wordEnglish = wordEnglish;
        this.wordVietnamese = wordVietnamese;
        this.pronunciation = pronunciation;
        this.wordType = wordType;
        this.exampleSentence = exampleSentence;
        this.exampleTranslation = exampleTranslation;
        this.suggestedBy = suggestedBy;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    // Full constructor
    public WordSuggestion(int suggestionId, String wordEnglish, String wordVietnamese,
                         String pronunciation, String wordType, String exampleSentence,
                         String exampleTranslation, int suggestedBy, String status,
                         Integer reviewedBy, String reviewNote, Timestamp createdAt,
                         Timestamp reviewedAt) {
        this.suggestionId = suggestionId;
        this.wordEnglish = wordEnglish;
        this.wordVietnamese = wordVietnamese;
        this.pronunciation = pronunciation;
        this.wordType = wordType;
        this.exampleSentence = exampleSentence;
        this.exampleTranslation = exampleTranslation;
        this.suggestedBy = suggestedBy;
        this.status = status;
        this.reviewedBy = reviewedBy;
        this.reviewNote = reviewNote;
        this.createdAt = createdAt;
        this.reviewedAt = reviewedAt;
    }
    
    // Getters and Setters
    public int getSuggestionId() {
        return suggestionId;
    }
    
    public void setSuggestionId(int suggestionId) {
        this.suggestionId = suggestionId;
    }
    
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
    
    public int getSuggestedBy() {
        return suggestedBy;
    }
    
    public void setSuggestedBy(int suggestedBy) {
        this.suggestedBy = suggestedBy;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getReviewedBy() {
        return reviewedBy;
    }
    
    public void setReviewedBy(Integer reviewedBy) {
        this.reviewedBy = reviewedBy;
    }
    
    public String getReviewNote() {
        return reviewNote;
    }
    
    public void setReviewNote(String reviewNote) {
        this.reviewNote = reviewNote;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getReviewedAt() {
        return reviewedAt;
    }
    
    public void setReviewedAt(Timestamp reviewedAt) {
        this.reviewedAt = reviewedAt;
    }
    
    public String getSuggestedByName() {
        return suggestedByName;
    }
    
    public void setSuggestedByName(String suggestedByName) {
        this.suggestedByName = suggestedByName;
    }
    
    public String getReviewerName() {
        return reviewerName;
    }
    
    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }
    
    // Getters and Setters for NEW fields
    public String getSuggestionType() {
        return suggestionType;
    }
    
    public void setSuggestionType(String suggestionType) {
        this.suggestionType = suggestionType;
    }
    
    public Integer getOriginalWordId() {
        return originalWordId;
    }
    
    public void setOriginalWordId(Integer originalWordId) {
        this.originalWordId = originalWordId;
    }
    
    // Helper methods
    public boolean isPending() {
        return "pending".equalsIgnoreCase(this.status);
    }
    
    public boolean isNew() {
        return "new".equalsIgnoreCase(this.suggestionType);
    }
    
    public boolean isEdit() {
        return "edit".equalsIgnoreCase(this.suggestionType);
    }
    
    public boolean isApproved() {
        return "approved".equalsIgnoreCase(this.status);
    }
    
    public boolean isRejected() {
        return "rejected".equalsIgnoreCase(this.status);
    }
    
    @Override
    public String toString() {
        return "WordSuggestion{" +
                "suggestionId=" + suggestionId +
                ", wordEnglish='" + wordEnglish + '\'' +
                ", wordVietnamese='" + wordVietnamese + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

