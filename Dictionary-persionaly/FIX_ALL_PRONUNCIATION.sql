-- ============================================
-- FIX ALL PRONUNCIATION - Unicode Encoding
-- ============================================
-- Run this in SSMS to fix all corrupted IPA

-- First, clear all corrupted pronunciations
UPDATE Dictionary SET pronunciation = NULL WHERE pronunciation LIKE '%?%';

-- Then update with correct IPA (N prefix for Unicode!)
-- TOEFL Vocabulary
UPDATE Dictionary SET pronunciation = N'/əˈkwaɪər/' WHERE word_english = 'acquire';
UPDATE Dictionary SET pronunciation = N'/ədˈmɪt/' WHERE word_english = 'admit';
UPDATE Dictionary SET pronunciation = N'/ˈædvəkeɪt/' WHERE word_english = 'advocate';
UPDATE Dictionary SET pronunciation = N'/əˈlaɪ/' WHERE word_english = 'ally';
UPDATE Dictionary SET pronunciation = N'/ˈæmbjʊləns/' WHERE word_english = 'ambulance';
UPDATE Dictionary SET pronunciation = N'/əˈnælɪsɪs/' WHERE word_english = 'analysis';
UPDATE Dictionary SET pronunciation = N'/ˈæprɪˌheɪt/' WHERE word_english = 'appreciate';
UPDATE Dictionary SET pronunciation = N'/əˈproʊtʃ/' WHERE word_english = 'approach';
UPDATE Dictionary SET pronunciation = N'/ˈærəɡənt/' WHERE word_english = 'arrogant';
UPDATE Dictionary SET pronunciation = N'/əˈsɛs/' WHERE word_english = 'assess';
UPDATE Dictionary SET pronunciation = N'/əˈtætʃ/' WHERE word_english = 'attach';
UPDATE Dictionary SET pronunciation = N'/ˈbɛnɪfɪt/' WHERE word_english = 'benefit';
UPDATE Dictionary SET pronunciation = N'/ˈtʃælɪndʒ/' WHERE word_english = 'challenge';
UPDATE Dictionary SET pronunciation = N'/ˈkɒnflɪkt/' WHERE word_english = 'conflict';
UPDATE Dictionary SET pronunciation = N'/kənˈsɪdər/' WHERE word_english = 'consider';
UPDATE Dictionary SET pronunciation = N'/kənˈstrʌkt/' WHERE word_english = 'construct';
UPDATE Dictionary SET pronunciation = N'/kənˈtrɪbjuːt/' WHERE word_english = 'contribute';
UPDATE Dictionary SET pronunciation = N'/kriːˈeɪt/' WHERE word_english = 'create';
UPDATE Dictionary SET pronunciation = N'/dɪˈklaɪn/' WHERE word_english = 'decline';
UPDATE Dictionary SET pronunciation = N'/dɪˈfaɪn/' WHERE word_english = 'define';
UPDATE Dictionary SET pronunciation = N'/dɪˈmɒnstreɪt/' WHERE word_english = 'demonstrate';
UPDATE Dictionary SET pronunciation = N'/dɪˈraɪv/' WHERE word_english = 'derive';
UPDATE Dictionary SET pronunciation = N'/dɪˈzaɪn/' WHERE word_english = 'design';
UPDATE Dictionary SET pronunciation = N'/dɪˈvɛləp/' WHERE word_english = 'develop';
UPDATE Dictionary SET pronunciation = N'/ɪˈkɒnəmi/' WHERE word_english = 'economy';
UPDATE Dictionary SET pronunciation = N'/ɪˈlɪmɪneɪt/' WHERE word_english = 'eliminate';
UPDATE Dictionary SET pronunciation = N'/ɪˈmɜːdʒ/' WHERE word_english = 'emerge';
UPDATE Dictionary SET pronunciation = N'/ɪnˈhɑːns/' WHERE word_english = 'enhance';
UPDATE Dictionary SET pronunciation = N'/ɪnˈvaɪrənmənt/' WHERE word_english = 'environment';
UPDATE Dictionary SET pronunciation = N'/ɪˈstæblɪʃ/' WHERE word_english = 'establish';
UPDATE Dictionary SET pronunciation = N'/ɪˈvæljueɪt/' WHERE word_english = 'evaluate';
UPDATE Dictionary SET pronunciation = N'/ˈɛvɪdəns/' WHERE word_english = 'evidence';
UPDATE Dictionary SET pronunciation = N'/ɪkˈspænd/' WHERE word_english = 'expand';
UPDATE Dictionary SET pronunciation = N'/fəˈsɪlɪteɪt/' WHERE word_english = 'facilitate';
UPDATE Dictionary SET pronunciation = N'/ˈfæktər/' WHERE word_english = 'factor';
UPDATE Dictionary SET pronunciation = N'/ˈfʌŋkʃən/' WHERE word_english = 'function';
UPDATE Dictionary SET pronunciation = N'/ˈdʒɛnəreɪt/' WHERE word_english = 'generate';
UPDATE Dictionary SET pronunciation = N'/ˈaɪdɛntɪfaɪ/' WHERE word_english = 'identify';
UPDATE Dictionary SET pronunciation = N'/ˈɪmpækt/' WHERE word_english = 'impact';
UPDATE Dictionary SET pronunciation = N'/ˈɪmplɪment/' WHERE word_english = 'implement';
UPDATE Dictionary SET pronunciation = N'/ˈɪndɪkeɪt/' WHERE word_english = 'indicate';
UPDATE Dictionary SET pronunciation = N'/ˈɪnfluəns/' WHERE word_english = 'influence';
UPDATE Dictionary SET pronunciation = N'/ˈɪnɪʃəl/' WHERE word_english = 'initial';
UPDATE Dictionary SET pronunciation = N'/ˈɪnstɪtjuːt/' WHERE word_english = 'institute';
UPDATE Dictionary SET pronunciation = N'/ˈɪntəɡreɪt/' WHERE word_english = 'integrate';
UPDATE Dictionary SET pronunciation = N'/ɪnˈtɜːprɪt/' WHERE word_english = 'interpret';
UPDATE Dictionary SET pronunciation = N'/ɪnˈvɛst/' WHERE word_english = 'invest';
UPDATE Dictionary SET pronunciation = N'/ˈɪʃuː/' WHERE word_english = 'issue';
UPDATE Dictionary SET pronunciation = N'/ˈleɪbər/' WHERE word_english = 'labor';
UPDATE Dictionary SET pronunciation = N'/ˈleɪər/' WHERE word_english = 'layer';

