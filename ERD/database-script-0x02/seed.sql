-- ========================================
-- Sample Data Inserts for AirBnB Clone
-- ========================================

-- ================================
-- Users
-- ================================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com', 'hashedpassword1', '1234567890', 'guest', CURRENT_TIMESTAMP),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hashedpassword2', '2345678901', 'host', CURRENT_TIMESTAMP),
('33333333-3333-3333-3333-333333333333', 'Carol', 'Williams', 'carol@example.com', 'hashedpassword3', '3456789012', 'admin', CURRENT_TIMESTAMP),
('44444444-4444-4444-4444-444444444444', 'David', 'Brown', 'david@example.com', 'hashedpassword4', '4567890123', 'guest', CURRENT_TIMESTAMP);

-- ================================
-- Properties
-- ================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 'Sunny Apartment', 'A bright, cozy apartment in the city center.', 'New York, USA', 120.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', 'Beach House', 'A beautiful beach house with ocean views.', 'Miami, USA', 250.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ================================
-- Bookings
-- ================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', '2025-06-01', '2025-06-05', 480.00, 'confirmed', CURRENT_TIMESTAMP),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', '2025-07-10', '2025-07-15', 1250.00, 'pending', CURRENT_TIMESTAMP);

-- ================================
-- Payments
-- ================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 480.00, CURRENT_TIMESTAMP, 'credit_card'),
('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 1250.00, CURRENT_TIMESTAMP, 'paypal');

-- ================================
-- Reviews
-- ================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('ddddddd1-dddd-dddd-dddd-dddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 5, 'Amazing place, very clean and comfortable!', CURRENT_TIMESTAMP),
('ddddddd2-dddd-dddd-dddd-dddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', 4, 'Lovely house but a bit far from town.', CURRENT_TIMESTAMP);

-- ================================
-- Messages
-- ================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi Bob, is the apartment available in July?', CURRENT_TIMESTAMP),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi Alice, yes it is available from July 5th.', CURRENT_TIMESTAMP);
