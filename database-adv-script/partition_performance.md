# Partitioning Performance Report

## Objective

Optimize query performance on the `Bookings` table by implementing **partitioning** based on the `start_date` column.

## Approach

1. **Dropped and recreated** the `Bookings` table without foreign key constraints.
2. Applied **RANGE partitioning** using the **YEAR of `start_date`**.
3. Defined multiple partitions from `2019` to `2024` and a `pmax` partition for future values.
4. Used `EXPLAIN ANALYZE` to test performance on a filtered query.

## Partitioning Strategy

```sql
CREATE TABLE bookings (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
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

