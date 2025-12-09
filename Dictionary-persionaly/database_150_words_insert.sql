-- =====================================================
-- INSERT 150 WORDS INTO DICTIONARY
-- Categories: TOEFL, Business, Travel, Daily
-- Date: December 8, 2025
-- =====================================================

USE Spring1;
GO

-- =====================================================
-- TOEFL VOCABULARY (40 words)
-- =====================================================
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES
-- Academic & Study
('analyze', N'phân tích', '/ˈænəlaɪz/', 'verb', 'We need to analyze the data carefully.', N'Chúng ta cần phân tích dữ liệu cẩn thận.', 1),
('hypothesis', N'giả thuyết', '/haɪˈpɑːθəsɪs/', 'noun', 'The scientist proposed a new hypothesis.', N'Nhà khoa học đề xuất một giả thuyết mới.', 1),
('significant', N'quan trọng, đáng kể', '/sɪɡˈnɪfɪkənt/', 'adjective', 'This is a significant discovery.', N'Đây là một phát hiện quan trọng.', 1),
('demonstrate', N'chứng minh, thể hiện', '/ˈdemənstreɪt/', 'verb', 'Can you demonstrate how it works?', N'Bạn có thể chứng minh nó hoạt động như thế nào không?', 1),
('establish', N'thiết lập, thành lập', '/ɪˈstæblɪʃ/', 'verb', 'They established a new company.', N'Họ thành lập một công ty mới.', 1),
('subsequent', N'tiếp theo, sau đó', '/ˈsʌbsɪkwənt/', 'adjective', 'Subsequent events proved him right.', N'Các sự kiện tiếp theo đã chứng minh anh ấy đúng.', 1),
('enhance', N'nâng cao, tăng cường', '/ɪnˈhæns/', 'verb', 'This will enhance your skills.', N'Điều này sẽ nâng cao kỹ năng của bạn.', 1),
('fundamental', N'cơ bản, căn bản', '/ˌfʌndəˈmentl/', 'adjective', 'These are fundamental principles.', N'Đây là những nguyên tắc cơ bản.', 1),
('comprehensive', N'toàn diện, bao quát', '/ˌkɑːmprɪˈhensɪv/', 'adjective', 'We need a comprehensive plan.', N'Chúng ta cần một kế hoạch toàn diện.', 1),
('implementation', N'sự thực hiện', '/ˌɪmplɪmenˈteɪʃn/', 'noun', 'The implementation was successful.', N'Việc thực hiện đã thành công.', 1),
('contribute', N'đóng góp', '/kənˈtrɪbjuːt/', 'verb', 'Everyone should contribute ideas.', N'Mọi người nên đóng góp ý tưởng.', 1),
('obtain', N'đạt được, thu được', '/əbˈteɪn/', 'verb', 'We need to obtain permission first.', N'Chúng ta cần xin phép trước.', 1),
('evident', N'rõ ràng, hiển nhiên', '/ˈevɪdənt/', 'adjective', 'It is evident that he is lying.', N'Rõ ràng là anh ta đang nói dối.', 1),
('assume', N'giả định, cho rằng', '/əˈsuːm/', 'verb', 'I assume you already know this.', N'Tôi cho rằng bạn đã biết điều này.', 1),
('implicit', N'ngầm hiểu, tiềm ẩn', '/ɪmˈplɪsɪt/', 'adjective', 'There was an implicit agreement.', N'Có một thỏa thuận ngầm.', 1),
('emerge', N'nổi lên, xuất hiện', '/iˈmɜːrdʒ/', 'verb', 'A new leader emerged from the crisis.', N'Một nhà lãnh đạo mới nổi lên từ khủng hoảng.', 1),
('persist', N'kiên trì, dai dẳng', '/pərˈsɪst/', 'verb', 'You must persist to succeed.', N'Bạn phải kiên trì để thành công.', 1),
('inevitable', N'không thể tránh khỏi', '/ɪnˈevɪtəbl/', 'adjective', 'Change is inevitable.', N'Thay đổi là điều không thể tránh khỏi.', 1),
('arbitrary', N'tùy tiện, độc đoán', '/ˈɑːrbɪtreri/', 'adjective', 'That was an arbitrary decision.', N'Đó là một quyết định tùy tiện.', 1),
('advocate', N'ủng hộ, bênh vực', '/ˈædvəkeɪt/', 'verb', 'I advocate for human rights.', N'Tôi ủng hộ quyền con người.', 1),
('coherent', N'mạch lạc, chặt chẽ', '/koʊˈhɪrənt/', 'adjective', 'Please give a coherent explanation.', N'Hãy đưa ra lời giải thích mạch lạc.', 1),
('utilize', N'sử dụng, tận dụng', '/ˈjuːtəlaɪz/', 'verb', 'We should utilize all resources.', N'Chúng ta nên tận dụng mọi nguồn lực.', 1),
('restrict', N'hạn chế, giới hạn', '/rɪˈstrɪkt/', 'verb', 'They restrict access to the area.', N'Họ hạn chế truy cập vào khu vực.', 1),
('distinct', N'riêng biệt, khác biệt', '/dɪˈstɪŋkt/', 'adjective', 'Each has a distinct flavor.', N'Mỗi cái có hương vị riêng biệt.', 1),
('diverse', N'đa dạng', '/daɪˈvɜːrs/', 'adjective', 'We have a diverse team.', N'Chúng tôi có một đội ngũ đa dạng.', 1),
('ambiguous', N'mơ hồ, nhập nhằng', '/æmˈbɪɡjuəs/', 'adjective', 'The answer was ambiguous.', N'Câu trả lời mơ hồ.', 1),
('deliberate', N'cố ý, thận trọng', '/dɪˈlɪbərət/', 'adjective', 'It was a deliberate action.', N'Đó là một hành động cố ý.', 1),
('profound', N'sâu sắc', '/prəˈfaʊnd/', 'adjective', 'He had a profound impact.', N'Anh ấy có tác động sâu sắc.', 1),
('preliminary', N'sơ bộ, ban đầu', '/prɪˈlɪmɪneri/', 'adjective', 'These are preliminary results.', N'Đây là kết quả sơ bộ.', 1),
('accumulate', N'tích lũy', '/əˈkjuːmjəleɪt/', 'verb', 'We accumulate knowledge over time.', N'Chúng ta tích lũy kiến thức theo thời gian.', 1),
('diminish', N'giảm bớt, thu nhỏ', '/dɪˈmɪnɪʃ/', 'verb', 'The effect will diminish over time.', N'Hiệu quả sẽ giảm bớt theo thời gian.', 1),
('verify', N'xác minh, kiểm chứng', '/ˈverɪfaɪ/', 'verb', 'Please verify your identity.', N'Vui lòng xác minh danh tính của bạn.', 1),
('facilitate', N'tạo điều kiện, hỗ trợ', '/fəˈsɪlɪteɪt/', 'verb', 'This will facilitate the process.', N'Điều này sẽ tạo điều kiện cho quá trình.', 1),
('articulate', N'diễn đạt rõ ràng', '/ɑːrˈtɪkjuleɪt/', 'verb', 'She can articulate her thoughts well.', N'Cô ấy có thể diễn đạt suy nghĩ rõ ràng.', 1),
('inherent', N'vốn có, cố hữu', '/ɪnˈhɪrənt/', 'adjective', 'There are inherent risks.', N'Có những rủi ro vốn có.', 1),
('supplement', N'bổ sung', '/ˈsʌplɪmənt/', 'verb', 'Supplement your diet with vitamins.', N'Bổ sung chế độ ăn của bạn bằng vitamin.', 1),
('skeptical', N'hoài nghi', '/ˈskeptɪkl/', 'adjective', 'I am skeptical about that claim.', N'Tôi hoài nghi về tuyên bố đó.', 1),
('retain', N'giữ lại, duy trì', '/rɪˈteɪn/', 'verb', 'We need to retain good employees.', N'Chúng ta cần giữ lại nhân viên giỏi.', 1),
('constitute', N'cấu thành', '/ˈkɑːnstɪtuːt/', 'verb', 'Women constitute 50% of the workforce.', N'Phụ nữ chiếm 50% lực lượng lao động.', 1),
('paradigm', N'mô hình, khuôn mẫu', '/ˈpærədaɪm/', 'noun', 'We need a new paradigm.', N'Chúng ta cần một mô hình mới.', 1);

