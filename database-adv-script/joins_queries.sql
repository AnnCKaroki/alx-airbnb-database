-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT Users.first_name,Users.second_name,Bookings.booking_id
FROM Bookings
INNER JOIN Users ON Bookings.user_id = Users.user_id

-- Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT Properties.name,Reviews.comment
FROM Properties
LEFT JOIN Reviews ON Properties.property_id = Reviews.property_id

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT Users.first_name, Users.last_name, Bookings.booking_id
FROM Bookings
FULL OUTER JOIN Users ON Bookings.user_id = Users.user_id
