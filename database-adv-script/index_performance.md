# Airbnb Clone API - Indexing Strategy

## Objective

This project aims to optimize query performance in the Airbnb Clone API database by creating indexes on frequently queried columns.

## Schema Overview

The database contains the following key tables:
- `User`: Stores user details (guests, hosts, admins).
- `Property`: Listings created by hosts.
- `Booking`: Reservations made by users.
- `Payment`: Transactions tied to bookings.
- `Review`: User-submitted feedback on properties.
- `Message`: Direct messages between users.

## Why Indexing?

Indexing helps the database engine find rows faster. It is especially effective on columns that appear in:
- `WHERE` clauses
- `JOIN` conditions
- `ORDER BY` clauses
- Aggregations and filters

## Indexing Strategy

The following indexing decisions were made based on anticipated query usage:

### User Table
- ✅ `email`: Already indexed for quick lookup during authentication.

### Property Table
- ✅ `host_id`: Already indexed for JOINs with users.
- ➕ `location`: Often filtered to find properties by region.
- ➕ `pricepernight`: Used to sort properties by cost.

### Booking Table
- ✅ `property_id`, `user_id`: Already indexed for filtering user/property bookings.
- ➕ `(start_date, end_date)`: Optimizes availability checks.
- ➕ `status`: Helps with filtering confirmed/pending bookings.
- ➕ `created_at`: Useful for sorting or filtering by booking creation date.

### Payment Table
- ✅ `booking_id`: Indexed for JOINs with booking details.

### Review Table
- ✅ `property_id`, `user_id`: Indexed for property and user-specific reviews.
- ➕ `created_at`: Helps sort reviews chronologically.

### Message Table
- ✅ `sender_id`, `recipient_id`: Already indexed for filtering conversations.
- ➕ `sent_at`: Helps sort conversations chronologically.

## Measuring Performance

You can use PostgreSQL’s `EXPLAIN ANALYZE` command to compare query plans before and after applying indexes:

```sql
-- Example: Finding bookings for a user
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE user_id = 'some-uuid' AND status = 'confirmed'
ORDER BY created_at DESC;