-- Business English
UPDATE Dictionary SET pronunciation = N'/əˈkaʊntɪŋ/' WHERE word_english = 'accounting';
UPDATE Dictionary SET pronunciation = N'/ˈædvətaɪzɪŋ/' WHERE word_english = 'advertising';
UPDATE Dictionary SET pronunciation = N'/əˈdʒɛndə/' WHERE word_english = 'agenda';
UPDATE Dictionary SET pronunciation = N'/əˈɡriːmənt/' WHERE word_english = 'agreement';
UPDATE Dictionary SET pronunciation = N'/ˈæsɛt/' WHERE word_english = 'asset';
UPDATE Dictionary SET pronunciation = N'/ˈbæŋkrʌpt/' WHERE word_english = 'bankrupt';
UPDATE Dictionary SET pronunciation = N'/ˈbɒndɪŋ/' WHERE word_english = 'bonding';
UPDATE Dictionary SET pronunciation = N'/ˈbrændɪŋ/' WHERE word_english = 'branding';
UPDATE Dictionary SET pronunciation = N'/ˈbʌdʒɪt/' WHERE word_english = 'budget';
UPDATE Dictionary SET pronunciation = N'/ˈkæpɪtəl/' WHERE word_english = 'capital';
UPDATE Dictionary SET pronunciation = N'/kəˈrɪər/' WHERE word_english = 'career';
UPDATE Dictionary SET pronunciation = N'/ˈklaɪənt/' WHERE word_english = 'client';
UPDATE Dictionary SET pronunciation = N'/kəˈlæbəreɪt/' WHERE word_english = 'collaborate';
UPDATE Dictionary SET pronunciation = N'/kəˌmjuːnɪˈkeɪʃn/' WHERE word_english = 'communication';
UPDATE Dictionary SET pronunciation = N'/kəmˈpiːt/' WHERE word_english = 'compete';
UPDATE Dictionary SET pronunciation = N'/ˈkɒntrækṭ/' WHERE word_english = 'contract';
UPDATE Dictionary SET pronunciation = N'/ˈkɔːpəreɪt/' WHERE word_english = 'corporate';
UPDATE Dictionary SET pronunciation = N'/ˈkrɛdɪt/' WHERE word_english = 'credit';
UPDATE Dictionary SET pronunciation = N'/ˈkʌstəmər/' WHERE word_english = 'customer';
UPDATE Dictionary SET pronunciation = N'/ˈdɛdlaɪn/' WHERE word_english = 'deadline';
UPDATE Dictionary SET pronunciation = N'/dɪˈlɪvər/' WHERE word_english = 'deliver';
UPDATE Dictionary SET pronunciation = N'/dɪˈpɑːtmənt/' WHERE word_english = 'department';
UPDATE Dictionary SET pronunciation = N'/dɪˌpriːʃiˈeɪʃn/' WHERE word_english = 'depreciation';
UPDATE Dictionary SET pronunciation = N'/ˈdɪvɪdɛnd/' WHERE word_english = 'dividend';
UPDATE Dictionary SET pronunciation = N'/ɪˈfɪʃənsi/' WHERE word_english = 'efficiency';
UPDATE Dictionary SET pronunciation = N'/ˈɛntəpraɪz/' WHERE word_english = 'enterprise';
UPDATE Dictionary SET pronunciation = N'/ˈɛkwɪti/' WHERE word_english = 'equity';
UPDATE Dictionary SET pronunciation = N'/ɪkˈspɛndɪtʃər/' WHERE word_english = 'expenditure';
UPDATE Dictionary SET pronunciation = N'/ɪkˈspɔːt/' WHERE word_english = 'export';
UPDATE Dictionary SET pronunciation = N'/faɪˈnæns/' WHERE word_english = 'finance';
UPDATE Dictionary SET pronunciation = N'/ˈfɔːkæst/' WHERE word_english = 'forecast';

