-- User Table
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON "User" (email);

-- Property Table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_property_host_id ON Property (host_id);

-- Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_booking_property_id ON Booking (property_id);
CREATE INDEX idx_booking_user_id ON Booking (user_id);

-- Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL REFERENCES Booking(booking_id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe'))
);

CREATE INDEX idx_payment_booking_id ON Payment (booking_id);

-- Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_review_property_id ON Review (property_id);
CREATE INDEX idx_review_user_id ON Review (user_id);

-- Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    recipient_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_sender_id ON Message (sender_id);
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);
