-- =============================================
-- 1. Initial Complex Query (Unoptimized with WHERE)
-- =============================================

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed'
  AND u.role = 'guest'
  AND p.location = 'Nairobi';


-- =============================================
-- 2. Refactored Query (Optimized)
-- =============================================
-- Optimization Techniques:
-- - SELECT only necessary columns.
-- - Avoid joining unused tables or unused columns.
-- - Payment is LEFT JOINed, so filter nulls only when needed.

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    pay.amount
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id;