-- Travel Phrases
UPDATE Dictionary SET pronunciation = N'/ˈeəpɔːt/' WHERE word_english = 'airport';
UPDATE Dictionary SET pronunciation = N'/əˈraɪvəl/' WHERE word_english = 'arrival';
UPDATE Dictionary SET pronunciation = N'/ˈbæɡɪdʒ/' WHERE word_english = 'baggage';
UPDATE Dictionary SET pronunciation = N'/ˈbɔːdɪŋ/' WHERE word_english = 'boarding';
UPDATE Dictionary SET pronunciation = N'/ˈbʊkɪŋ/' WHERE word_english = 'booking';
UPDATE Dictionary SET pronunciation = N'/ˈtʃekaʊt/' WHERE word_english = 'checkout';
UPDATE Dictionary SET pronunciation = N'/ˈkʌstəmz/' WHERE word_english = 'customs';
UPDATE Dictionary SET pronunciation = N'/dɪˈleɪ/' WHERE word_english = 'delay';
UPDATE Dictionary SET pronunciation = N'/dɪˈpɑːtʃər/' WHERE word_english = 'departure';
UPDATE Dictionary SET pronunciation = N'/ˌdɛstɪˈneɪʃn/' WHERE word_english = 'destination';
UPDATE Dictionary SET pronunciation = N'/ɪkˈstʃeɪndʒ/' WHERE word_english = 'exchange';
UPDATE Dictionary SET pronunciation = N'/flaɪt/' WHERE word_english = 'flight';
UPDATE Dictionary SET pronunciation = N'/ˈɡaɪd/' WHERE word_english = 'guide';
UPDATE Dictionary SET pronunciation = N'/həʊˈtɛl/' WHERE word_english = 'hotel';
UPDATE Dictionary SET pronunciation = N'/ɪˌmɪɡˈreɪʃn/' WHERE word_english = 'immigration';
UPDATE Dictionary SET pronunciation = N'/ˈɪtɪnərɛri/' WHERE word_english = 'itinerary';
UPDATE Dictionary SET pronunciation = N'/ˈdʒɜːni/' WHERE word_english = 'journey';
UPDATE Dictionary SET pronunciation = N'/ˈlʌɡɪdʒ/' WHERE word_english = 'luggage';
UPDATE Dictionary SET pronunciation = N'/ˈpæspɔːt/' WHERE word_english = 'passport';
UPDATE Dictionary SET pronunciation = N'/plætˈfɔːm/' WHERE word_english = 'platform';
UPDATE Dictionary SET pronunciation = N'/ˌrɛzəˈveɪʃn/' WHERE word_english = 'reservation';
UPDATE Dictionary SET pronunciation = N'/ˈsuːvənɪər/' WHERE word_english = 'souvenir';
UPDATE Dictionary SET pronunciation = N'/ˈtɪkɪt/' WHERE word_english = 'ticket';
UPDATE Dictionary SET pronunciation = N'/ˈtʊərɪst/' WHERE word_english = 'tourist';
UPDATE Dictionary SET pronunciation = N'/ˈviːzə/' WHERE word_english = 'visa';

