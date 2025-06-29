-- SQL Server DDL for ALX Airbnb Database Schema

-- Drop tables in dependency order for clean re-creation
IF OBJECT_ID('Payments', 'U') IS NOT NULL DROP TABLE Payments;
IF OBJECT_ID('Reviews', 'U') IS NOT NULL DROP TABLE Reviews;
IF OBJECT_ID('Messages', 'U') IS NOT NULL DROP TABLE Messages;
IF OBJECT_ID('Bookings', 'U') IS NOT NULL DROP TABLE Bookings;
IF OBJECT_ID('Properties', 'U') IS NOT NULL DROP TABLE Properties;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
GO

-- Users Table
CREATE TABLE Users (
    user_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20) UNIQUE,
    role NVARCHAR(10) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT CK_User_Role CHECK (role IN ('guest', 'host', 'admin'))
);
GO

-- Properties Table
CREATE TABLE Properties (
    property_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    host_id UNIQUEIDENTIFIER NOT NULL, -- FK to Users
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    location NVARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(), -- Requires trigger for ON UPDATE CURRENT_TIMESTAMP
    -- *** IMPORTANT CHANGE HERE: Changed to ON DELETE NO ACTION ***
    CONSTRAINT FK_Properties_Host FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE NO ACTION
);
GO

-- Bookings Table
CREATE TABLE Bookings (
    booking_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    property_id UNIQUEIDENTIFIER NOT NULL, -- FK to Properties
    user_id UNIQUEIDENTIFIER NOT NULL,     -- FK to Users (guest)
    start_date DATETIME2 NOT NULL,
    end_date DATETIME2 NOT NULL,
    total_price DECIMAL(12, 2) NOT NULL,
    status NVARCHAR(20) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_Bookings_Property FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,
    CONSTRAINT FK_Bookings_User FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    CONSTRAINT CK_Booking_Status CHECK (status IN ('pending', 'confirmed', 'canceled'))
);
GO

-- Payments Table
CREATE TABLE Payments (
    payment_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    booking_id UNIQUEIDENTIFIER UNIQUE NOT NULL, -- FK to Bookings (1-to-1)
    amount DECIMAL(12, 2) NOT NULL,
    payment_date DATETIME2 DEFAULT GETDATE(),
    payment_method NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payments_Booking FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    CONSTRAINT CK_Payment_Method CHECK (payment_method IN ('credit_card', 'paypal', 'stripe'))
);
GO

-- Reviews Table
CREATE TABLE Reviews (
    review_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    property_id UNIQUEIDENTIFIER NOT NULL, -- FK to Properties
    user_id UNIQUEIDENTIFIER NOT NULL,     -- FK to Users (reviewer)
    booking_id UNIQUEIDENTIFIER UNIQUE NOT NULL, -- FK to Bookings (1-to-1)
    rating INT NOT NULL,
    comment NVARCHAR(MAX) NOT NULL,
    created_at DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_Reviews_Property FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE NO ACTION,
    CONSTRAINT FK_Reviews_User FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    CONSTRAINT FK_Reviews_Booking FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    CONSTRAINT CK_Review_Rating CHECK (rating >= 1 AND rating <= 5)
);
GO

-- Messages Table
CREATE TABLE Messages (
    message_id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    sender_id UNIQUEIDENTIFIER NOT NULL,
    recipient_id UNIQUEIDENTIFIER NOT NULL,
    message_body NVARCHAR(MAX) NOT NULL,
    sent_at DATETIME2 DEFAULT GETDATE(),
    booking_id UNIQUEIDENTIFIER NULL, -- Explicitly nullable
    CONSTRAINT FK_Messages_Sender FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    CONSTRAINT FK_Messages_Recipient FOREIGN KEY (recipient_id) REFERENCES Users(user_id) ON DELETE NO ACTION
);
GO

-- Add FK_Messages_Booking constraint using ALTER TABLE after all tables are created
ALTER TABLE Messages
ADD CONSTRAINT FK_Messages_Booking FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE SET NULL;
GO
