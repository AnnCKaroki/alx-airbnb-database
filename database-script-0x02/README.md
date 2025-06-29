# Database Seeding with Sample Data (DML) for ALX Airbnb-like Application

This directory contains the SQL Data Manipulation Language (DML) script (`seed.sql`) for populating the database schema with realistic sample data, specifically designed for **Microsoft SQL Server**.

## `seed.sql`

This file includes `INSERT` statements for all tables in the database schema: `Users`, `Properties`, `Bookings`, `Payments`, `Reviews`, and `Messages`. The sample data is designed to reflect real-world usage scenarios within an Airbnb-like environment.

**Key Aspects of Sample Data:**
* **UUID Generation:** Uses SQL Server's `NEWID()` function to generate `UNIQUEIDENTIFIER` values for primary keys, ensuring uniqueness for each record.
* **Foreign Key Compliance:** Data is inserted in an order that respects foreign key constraints (e.g., users before properties, properties before bookings). Foreign key values are retrieved using subqueries (`SELECT ID FROM Table WHERE condition`) to ensure correct linking.
* **Realistic Scenarios:** Includes multiple users (hosts and guests), various property types, confirmed and pending bookings, associated payments, reviews, and messages.
* **`NVARCHAR` Literals:** String literals are prefixed with `N` (e.g., `N'Alice'`) to ensure Unicode compatibility in SQL Server.
* **Timestamp Defaults:** `GETDATE()` is used for `created_at`, `updated_at`, `payment_date`, `sent_at`, and `review_date` fields, aligning with the `DEFAULT GETDATE()` in the `schema.sql`.

## How to Use `seed.sql` in Microsoft SQL Server (SSMS/Azure Data Studio):

1.  **Ensure Schema is Created:** Before running this script, make sure your database schema has been successfully created by executing the `schema.sql` script (from `database-script-0x01/`) in your SQL Server database.
2.  **Open SQL Server Management Studio (SSMS) or Azure Data Studio.**
3.  **Connect to Your SQL Server Instance.**
4.  **Open a New Query Window.**
5.  **Select Your Database:** In the dropdown menu, ensure your `AirbnbDB` database (or the name you chose) is selected.
6.  **Load and Execute `seed.sql`:**
    * Go to `File > Open > File...` and navigate to your `alx-airbnb-database/database-script-0x02/seed.sql` file. Select and open it.
    * Click the **`Execute`** button (or press `F5`).
    * You should see "Commands completed successfully" in the Messages tab if there are no errors.
7.  **Verify Data:**
    * In Object Explorer, expand your database -> `Tables`.
    * Right-click on any table (e.g., `dbo.Users`) and select `Select Top 1000 Rows` to confirm the sample data has been inserted.