-- =====================================================
-- BUSINESS ENGLISH (40 words)
-- =====================================================
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES
-- Business Operations
('negotiate', N'đàm phán, thương lượng', '/nɪˈɡoʊʃieɪt/', 'verb', 'We need to negotiate the terms.', N'Chúng ta cần đàm phán các điều khoản.', 1),
('proposal', N'đề xuất, đề nghị', '/prəˈpoʊzl/', 'noun', 'Please review our proposal.', N'Vui lòng xem xét đề xuất của chúng tôi.', 1),
('quarterly', N'hàng quý', '/ˈkwɔːrtərli/', 'adjective', 'We have quarterly meetings.', N'Chúng tôi có các cuộc họp hàng quý.', 1),
('revenue', N'doanh thu', '/ˈrevənuː/', 'noun', 'Revenue increased by 20%.', N'Doanh thu tăng 20%.', 1),
('expenditure', N'chi tiêu, chi phí', '/ɪkˈspendɪtʃər/', 'noun', 'Control your expenditure.', N'Kiểm soát chi tiêu của bạn.', 1),
('stakeholder', N'bên liên quan', '/ˈsteɪkhoʊldər/', 'noun', 'All stakeholders must agree.', N'Tất cả các bên liên quan phải đồng ý.', 1),
('merger', N'sáp nhập', '/ˈmɜːrdʒər/', 'noun', 'The merger was announced today.', N'Vụ sáp nhập được công bố hôm nay.', 1),
('acquisition', N'mua lại, thâu tóm', '/ˌækwɪˈzɪʃn/', 'noun', 'The acquisition cost $5 million.', N'Việc mua lại tốn 5 triệu đô la.', 1),
('deadline', N'thời hạn', '/ˈdedlaɪn/', 'noun', 'The deadline is tomorrow.', N'Thời hạn là ngày mai.', 1),
('agenda', N'chương trình nghị sự', '/əˈdʒendə/', 'noun', 'What is on the agenda today?', N'Hôm nay có gì trong chương trình nghị sự?', 1),
('collaborate', N'hợp tác', '/kəˈlæbəreɪt/', 'verb', 'We collaborate with partners.', N'Chúng tôi hợp tác với đối tác.', 1),
('allocate', N'phân bổ', '/ˈæləkeɪt/', 'verb', 'Allocate resources wisely.', N'Phân bổ nguồn lực một cách khôn ngoan.', 1),
('forecast', N'dự báo', '/ˈfɔːrkæst/', 'noun', 'The sales forecast looks good.', N'Dự báo doanh số trông tốt.', 1),
('invoice', N'hóa đơn', '/ˈɪnvɔɪs/', 'noun', 'Send me the invoice.', N'Gửi cho tôi hóa đơn.', 1),
('quotation', N'báo giá', '/kwoʊˈteɪʃn/', 'noun', 'Request a quotation.', N'Yêu cầu báo giá.', 1),
('inventory', N'hàng tồn kho', '/ˈɪnvəntɔːri/', 'noun', 'Check the inventory levels.', N'Kiểm tra mức tồn kho.', 1),
('logistics', N'hậu cần', '/loʊˈdʒɪstɪks/', 'noun', 'We handle all logistics.', N'Chúng tôi xử lý mọi hậu cần.', 1),
('audit', N'kiểm toán', '/ˈɔːdɪt/', 'noun', 'We passed the audit.', N'Chúng tôi đã vượt qua kiểm toán.', 1),
('outsource', N'thuê ngoài', '/ˈaʊtsɔːrs/', 'verb', 'We outsource IT services.', N'Chúng tôi thuê ngoài dịch vụ IT.', 1),
('benchmark', N'điểm chuẩn', '/ˈbentʃmɑːrk/', 'noun', 'Set a benchmark for quality.', N'Đặt điểm chuẩn cho chất lượng.', 1),
('viable', N'khả thi', '/ˈvaɪəbl/', 'adjective', 'Is this plan viable?', N'Kế hoạch này có khả thi không?', 1),
('incentive', N'khuyến khích, động lực', '/ɪnˈsentɪv/', 'noun', 'Offer incentives to employees.', N'Cung cấp động lực cho nhân viên.', 1),
('turnover', N'doanh thu, tỷ lệ luân chuyển', '/ˈtɜːrnoʊvər/', 'noun', 'Staff turnover is high.', N'Tỷ lệ luân chuyển nhân viên cao.', 1),
('overhead', N'chi phí chung', '/ˈoʊvərhed/', 'noun', 'Reduce overhead costs.', N'Giảm chi phí chung.', 1),
('margin', N'biên lợi nhuận', '/ˈmɑːrdʒɪn/', 'noun', 'Profit margin is 15%.', N'Biên lợi nhuận là 15%.', 1),
('portfolio', N'danh mục đầu tư', '/pɔːrtˈfoʊlioʊ/', 'noun', 'Diversify your portfolio.', N'Đa dạng hóa danh mục đầu tư của bạn.', 1),
('liability', N'trách nhiệm pháp lý, nợ', '/ˌlaɪəˈbɪləti/', 'noun', 'The company has limited liability.', N'Công ty có trách nhiệm hữu hạn.', 1),
('asset', N'tài sản', '/ˈæset/', 'noun', 'Property is a valuable asset.', N'Bất động sản là tài sản có giá trị.', 1),
('equity', N'vốn chủ sở hữu', '/ˈekwəti/', 'noun', 'Owner equity increased.', N'Vốn chủ sở hữu tăng lên.', 1),
('depreciation', N'khấu hao', '/dɪˌpriːʃiˈeɪʃn/', 'noun', 'Calculate annual depreciation.', N'Tính khấu hao hàng năm.', 1),
('franchise', N'nhượng quyền', '/ˈfræntʃaɪz/', 'noun', 'Open a franchise.', N'Mở một cửa hàng nhượng quyền.', 1),
('trademark', N'thương hiệu', '/ˈtreɪdmɑːrk/', 'noun', 'Register your trademark.', N'Đăng ký thương hiệu của bạn.', 1),
('patent', N'bằng sáng chế', '/ˈpætnt/', 'noun', 'File a patent application.', N'Nộp đơn xin bằng sáng chế.', 1),
('consortium', N'tập đoàn, liên hiệp', '/kənˈsɔːrtiəm/', 'noun', 'Join the consortium.', N'Tham gia tập đoàn.', 1),
('subsidiary', N'công ty con', '/səbˈsɪdieri/', 'noun', 'It is a subsidiary company.', N'Đó là một công ty con.', 1),
('liquidate', N'thanh lý', '/ˈlɪkwɪdeɪt/', 'verb', 'Liquidate the assets.', N'Thanh lý tài sản.', 1),
('solvent', N'có khả năng thanh toán', '/ˈsɑːlvənt/', 'adjective', 'The company is solvent.', N'Công ty có khả năng thanh toán.', 1),
('arbitration', N'trọng tài', '/ˌɑːrbɪˈtreɪʃn/', 'noun', 'Go to arbitration.', N'Đưa ra trọng tài.', 1),
('compliance', N'tuân thủ', '/kəmˈplaɪəns/', 'noun', 'Ensure compliance with regulations.', N'Đảm bảo tuân thủ quy định.', 1),
('reimburse', N'hoàn trả', '/ˌriːɪmˈbɜːrs/', 'verb', 'We will reimburse expenses.', N'Chúng tôi sẽ hoàn trả chi phí.', 1);

