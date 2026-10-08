CREATE DATABASE hotel_management;
USE hotel_management;
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);
INSERT INTO guests (name, email, phone)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210'),
('Priya Patil', 'priya@gmail.com', '9876543211'),
('Amit Verma', 'amit@gmail.com', '9876543212'),
('Sneha Joshi', 'sneha@gmail.com', '9876543213'),
('Rohan Mehta', 'rohan@gmail.com', '9876543214');
SELECT * FROM guests;

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number INT,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    status VARCHAR(20)
);
INSERT INTO rooms (room_number, room_type, price_per_night, status)
VALUES
(101, 'Single', 1800.00, 'Available'),
(102, 'Double', 2500.00, 'Occupied'),
(103, 'Double', 2500.00, 'Available'),
(104, 'Suite', 4500.00, 'Available'),
(105, 'Single', 1800.00, 'Occupied'),
(201, 'Double', 2800.00, 'Available'),
(202, 'Suite', 5000.00, 'Occupied'),
(203, 'Single', 2000.00, 'Available');
SELECT * FROM rooms;

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);
INSERT INTO bookings (guest_id, room_id, check_in, check_out, booking_status)
VALUES
(1, 2, '2026-10-10', '2026-10-12', 'Confirmed'),
(2, 1, '2026-10-11', '2026-10-14', 'Confirmed'),
(3, 3, '2026-10-12', '2026-10-13', 'Completed'),
(4, 4, '2026-10-15', '2026-10-18', 'Confirmed'),
(5, 6, '2026-10-16', '2026-10-20', 'Confirmed'),
(1, 5, '2026-09-20', '2026-09-22', 'Completed'),
(2, 8, '2026-09-25', '2026-09-27', 'Cancelled');
SELECT * FROM bookings;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
INSERT INTO payments (booking_id, amount, payment_date, payment_status)
VALUES
(1, 5000.00, '2026-10-08', 'Paid'),
(2, 7500.00, '2026-10-09', 'Paid'),
(3, 2500.00, '2026-10-10', 'Paid'),
(4, 13500.00, '2026-10-12', 'Pending'),
(5, 11200.00, '2026-10-13', 'Paid'),
(6, 3600.00, '2026-09-20', 'Paid'),
(7, 4000.00, '2026-09-25', 'Refunded');
SELECT * FROM payments;

SELECT * 
FROM rooms
WHERE status = 'Available';

SELECT *
FROM rooms
WHERE status = 'Available'
ORDER BY price_per_night DESC;

SELECT COUNT(*) AS total_rooms
FROM rooms;

SELECT SUM(amount) AS total_payment
FROM payments
WHERE payment_status = 'Paid';

SELECT room_type, COUNT(*) AS total_rooms
FROM rooms
GROUP BY room_type;

SELECT payment_status, SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status;

SELECT 
    guests.name,
    bookings.booking_id,
    bookings.check_in,
    bookings.check_out,
    bookings.booking_status
FROM guests
JOIN bookings
ON guests.guest_id = bookings.guest_id;

SELECT
    guests.name,
    bookings.booking_id,
    rooms.room_number,
    rooms.room_type,
    bookings.check_in,
    bookings.check_out,
    bookings.booking_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id;

SELECT
    guests.name,
    rooms.room_number,
    rooms.room_type,
    bookings.check_in,
    bookings.check_out
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
WHERE bookings.booking_status = 'Confirmed';

SELECT
    guests.name,
    bookings.booking_id,
    payments.amount,
    payments.payment_status
FROM payments
JOIN bookings
    ON payments.booking_id = bookings.booking_id
JOIN guests
    ON bookings.guest_id = guests.guest_id;
    
SET SQL_SAFE_UPDATES = 0;
    
UPDATE rooms
SET status = 'Occupied'
WHERE room_number = 101; 

SELECT *
FROM rooms
WHERE room_number = 101;  

INSERT INTO rooms (room_number, room_type, price_per_night, status)
VALUES (301, 'Single', 1500.00, 'Available');

DELETE FROM rooms
WHERE room_number = 301;

SELECT *
FROM guests
WHERE name LIKE '%a%';

SELECT *
FROM rooms
WHERE price_per_night BETWEEN 2000 AND 4000;

SELECT *
FROM rooms
WHERE room_type IN ('Single', 'Suite');

SELECT *
FROM rooms
WHERE status = 'Available'
AND price_per_night < 3000;

SELECT *
FROM rooms
WHERE room_type = 'Suite'
OR price_per_night > 4000;

SELECT room_type, COUNT(*) AS total_rooms
FROM rooms
GROUP BY room_type
HAVING COUNT(*) >= 2;

SELECT
    room_number,
    room_type,
    price_per_night
