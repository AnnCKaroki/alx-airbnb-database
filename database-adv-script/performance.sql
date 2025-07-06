-- initial query
-- retrieves all bookings,
-- Associated user details (users)
-- Associated property details (properties)
-- Associated payment details (payments)


-- analyze performance
EXPLAIN FORMAT=TRADITIONAL
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,

    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method

FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;



-- refactored
EXPLAIN FORMAT=TRADITIONAL
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.email,
    p.name AS property_name,
    pay.amount AS payment_amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;
