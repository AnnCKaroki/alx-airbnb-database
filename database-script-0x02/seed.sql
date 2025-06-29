-- SQL Server DML for ALX Airbnb Database - Sample Data

SET NOCOUNT ON;   -- Suppress "(n rows affected)" messages for cleaner output
SET XACT_ABORT ON; -- Abort transaction and rollback on any statement error

BEGIN TRY
    BEGIN TRANSACTION;

    PRINT '--- Starting Database Seeding ---';

    -- Step 1: Attempt to clear existing data in correct dependency order
    PRINT 'Attempting to clear existing data from tables...';
    DELETE FROM Payments;
    DELETE FROM Reviews;
    DELETE FROM Messages;
    DELETE FROM Bookings;
    DELETE FROM Properties;
    DELETE FROM Users;

    -- Step 2: Verify if tables are empty after DELETEs
    PRINT 'Verifying row counts after DELETE operations:';
    SELECT COUNT(*) AS UsersCountAfterDelete FROM Users;
    SELECT COUNT(*) AS PropertiesCountAfterDelete FROM Properties;
    SELECT COUNT(*) AS BookingsCountAfterDelete FROM Bookings;
    SELECT COUNT(*) AS PaymentsCountAfterDelete FROM Payments;
    SELECT COUNT(*) AS ReviewsCountAfterDelete FROM Reviews;
    SELECT COUNT(*) AS MessagesCountAfterDelete FROM Messages;

    -- If any of the above counts are > 0, the DELETEs failed to clear data.
    -- The transaction will proceed, but subsequent INSERTS will likely fail.

    -- Declare variables for new GUIDs (must be in the same batch as INSERTS)
    DECLARE @userAlice UNIQUEIDENTIFIER = NEWID();
    DECLARE @userBob UNIQUEIDENTIFIER = NEWID();
    DECLARE @userCharlie UNIQUEIDENTIFIER = NEWID();
    DECLARE @userDiana UNIQUEIDENTIFIER = NEWID();

    DECLARE @propApt UNIQUEIDENTIFIER = NEWID();
    DECLARE @propHouse UNIQUEIDENTIFIER = NEWID();
    DECLARE @propCabin UNIQUEIDENTIFIER = NEWID();

    DECLARE @booking1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @booking2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @booking3 UNIQUEIDENTIFIER = NEWID();

    DECLARE @payment1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @payment2 UNIQUEIDENTIFIER = NEWID();

    DECLARE @review1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @review2 UNIQUEIDENTIFIER = NEWID();

    DECLARE @msg1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @msg2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @msg3 UNIQUEIDENTIFIER = NEWID();

    -- Step 3: Insert Sample Users
    PRINT 'Inserting sample users...';
    INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    (@userAlice, N'Alice', N'Smith', N'alice.smith@example.com', N'123_alice_hash', N'111-222-3333', N'host', GETDATE());
    INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    (@userBob, N'Bob', N'Johnson', N'bob.j@example.com', N'456_bob_hash', N'444-555-6666', N'host', GETDATE());
    INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    (@userCharlie, N'Charlie', N'Brown', N'charlie.b@example.com', N'789_charlie_hash', N'777-888-9999', N'guest', GETDATE());
    INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    (@userDiana, N'Diana', N'Prince', N'diana.p@example.com', N'012_diana_hash', N'123-456-7890', N'guest', GETDATE());
    PRINT 'Users insertion attempted.';

    -- Step 4: Insert Sample Properties
    PRINT 'Inserting sample properties...';
    INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
    (@propApt, @userAlice, N'Cozy Downtown Apartment', N'A charming apartment in the heart of the city.', N'123 Main St, New York, NY', 150.00, GETDATE(), GETDATE());
    INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
    (@propHouse, @userBob, N'Spacious Beach House', N'Enjoy the sun and sand in this beautiful beach house.', N'456 Ocean Blvd, Miami Beach, FL', 300.00, GETDATE(), GETDATE());
    INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
    (@propCabin, @userAlice, N'Mountain View Cabin', N'Rustic cabin with breathtaking mountain views.', N'789 Pine Rd, Aspen, CO', 200.00, GETDATE(), GETDATE());
    PRINT 'Properties insertion attempted.';

    -- Step 5: Insert Sample Bookings
    PRINT 'Inserting sample bookings...';
    INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
    (@booking1, @propApt, @userCharlie, '2025-07-10', '2025-07-15', 750.00, N'confirmed', GETDATE());
    INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
    (@booking2, @propHouse, @userDiana, '2025-08-01', '2025-08-07', 1800.00, N'confirmed', GETDATE());
    INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
    (@booking3, @propCabin, @userCharlie, '2025-09-01', '2025-09-03', 400.00, N'pending', GETDATE());
    PRINT 'Bookings insertion attempted.';

    -- Step 6: Insert Sample Payments
    PRINT 'Inserting sample payments...';
    INSERT INTO Payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
    (@payment1, @booking1, 750.00, GETDATE(), N'credit_card');
    INSERT INTO Payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
    (@payment2, @booking2, 1800.00, GETDATE(), N'paypal');
    PRINT 'Payments insertion attempted.';

    -- Step 7: Insert Sample Reviews
    PRINT 'Inserting sample reviews...';
    INSERT INTO Reviews (review_id, property_id, user_id, booking_id, rating, comment, created_at) VALUES
    (@review1, @propApt, @userCharlie, @booking1, 5, N'Absolutely loved the place! Very clean and centrally located.', GETDATE());
    INSERT INTO Reviews (review_id, property_id, user_id, booking_id, rating, comment, created_at) VALUES
    (@review2, @propHouse, @userDiana, @booking2, 4, N'Great beach house, slightly noisy at night but overall good.', GETDATE());
    PRINT 'Reviews insertion attempted.';

    -- Step 8: Insert Sample Messages
    PRINT 'Inserting sample messages...';
    INSERT INTO Messages (message_id, sender_id, recipient_id, message_body, sent_at, booking_id) VALUES
    (@msg1, @userCharlie, @userAlice, N'Hi Alice, Looking forward to my stay! Could you confirm check-in time?', GETDATE(), @booking1);
    INSERT INTO Messages (message_id, sender_id, recipient_id, message_body, sent_at, booking_id) VALUES
    (@msg2, @userAlice, @userCharlie, N'Hi Charlie, Check-in is at 3 PM. Let me know if you need anything else!', GETDATE(), @booking1);
    INSERT INTO Messages (message_id, sender_id, recipient_id, message_body, sent_at, booking_id) VALUES
    (@msg3, @userDiana, @userBob, N'Is the beach house pet-friendly?', GETDATE(), NULL);
    PRINT 'Messages insertion attempted.';

    -- If we reach here without XACT_ABORT rolling back, commit the transaction
    COMMIT TRANSACTION;
    PRINT '--- Database seeding completed successfully! ---';

END TRY
BEGIN CATCH
    -- If an error occurred, roll back the transaction
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT '--- Error seeding database! ---';
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    THROW; -- Re-throw the error for SSMS/Azure Data Studio to catch
END CATCH;
GO
