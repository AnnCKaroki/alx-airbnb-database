-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT user_id, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT
       Properties.name AS property_name,
       COUNT(Bookings.booking_id) AS total_bookings,
       RANK() OVER(ORDER BY COUNT(Bookings.booking_id) DESC) AS booking_rank
FROM Properties
LEFT JOIN Bookings ON Properties.property_id = Bookings.booking_id
GROUP BY Properties.name, Properties.property_id;
