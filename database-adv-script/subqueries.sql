-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT name
FROM Properties
WHERE property_id IN (
    SELECT property_id
    FROM Reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT first_name, last_name
FROM Users u
WHERE (
    SELECT COUNT(*)
    FROM Bookings b
    WHERE b.user_id = u.user_id
) > 3;