-- Daily Conversation  
UPDATE Dictionary SET pronunciation = N'/əˈpɒlədʒaɪz/' WHERE word_english = 'apologize';
UPDATE Dictionary SET pronunciation = N'/ˈbɛvərɪdʒ/' WHERE word_english = 'beverage';
UPDATE Dictionary SET pronunciation = N'/ˈbreɪkfəst/' WHERE word_english = 'breakfast';
UPDATE Dictionary SET pronunciation = N'/ˈsɛlɪbreɪt/' WHERE word_english = 'celebrate';
UPDATE Dictionary SET pronunciation = N'/ˈkɒnfɪdənt/' WHERE word_english = 'confident';
UPDATE Dictionary SET pronunciation = N'/kənˈɡrætʃʊleɪt/' WHERE word_english = 'congratulate';
UPDATE Dictionary SET pronunciation = N'/kənˈviːniənt/' WHERE word_english = 'convenient';
UPDATE Dictionary SET pronunciation = N'/ˈdɪnər/' WHERE word_english = 'dinner';
UPDATE Dictionary SET pronunciation = N'/dɪsˈkʌs/' WHERE word_english = 'discuss';
UPDATE Dictionary SET pronunciation = N'/ɪnˈdʒɔɪ/' WHERE word_english = 'enjoy';
UPDATE Dictionary SET pronunciation = N'/ɪkˈsaɪtɪd/' WHERE word_english = 'excited';
UPDATE Dictionary SET pronunciation = N'/ˈfævərɪt/' WHERE word_english = 'favorite';
UPDATE Dictionary SET pronunciation = N'/fəˈɡɛt/' WHERE word_english = 'forget';
UPDATE Dictionary SET pronunciation = N'/ˈɡreɪtfʊl/' WHERE word_english = 'grateful';
UPDATE Dictionary SET pronunciation = N'/həˈləʊ/' WHERE word_english = 'hello';
UPDATE Dictionary SET pronunciation = N'/ˈhɛlpfʊl/' WHERE word_english = 'helpful';
UPDATE Dictionary SET pronunciation = N'/ˈhɒbi/' WHERE word_english = 'hobby';
UPDATE Dictionary SET pronunciation = N'/ˈɪntəˌrɛstɪŋ/' WHERE word_english = 'interesting';
UPDATE Dictionary SET pronunciation = N'/ɪnˈvaɪt/' WHERE word_english = 'invite';
UPDATE Dictionary SET pronunciation = N'/lʌntʃ/' WHERE word_english = 'lunch';
UPDATE Dictionary SET pronunciation = N'/ˈmɛsɪdʒ/' WHERE word_english = 'message';
UPDATE Dictionary SET pronunciation = N'/ˈneɪbər/' WHERE word_english = 'neighbor';
UPDATE Dictionary SET pronunciation = N'/əˈkeɪʒn/' WHERE word_english = 'occasion';
UPDATE Dictionary SET pronunciation = N'/əˈpɔːtjuːnɪti/' WHERE word_english = 'opportunity';
UPDATE Dictionary SET pronunciation = N'/ˈpɑːti/' WHERE word_english = 'party';
UPDATE Dictionary SET pronunciation = N'/plɛʒər/' WHERE word_english = 'pleasure';
UPDATE Dictionary SET pronunciation = N'/ˈprɒmɪs/' WHERE word_english = 'promise';
UPDATE Dictionary SET pronunciation = N'/rɪˈkɒɡnaɪz/' WHERE word_english = 'recognize';
UPDATE Dictionary SET pronunciation = N'/rɪˈkɒmɛnd/' WHERE word_english = 'recommend';
UPDATE Dictionary SET pronunciation = N'/rɪˈmɛmbər/' WHERE word_english = 'remember';
UPDATE Dictionary SET pronunciation = N'/rɪˈspɒnsɪbl/' WHERE word_english = 'responsible';
UPDATE Dictionary SET pronunciation = N'/ˈʃɒpɪŋ/' WHERE word_english = 'shopping';
UPDATE Dictionary SET pronunciation = N'/ˈsɒri/' WHERE word_english = 'sorry';
UPDATE Dictionary SET pronunciation = N'/sərˈpraɪz/' WHERE word_english = 'surprise';
UPDATE Dictionary SET pronunciation = N'/ˈθæŋk/' WHERE word_english = 'thank';
UPDATE Dictionary SET pronunciation = N'/tʊˈɡɛðər/' WHERE word_english = 'together';
UPDATE Dictionary SET pronunciation = N'/ˈwɛkənd/' WHERE word_english = 'weekend';
UPDATE Dictionary SET pronunciation = N'/ˈwʌndərfʊl/' WHERE word_english = 'wonderful';

-- Verify
SELECT word_english, pronunciation 
FROM Dictionary 
WHERE pronunciation IS NOT NULL 
ORDER BY word_english;

PRINT 'Done! Pronunciation fixed for all words.';

