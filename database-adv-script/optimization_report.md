# Airbnb Clone API - Query Performance Optimization

## Objective

The purpose of this task is to improve the performance of a complex query that retrieves comprehensive booking information along with associated user, property, and payment details.

## Schema Summary

Key tables involved:
- `Booking`: Links users and properties through reservations.
- `User`: Stores user data (guests/hosts).
- `Property`: Listing details for properties.
- `Payment`: Transaction data tied to bookings.

## Performance Optimization Process

### Step 1: Initial Complex Query

An initial query was constructed to fetch all booking details, including full user and property data, along with payment records. This involved:
- Multiple `JOIN`s across four tables.
- A potentially heavy `LEFT JOIN` on `Payment`.

Performance was analyzed using:

```sql
EXPLAIN ANALYZE
SELECT ...
Step 2: Refactoring
The query was optimized to:

Select only needed columns (e.g., no full SELECT *).

Avoid redundant data fetches (e.g., concatenated names instead of pulling full user profile).

Preserve semantics (e.g., retaining LEFT JOIN for Payment which might not exist).

Additional Optimization Notes
Proper indexes were already applied to foreign keys (user_id, property_id, booking_id) as per the schema, which significantly aids JOIN performance.

Future improvements could include partitioning, materialized views, or caching, depending on scale.

How to Use
Run the original query and observe execution time with EXPLAIN ANALYZE.

Run the refactored query and compare results and cost.

Use PostgreSQL's execution plan output to confirm reduced costs (e.g., fewer rows, index usage, etc.).

Example Execution
bash
Copy
Edit
psql -d your_database -f performance.sql
Make sure to replace sample data identifiers with actual values when testing.