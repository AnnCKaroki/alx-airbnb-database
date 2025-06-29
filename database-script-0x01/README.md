# Database Schema (DDL) for ALX Airbnb-like Application

This directory contains the SQL Data Definition Language (DDL) script (`schema.sql`) for creating the database tables and defining their relationships for the ALX Airbnb-like application, specifically designed for **Microsoft SQL Server**.

## `schema.sql`

This file defines the entire database schema, including:
* Table structures with appropriate data types.
* Primary and Foreign Key constraints.
* Default values for timestamp fields.
* `CHECK` constraints for data validation and simulating ENUM types.

## How to Use `schema.sql` in Microsoft SQL Server (SSMS/Azure Data Studio):

1.  **Open SQL Server Management Studio (SSMS) or Azure Data Studio.**
2.  **Connect to Your SQL Server Instance.**
3.  **Create a New Database (Recommended):** Right-click `Databases` -> `New Database...` (e.g., `AirbnbDB`).
4.  **Open a New Query Window.**
5.  **Select Your Database:** Ensure your newly created database (`AirbnbDB`) is selected in the database dropdown.
6.  **Load and Execute `schema.sql`:**
    * Go to `File > Open > File...` and open `schema.sql`.
    * Click the **`Execute`** button (or press `F5`).
7.  **Verify Tables:**
    * In Object Explorer, expand `Databases` -> `[Your Database Name]` -> `Tables`.
    * Confirm all tables (`Users`, `Properties`, `Bookings`, `Payments`, `Reviews`, `Messages`) are listed.
