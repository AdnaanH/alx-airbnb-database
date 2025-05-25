# Airbnb Clone API - Booking Table Partitioning

## Objective

Optimize the performance of queries on a large `Booking` table by implementing **range partitioning** based on the `start_date` column.

## Why Partition?

The `Booking` table is expected to grow large over time, especially with regular user traffic. Partitioning improves:
- **Query performance** for date-filtered queries.
- **Maintenance operations** like archiving and deleting historical data.

## Partitioning Strategy

We implemented **range partitioning** using quarterly boundaries (Q1–Q4 2023). Each child table handles a specific time range of booking records.

## SQL Changes

- The original `Booking` table was replaced with a partitioned version.
- Four partitions were created: one for each quarter of 2023.
- Foreign keys and indexes were recreated for each child table.

## Performance Testing

We ran this query using `EXPLAIN ANALYZE`:

```sql
SELECT *
FROM Booking
WHERE start_date BETWEEN '2023-04-10' AND '2023-04-15';
Before Partitioning
The planner scanned the entire Booking table, resulting in high sequential scan cost.

After Partitioning
The planner pruned partitions and accessed only the relevant one (e.g., Booking_2023_q2). This reduced:

Planning and execution time

Number of rows scanned

Overall query cost

Conclusion
Partitioning by start_date provides significant performance improvements for time-bounded queries. It also improves scalability and manageability of the database.