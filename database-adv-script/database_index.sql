-- ========================
-- PERFORMANCE BENCHMARKING (BEFORE INDEXES)
-- ========================
-- Run these EXPLAIN ANALYZE queries *before* creating indexes.

-- Property Table
EXPLAIN ANALYZE
SELECT * FROM Property
WHERE location = 'Nairobi';

EXPLAIN ANALYZE
SELECT * FROM Property
ORDER BY pricepernight DESC;

-- Booking Table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE user_id = 'sample-user-id'
  AND status = 'confirmed'
ORDER BY created_at DESC;

EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = 'sample-property-id'
  AND (start_date, end_date) OVERLAPS (DATE '2025-07-01', DATE '2025-07-10');

-- Review Table
EXPLAIN ANALYZE
SELECT * FROM Review
WHERE property_id = 'sample-property-id'
ORDER BY created_at DESC;

-- Message Table
EXPLAIN ANALYZE
SELECT * FROM Message
WHERE sender_id = 'sample-user-id'
ORDER BY sent_at DESC;


-- ========================
-- INDEX CREATION
-- ========================
-- Additional indexes to improve query performance for Airbnb Clone API

-- User Table: already has index on email, good for login/auth lookups

-- Property Table
-- Queries frequently filter by location or order by price
CREATE INDEX IF NOT EXISTS idx_property_location ON Property (location);
CREATE INDEX IF NOT EXISTS idx_property_price ON Property (pricepernight);

-- Booking Table
-- Common filters include date range and status
CREATE INDEX IF NOT EXISTS idx_booking_dates ON Booking (start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_booking_status ON Booking (status);
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON Booking (created_at);

-- Review Table
-- Often sorted or filtered by created_at for display
CREATE INDEX IF NOT EXISTS idx_review_created_at ON Review (created_at);

-- Message Table
-- Useful to order messages by sent time between users
CREATE INDEX IF NOT EXISTS idx_message_sent_at ON Message (sent_at);


-- ========================
-- PERFORMANCE BENCHMARKING (AFTER INDEXES)
-- ========================
-- Re-run the same EXPLAIN ANALYZE queries to measure performance gains.

-- Property Table
EXPLAIN ANALYZE
SELECT * FROM Property
WHERE location = 'Nairobi';

EXPLAIN ANALYZE
SELECT * FROM Property
ORDER BY pricepernight DESC;

-- Booking Table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE user_id = 'sample-user-id'
  AND status = 'confirmed'
ORDER BY created_at DESC;

EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = 'sample-property-id'
  AND (start_date, end_date) OVERLAPS (DATE '2025-07-01', DATE '2025-07-10');

-- Review Table
EXPLAIN ANALYZE
SELECT * FROM Review
WHERE property_id = 'sample-property-id'
ORDER BY created_at DESC;

-- Message Table
EXPLAIN ANALYZE
SELECT * FROM Message
WHERE sender_id = 'sample-user-id'
ORDER BY sent_at DESC;
