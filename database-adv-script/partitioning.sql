-- Step 1: Drop original Booking table (backup data before this step in real environments)
DROP TABLE IF EXISTS Booking CASCADE;

-- Step 2: Create partitioned parent table
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Step 3: Create child partitions (e.g., per quarter)
CREATE TABLE Booking_2023_q1 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE Booking_2023_q2 PARTITION OF Booking
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE Booking_2023_q3 PARTITION OF Booking
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE Booking_2023_q4 PARTITION OF Booking
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

-- You can continue adding future partitions similarly...

-- Step 4: Recreate foreign key constraints on child tables
ALTER TABLE Booking_2023_q1 ADD FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE;
ALTER TABLE Booking_2023_q1 ADD FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;

ALTER TABLE Booking_2023_q2 ADD FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE;
ALTER TABLE Booking_2023_q2 ADD FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;

-- ... repeat for each partition

-- Step 5: Add indexes (per partition)
CREATE INDEX idx_booking_2023_q1_user_id ON Booking_2023_q1 (user_id);
CREATE INDEX idx_booking_2023_q2_user_id ON Booking_2023_q2 (user_id);

-- Example query to test performance
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE start_date BETWEEN '2023-04-10' AND '2023-04-15';
