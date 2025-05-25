-- 1. Query to fetch bookings with user, property, and payment data
-- Analyze original query performance
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_method
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL '30 days'
  AND b.status = 'confirmed';

-- Observations:
-- Slow execution due to missing composite indexes on commonly filtered columns.

-- 2. Optimization: Add multi-column indexes
CREATE INDEX idx_booking_status_start_date ON Booking (status, start_date);
CREATE INDEX idx_payment_booking_id_method ON Payment (booking_id, payment_method);

-- 3. Re-analyze after adding indexes
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.payment_method
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL '30 days'
  AND b.status = 'confirmed';

-- 4. Additional suggestion: Index on Review table if rating-based filtering is common
CREATE INDEX idx_review_rating_created ON Review (rating, created_at);
