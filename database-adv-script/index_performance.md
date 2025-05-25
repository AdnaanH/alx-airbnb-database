-- Additional indexes to improve query performance for Airbnb Clone API

-- User Table: already has index on email, good for login/auth lookups

-- Property Table
-- Queries frequently filter by location or order by price
CREATE INDEX idx_property_location ON Property (location);
CREATE INDEX idx_property_price ON Property (pricepernight);

-- Booking Table
-- Common filters include date range and status
CREATE INDEX idx_booking_dates ON Booking (start_date, end_date);
CREATE INDEX idx_booking_status ON Booking (status);
CREATE INDEX idx_booking_created_at ON Booking (created_at);

-- Review Table
-- Often sorted or filtered by created_at for display
CREATE INDEX idx_review_created_at ON Review (created_at);

-- Message Table
-- Useful to order messages by sent time between users
CREATE INDEX idx_message_sent_at ON Message (sent_at);
