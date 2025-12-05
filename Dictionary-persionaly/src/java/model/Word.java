package model;

import java.sql.Timestamp;

/**
 * Word Model - Đại diện cho bảng Dictionary trong database
 * 
 * @author PRJ301
 */
public class Word {
    private int wordId;
    private String wordEnglish;
    private String wordVietnamese;
    private String pronunciation;
    private String wordType; // noun, verb, adjective, etc.
    private String exampleSentence;
    private String exampleTranslation;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer updatedBy;
    
    // Constructors
    public Word() {
    }
    
    public Word(int wordId, String wordEnglish, String wordVietnamese, String pronunciation,
                String wordType, String exampleSentence, String exampleTranslation,
                int createdBy, Timestamp createdAt) {
        this.wordId = wordId;
        this.wordEnglish = wordEnglish;
        this.wordVietnamese = wordVietnamese;
        this.pronunciation = pronunciation;
        this.wordType = wordType;
        this.exampleSentence = exampleSentence;
        this.exampleTranslation = exampleTranslation;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
    }
    
    // Full constructor
    public Word(int wordId, String wordEnglish, String wordVietnamese, String pronunciation,
                String wordType, String exampleSentence, String exampleTranslation,
                int createdBy, Timestamp createdAt, Timestamp updatedAt, Integer updatedBy) {
        this.wordId = wordId;
        this.wordEnglish = wordEnglish;
        this.wordVietnamese = wordVietnamese;
        this.pronunciation = pronunciation;
        this.wordType = wordType;
        this.exampleSentence = exampleSentence;
        this.exampleTranslation = exampleTranslation;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.updatedBy = updatedBy;
    }
    
    // Getters and Setters
    public int getWordId() {
        return wordId;
    }
    
    public void setWordId(int wordId) {
        this.wordId = wordId;
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
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Integer getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(Integer updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    @Override
    public String toString() {
        return "Word{" +
                "wordId=" + wordId +
                ", wordEnglish='" + wordEnglish + '\'' +
                ", wordVietnamese='" + wordVietnamese + '\'' +
                ", pronunciation='" + pronunciation + '\'' +
                ", wordType='" + wordType + '\'' +
                '}';
    }
}