-- =====================================================
-- TRAVEL PHRASES (35 words)
-- =====================================================
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES
-- Travel & Tourism
('itinerary', N'lịch trình du lịch', '/aɪˈtɪnəreri/', 'noun', 'Check your travel itinerary.', N'Kiểm tra lịch trình du lịch của bạn.', 1),
('reservation', N'đặt chỗ', '/ˌrezərˈveɪʃn/', 'noun', 'I have a reservation.', N'Tôi có đặt chỗ.', 1),
('departure', N'khởi hành', '/dɪˈpɑːrtʃər/', 'noun', 'Departure time is 9 AM.', N'Giờ khởi hành là 9 giờ sáng.', 1),
('arrival', N'đến nơi', '/əˈraɪvl/', 'noun', 'Arrival is at 3 PM.', N'Đến nơi lúc 3 giờ chiều.', 1),
('luggage', N'hành lý', '/ˈlʌɡɪdʒ/', 'noun', 'Where is my luggage?', N'Hành lý của tôi ở đâu?', 1),
('passport', N'hộ chiếu', '/ˈpæspɔːrt/', 'noun', 'Show your passport.', N'Xuất trình hộ chiếu của bạn.', 1),
('visa', N'thị thực', '/ˈviːzə/', 'noun', 'Apply for a visa.', N'Xin thị thực.', 1),
('customs', N'hải quan', '/ˈkʌstəmz/', 'noun', 'Go through customs.', N'Đi qua hải quan.', 1),
('boarding', N'lên tàu/máy bay', '/ˈbɔːrdɪŋ/', 'noun', 'Boarding starts at gate 5.', N'Lên máy bay bắt đầu tại cổng 5.', 1),
('accommodation', N'chỗ ở', '/əˌkɑːməˈdeɪʃn/', 'noun', 'Book accommodation online.', N'Đặt chỗ ở trực tuyến.', 1),
('destination', N'điểm đến', '/ˌdestɪˈneɪʃn/', 'noun', 'What is your destination?', N'Điểm đến của bạn là đâu?', 1),
('excursion', N'chuyến tham quan', '/ɪkˈskɜːrʒn/', 'noun', 'Join the excursion.', N'Tham gia chuyến tham quan.', 1),
('souvenir', N'quà lưu niệm', '/ˌsuːvəˈnɪr/', 'noun', 'Buy a souvenir.', N'Mua quà lưu niệm.', 1),
('currency', N'tiền tệ', '/ˈkɜːrənsi/', 'noun', 'Exchange currency at the bank.', N'Đổi tiền tại ngân hàng.', 1),
('embassy', N'đại sứ quán', '/ˈembəsi/', 'noun', 'Contact the embassy.', N'Liên hệ đại sứ quán.', 1),
('backpack', N'ba lô', '/ˈbækpæk/', 'noun', 'Pack your backpack.', N'Sắp xếp ba lô của bạn.', 1),
('hostel', N'nhà trọ, ký túc xá', '/ˈhɑːstl/', 'noun', 'Stay at a hostel.', N'Ở tại nhà trọ.', 1),
('sightseeing', N'ngắm cảnh, tham quan', '/ˈsaɪtsiːɪŋ/', 'noun', 'Go sightseeing downtown.', N'Đi tham quan trung tâm thành phố.', 1),
('tourist', N'du khách', '/ˈtʊrɪst/', 'noun', 'Many tourists visit here.', N'Nhiều du khách ghé thăm đây.', 1),
('journey', N'hành trình', '/ˈdʒɜːrni/', 'noun', 'Have a safe journey.', N'Chúc bạn có hành trình an toàn.', 1),
('reception', N'lễ tân', '/rɪˈsepʃn/', 'noun', 'Ask at the reception desk.', N'Hỏi tại quầy lễ tân.', 1),
('checkout', N'trả phòng', '/ˈtʃekaʊt/', 'noun', 'Checkout time is 11 AM.', N'Giờ trả phòng là 11 giờ sáng.', 1),
('brochure', N'tờ rơi, sách mỏng', '/broʊˈʃʊr/', 'noun', 'Read the travel brochure.', N'Đọc tờ rơi du lịch.', 1),
('guidebook', N'sách hướng dẫn', '/ˈɡaɪdbʊk/', 'noun', 'Buy a guidebook.', N'Mua một cuốn sách hướng dẫn.', 1),
('landmark', N'địa danh', '/ˈlændmɑːrk/', 'noun', 'Visit famous landmarks.', N'Tham quan những địa danh nổi tiếng.', 1),
('attraction', N'điểm thu hút', '/əˈtrækʃn/', 'noun', 'Top tourist attraction.', N'Điểm thu hút khách du lịch hàng đầu.', 1),
('cancellation', N'hủy bỏ', '/ˌkænsəˈleɪʃn/', 'noun', 'Free cancellation policy.', N'Chính sách hủy miễn phí.', 1),
('refund', N'hoàn tiền', '/ˈriːfʌnd/', 'noun', 'Request a refund.', N'Yêu cầu hoàn tiền.', 1),
('upgrade', N'nâng cấp', '/ˈʌpɡreɪd/', 'noun', 'Get a room upgrade.', N'Được nâng cấp phòng.', 1),
('layover', N'dừng chân', '/ˈleɪoʊvər/', 'noun', 'There is a 2-hour layover.', N'Có 2 giờ dừng chân.', 1),
('baggage', N'hành lý', '/ˈbæɡɪdʒ/', 'noun', 'Claim your baggage.', N'Nhận hành lý của bạn.', 1),
('shuttle', N'xe đưa đón', '/ˈʃʌtl/', 'noun', 'Take the airport shuttle.', N'Đi xe đưa đón sân bay.', 1),
('landmark', N'mốc, cột mốc', '/ˈlændmɑːrk/', 'noun', 'This is a historical landmark.', N'Đây là một cột mốc lịch sử.', 1),
('expedition', N'cuộc thám hiểm', '/ˌekspəˈdɪʃn/', 'noun', 'Join an expedition.', N'Tham gia cuộc thám hiểm.', 1),
('cruise', N'chuyến du thuyền', '/kruːz/', 'noun', 'Go on a cruise.', N'Đi du thuyền.', 1);

