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

## 📌 Subqueries in SQL

Subqueries are queries nested inside another SQL query. They help break down complex logic into smaller, manageable parts.

### 🔄 Types of Subqueries

1. **Non-Correlated Subquery**
   - Executes independently of the outer query.
   - Example:
     ```sql
     SELECT name
     FROM Properties
     WHERE property_id IN (
         SELECT property_id
         FROM Reviews
         GROUP BY property_id
         HAVING AVG(rating) > 4.0
     );
     ```

2. **Correlated Subquery**
   - Depends on the outer query for its values.
   - Runs once for every row considered by the outer query.
   - Example:
     ```sql
     SELECT first_name, last_name
     FROM Users u
     WHERE (
         SELECT COUNT(*)
         FROM Bookings b
         WHERE b.user_id = u.user_id
     ) > 3;
     ```


