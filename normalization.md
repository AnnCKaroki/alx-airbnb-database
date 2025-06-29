# Database Normalization for ALX Airbnb Database

This document explains the normalization principles applied to the database design for the ALX Airbnb-like application, confirming that the current schema adheres to the Third Normal Form (3NF).

## Understanding Normalization

Database normalization is a process used to organize a database into tables and columns, minimizing data redundancy and improving data integrity. It typically involves breaking down large tables into smaller, less redundant tables and defining relationships between them. The most common normal forms are 1NF, 2NF, and 3NF.

### First Normal Form (1NF)

A table is in 1NF if:
1.  Each column contains atomic (indivisible) values. There are no repeating groups or arrays within a single column.
2.  Each row is unique, identified by a primary key.

**Application to Current Schema:**
Our database schema, as defined in the ERD, satisfies 1NF. All attributes (e.g., `first_name`, `pricepernight`, `start_date`) are atomic, and each table has a clearly defined single-column primary key (e.g., `user_id`, `property_id`, `booking_id`), ensuring unique identification for each record.

### Second Normal Form (2NF)

A table is in 2NF if:
1.  It is in 1NF.
2.  All non-key attributes are fully functionally dependent on the *entire* primary key. This means no non-key attribute depends only on a part of a composite primary key.

**Application to Current Schema:**
Our database schema satisfies 2NF. All primary keys defined are single-column keys (not composite keys). Therefore, partial dependencies are not possible, and all non-key attributes are inherently fully dependent on their respective table's primary key.

### Third Normal Form (3NF)

A table is in 3NF if:
1.  It is in 2NF.
2.  There are no transitive dependencies. This means no non-key attribute is dependent on another non-key attribute. In simpler terms, "every non-key attribute must depend on the key, the whole key, and nothing but the key."

**Application to Current Schema:**
Our database schema satisfies 3NF. Upon review of each entity and its attributes:
* **User:** Attributes like `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, and `created_at` directly describe and depend only on the `user_id` (Primary Key).
* **Property:** Attributes such as `name`, `description`, `location`, `pricepernight`, `created_at`, and `updated_at` directly describe and depend only on the `property_id` (Primary Key). `host_id` is a foreign key, relating the property to a user, but does not introduce a transitive dependency for other `Property` attributes.
* **Booking:** Attributes like `start_date`, `end_date`, `total_price`, `status`, and `created_at` directly describe and depend only on the `booking_id` (Primary Key). `property_id` and `user_id` are foreign keys.
* **Payment:** Attributes like `amount`, `payment_date`, and `payment_method` directly describe and depend only on the `payment_id` (Primary Key). `booking_id` is a foreign key with a unique constraint, linking it directly to the `Booking` it's for.
* **Review:** Attributes such as `rating`, `comment`, and `created_at` directly describe and depend only on the `review_id` (Primary Key). `property_id`, `user_id`, and `booking_id` (which is unique) are foreign keys.
* **Message:** Attributes like `message_body` and `sent_at` directly describe and depend only on the `message_id` (Primary Key). `sender_id` and `recipient_id` are foreign keys.

No non-key attribute in any table is functionally dependent on another non-key attribute. Each attribute serves to describe the primary key of its respective table.

## Conclusion

Based on the detailed review, the current database design for the ALX Airbnb-like application successfully adheres to the Third Normal Form (3NF), minimizing data redundancy and maintaining high data integrity.