FROM rooms
WHERE status = 'Available'
ORDER BY price_per_night ASC;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    rooms.room_number,
    rooms.room_type,
    bookings.check_in,
    bookings.check_out
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
WHERE bookings.booking_status = 'Confirmed';

SELECT
    guests.name AS guest_name,
    bookings.booking_id,
    payments.amount,
    payments.payment_status,
    payments.payment_date
FROM payments
JOIN bookings
    ON payments.booking_id = bookings.booking_id
JOIN guests
    ON bookings.guest_id = guests.guest_id
ORDER BY payments.payment_date;

SELECT
    guests.name AS guest_name,
    bookings.booking_id,
    payments.amount,
    payments.payment_status
FROM payments
JOIN bookings
    ON payments.booking_id = bookings.booking_id
JOIN guests
    ON bookings.guest_id = guests.guest_id
WHERE payments.payment_status = 'Pending';

SELECT
    guests.name AS guest_name,
    bookings.booking_id,
    rooms.room_number,
    bookings.check_in,
    bookings.check_out,
    bookings.booking_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
WHERE bookings.booking_status = 'Cancelled';

SELECT
    SUM(amount) AS total_paid_revenue
FROM payments
WHERE payment_status = 'Paid';

SELECT
    guests.name AS guest_name,
    COUNT(bookings.booking_id) AS total_bookings
FROM guests
JOIN bookings
    ON guests.guest_id = bookings.guest_id
GROUP BY guests.guest_id, guests.name
ORDER BY total_bookings DESC;

SELECT
    rooms.room_number,
    rooms.room_type,
    COUNT(bookings.booking_id) AS total_bookings
FROM rooms
LEFT JOIN bookings
    ON rooms.room_id = bookings.room_id
GROUP BY rooms.room_id, rooms.room_number, rooms.room_type
ORDER BY total_bookings DESC;

SELECT
    guests.name AS guest_name,
    bookings.booking_id,
    bookings.booking_status,
    payments.amount,
    payments.payment_status
FROM payments
JOIN bookings
    ON payments.booking_id = bookings.booking_id
JOIN guests
    ON bookings.guest_id = guests.guest_id
WHERE payments.payment_status = 'Pending';

SELECT
    payment_status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status;

SELECT
    booking_id,
    check_in,
    check_out,
    DATEDIFF(check_out, check_in) AS stay_days
FROM bookings;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    rooms.room_number,
    DATEDIFF(bookings.check_out, bookings.check_in) AS stay_days,
    rooms.price_per_night,
    DATEDIFF(bookings.check_out, bookings.check_in) * rooms.price_per_night AS estimated_amount
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id;
    
SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    DATEDIFF(bookings.check_out, bookings.check_in) AS stay_days,
    rooms.price_per_night,
    DATEDIFF(bookings.check_out, bookings.check_in) * rooms.price_per_night AS expected_amount,
    payments.amount AS paid_amount,
    payments.amount -
    (DATEDIFF(bookings.check_out, bookings.check_in) * rooms.price_per_night) AS difference
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
JOIN payments
    ON bookings.booking_id = payments.booking_id;    

SELECT
    room_id,
    room_number,
    room_type,
    status
FROM rooms
WHERE status = 'Available'
ORDER BY room_number;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    bookings.booking_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
LEFT JOIN payments
    ON bookings.booking_id = payments.booking_id
WHERE payments.payment_id IS NULL;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    rooms.room_number,
    rooms.room_type,
    bookings.check_in,
    bookings.check_out,
    DATEDIFF(bookings.check_out, bookings.check_in) AS stay_days,
    rooms.price_per_night,
    DATEDIFF(bookings.check_out, bookings.check_in) * rooms.price_per_night AS expected_amount,
    payments.amount AS paid_amount,
    payments.payment_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
LEFT JOIN payments
    ON bookings.booking_id = payments.booking_id
ORDER BY bookings.booking_id;


SHOW TABLES;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    rooms.room_number,
    rooms.room_type,
    payments.amount,
    payments.payment_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
JOIN rooms
    ON bookings.room_id = rooms.room_id
LEFT JOIN payments
    ON bookings.booking_id = payments.booking_id;

SELECT
    bookings.booking_id,
    guests.name AS guest_name,
    bookings.booking_status,
    payments.payment_status
FROM bookings
JOIN guests
    ON bookings.guest_id = guests.guest_id
LEFT JOIN payments
    ON bookings.booking_id = payments.booking_id
ORDER BY bookings.booking_id;

SELECT
    rooms.room_number,
    bookings.booking_id,
    bookings.check_in,
    bookings.check_out,
    bookings.booking_status
FROM rooms
JOIN bookings
    ON rooms.room_id = bookings.room_id
WHERE bookings.booking_status = 'Confirmed'
ORDER BY rooms.room_number, bookings.check_in;

SELECT
    payment_status,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;
