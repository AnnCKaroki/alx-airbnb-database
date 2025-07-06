# Identify high-usage columns in your User, Booking, and Property tables
(e.g., columns used in WHERE, JOIN, ORDER BY clauses).

| Table        | Column        | Use Case                                    |
|--------------|---------------|---------------------------------------------|
| `users`      | `user_id`     | JOIN with `bookings`, `messages`, `reviews` |
| `users`      | `email`       | Lookup, authentication (WHERE)              |
| `bookings`   | `user_id`     | JOIN with `users`                           |
| `bookings`   | `property_id` | JOIN with `properties`                      |
| `bookings`   | `created_at`  | ORDER BY / date filtering                   |
| `properties` | `property_id` | JOIN with `bookings`, `reviews`             |
| `properties` | `location`    | Filtering or search                         |
| `reviews`    | `property_id` | GROUP BY in rating queries                  |


## INDEXES CREATED
```mysql
-- database_index.sql

-- USERS
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_users_email ON users(email);

-- BOOKINGS
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- PROPERTIES
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_location ON properties(location);

-- REVIEWS
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

```

## Performance

```mysql
EXPLAIN
SELECT
    u.first_name,
    b.booking_id,
    b.created_at
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.created_at > '2025-01-01'
ORDER BY b.created_at DESC;

```
