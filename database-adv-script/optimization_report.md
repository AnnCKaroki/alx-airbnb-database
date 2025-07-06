# Optimization Report

## Initial Query

The original query retrieves all bookings along with user, property, and payment details using multiple JOINs and selects all available fields. While functionally correct, the query includes unnecessary columns that increase the data payload and query execution time.

## Performance Analysis

The `EXPLAIN FORMAT=TRADITIONAL` command was used to analyze the query plan. The following issues were identified:
- Full table scans on large tables (e.g., `bookings`, `users`, `properties`).
- Many columns selected, increasing I/O and memory usage.
- Joins to `payments` table even when not all booking records have payments.

## Refactored Query

The refactored query reduces the number of selected columns, keeping only key fields:
- Booking ID, date range
- User name and email
- Property name
- Payment amount

This simplifies the result set and reduces memory usage. The JOINs were left in place because they are essential for gathering the associated data.

## Result

After indexing key columns (`user_id`, `property_id`, `booking_id`), and trimming down the selected fields, the refactored query shows better execution time, lower cost in the execution plan, and more efficient use of indexes.
