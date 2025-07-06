# Performance Monitoring

## Frequently used queries

### Query 1: Get all bookings for a specific user
```mysql
SELECT * FROM bookings WHERE user_id = 'some-user-id';
```

### Query 2: Get average rating per property
```mysql
SELECT property_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY property_id;
```

### Query 3: Fetch confirmed bookings for a recent date range
```mysql
SELECT *
FROM bookings
WHERE status = 'confirmed'
  AND start_date BETWEEN '2025-01-01' AND '2025-06-10';
```

## Indexes
```mysql
-- For user-based lookup
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- For status and date-range filtering
CREATE INDEX idx_bookings_status_start ON bookings(status, start_date);

-- For group-by rating aggregation
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

```
