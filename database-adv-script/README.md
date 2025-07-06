## Sample SQL Queries

These are example queries demonstrating how to interact with the ALX Listing App database using different types of SQL joins:

1. **INNER JOIN**
   Retrieve all bookings and the respective users who made those bookings:
   ```sql
   SELECT Users.first_name, Users.last_name, Bookings.booking_id
   FROM Bookings
   INNER JOIN Users ON Bookings.user_id = Users.user_id
   ```

2. **LEFT JOIN**
Retrieve all properties and their reviews, including properties that have no reviews:
```sql
SELECT Properties.name, Reviews.comment
FROM Properties
LEFT JOIN Reviews ON Properties.property_id = Reviews.property_id
```

3. **FULL OUTER JOIN**
Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user:
```sql
SELECT Users.first_name, Users.last_name, Bookings.booking_id
FROM Bookings
FULL OUTER JOIN Users ON Bookings.user_id = Users.user_id
ORDER BY Bookings.booking_id;
```
