-- test partitioning on Bookings table

-- Drop and recreate the bookings table without foreign keys
DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)  -- start_date must be part of PK for partitioning
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2019 VALUES LESS THAN (2020),
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);


EXPLAIN ANALYZE SELECT
    booking_id,
    start_date,
    end_date,
    total_price,
    status
FROM Bookings
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';