-- =====================================================
-- DAILY CONVERSATION (35 words)
-- =====================================================
INSERT INTO Dictionary (word_english, word_vietnamese, pronunciation, word_type, example_sentence, example_translation, created_by)
VALUES
-- Everyday Life
('appreciate', N'trân trọng, đánh giá cao', '/əˈpriːʃieɪt/', 'verb', 'I appreciate your help.', N'Tôi trân trọng sự giúp đỡ của bạn.', 1),
('apologize', N'xin lỗi', '/əˈpɑːlədʒaɪz/', 'verb', 'I apologize for being late.', N'Tôi xin lỗi vì đến muộn.', 1),
('borrow', N'mượn', '/ˈbɑːroʊ/', 'verb', 'Can I borrow your pen?', N'Tôi có thể mượn bút của bạn không?', 1),
('lend', N'cho mượn', '/lend/', 'verb', 'I can lend you money.', N'Tôi có thể cho bạn mượn tiền.', 1),
('recommend', N'gợi ý, đề xuất', '/ˌrekəˈmend/', 'verb', 'I recommend this restaurant.', N'Tôi gợi ý nhà hàng này.', 1),
('prefer', N'thích hơn', '/prɪˈfɜːr/', 'verb', 'I prefer coffee to tea.', N'Tôi thích cà phê hơn trà.', 1),
('enjoy', N'thích thú, tận hưởng', '/ɪnˈdʒɔɪ/', 'verb', 'I enjoy reading books.', N'Tôi thích đọc sách.', 1),
('introduce', N'giới thiệu', '/ˌɪntrəˈduːs/', 'verb', 'Let me introduce myself.', N'Để tôi tự giới thiệu.', 1),
('remind', N'nhắc nhở', '/rɪˈmaɪnd/', 'verb', 'Please remind me tomorrow.', N'Vui lòng nhắc tôi ngày mai.', 1),
('explain', N'giải thích', '/ɪkˈspleɪn/', 'verb', 'Can you explain this?', N'Bạn có thể giải thích điều này không?', 1),
('complain', N'phàn nàn', '/kəmˈpleɪn/', 'verb', 'Don''t complain too much.', N'Đừng phàn nàn quá nhiều.', 1),
('discuss', N'thảo luận', '/dɪˈskʌs/', 'verb', 'Let''s discuss the plan.', N'Hãy thảo luận kế hoạch.', 1),
('mention', N'đề cập', '/ˈmenʃn/', 'verb', 'He mentioned your name.', N'Anh ấy đã đề cập tên bạn.', 1),
('suggest', N'đề nghị, gợi ý', '/səˈdʒest/', 'verb', 'I suggest we leave now.', N'Tôi đề nghị chúng ta đi ngay.', 1),
('realize', N'nhận ra', '/ˈriːəlaɪz/', 'verb', 'I realize my mistake.', N'Tôi nhận ra lỗi của mình.', 1),
('notice', N'chú ý', '/ˈnoʊtɪs/', 'verb', 'Did you notice the change?', N'Bạn có chú ý sự thay đổi không?', 1),
('recognize', N'nhận ra, công nhận', '/ˈrekəɡnaɪz/', 'verb', 'I don''t recognize you.', N'Tôi không nhận ra bạn.', 1),
('suppose', N'cho rằng, giả sử', '/səˈpoʊz/', 'verb', 'I suppose you''re right.', N'Tôi cho rằng bạn đúng.', 1),
('deserve', N'xứng đáng', '/dɪˈzɜːrv/', 'verb', 'You deserve a break.', N'Bạn xứng đáng được nghỉ ngơi.', 1),
('afford', N'có đủ tiền', '/əˈfɔːrd/', 'verb', 'I can''t afford it.', N'Tôi không đủ tiền mua nó.', 1),
('replace', N'thay thế', '/rɪˈpleɪs/', 'verb', 'Replace the battery.', N'Thay thế pin.', 1),
('improve', N'cải thiện', '/ɪmˈpruːv/', 'verb', 'I want to improve my English.', N'Tôi muốn cải thiện tiếng Anh của mình.', 1),
('prepare', N'chuẩn bị', '/prɪˈper/', 'verb', 'Prepare for the exam.', N'Chuẩn bị cho kỳ thi.', 1),
('promise', N'hứa', '/ˈprɑːmɪs/', 'verb', 'I promise to help you.', N'Tôi hứa sẽ giúp bạn.', 1),
('refuse', N'từ chối', '/rɪˈfjuːz/', 'verb', 'He refused my offer.', N'Anh ấy từ chối lời đề nghị của tôi.', 1),
('accept', N'chấp nhận', '/əkˈsept/', 'verb', 'I accept your apology.', N'Tôi chấp nhận lời xin lỗi của bạn.', 1),
('admit', N'thừa nhận', '/ədˈmɪt/', 'verb', 'I admit I was wrong.', N'Tôi thừa nhận mình đã sai.', 1),
('deny', N'phủ nhận', '/dɪˈnaɪ/', 'verb', 'He denied the accusation.', N'Anh ấy phủ nhận cáo buộc.', 1),
('consider', N'xem xét, cân nhắc', '/kənˈsɪdər/', 'verb', 'Consider my proposal.', N'Hãy xem xét đề xuất của tôi.', 1),
('manage', N'quản lý, xoay sở', '/ˈmænɪdʒ/', 'verb', 'I can manage it myself.', N'Tôi có thể tự xoay sở.', 1),
('arrange', N'sắp xếp', '/əˈreɪndʒ/', 'verb', 'Arrange the meeting.', N'Sắp xếp cuộc họp.', 1),
('decide', N'quyết định', '/dɪˈsaɪd/', 'verb', 'Have you decided yet?', N'Bạn đã quyết định chưa?', 1),
('confirm', N'xác nhận', '/kənˈfɜːrm/', 'verb', 'Please confirm your attendance.', N'Vui lòng xác nhận sự có mặt của bạn.', 1),
('cancel', N'hủy bỏ', '/ˈkænsl/', 'verb', 'Cancel the appointment.', N'Hủy cuộc hẹn.', 1),
('postpone', N'hoãn lại', '/poʊstˈpoʊn/', 'verb', 'Postpone the meeting.', N'Hoãn cuộc họp.', 1);

GO

PRINT '✅ Successfully inserted 150 words into Dictionary!';
PRINT '   - TOEFL Vocabulary: 40 words';
PRINT '   - Business English: 40 words';
PRINT '   - Travel Phrases: 35 words';
PRINT '   - Daily Conversation: 35 words';
PRINT '   TOTAL: 150 words';
GO

