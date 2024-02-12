USE LittleLemonDB;

/* Task 1 */
INSERT INTO Customers (CustomerID, CustomerName) VAlues
	(1, "Jack Reacher"),
    (2, "Jane Doe"),
    (3, "Bonnie Clyde");

INSERT INTO Bookings (BookingID, Date, TableNumber, CustomerID) VALUES
	(1, '2022-10-10', 5, 1),
    (2, '2022-11-12', 3, 3),
    (3, '2022-10-11', 2, 2),
    (4, '2022-10-13', 2, 1);
    
SELECT * FROM Bookings;

/* Task 2 */
DELIMITER //
CREATE PROCEDURE CheckBooking (IN bookingDate DATE, IN tableNo INT) 
	BEGIN
		DECLARE booked BOOLEAN;
        
        SELECT EXISTS (
			SELECT BookingID 
            FROM Bookings
            WHERE Date = bookingDate
				AND TableNumber = tableNo
			) INTO booked;
		
        IF booked THEN
			SELECT CONCAT("Table ", tableNo, " is booked") AS "Booking Status";
		ELSE
			SELECT CONCAT("Table ", tableNo, " is available") AS "Booking Status";
		END IF;
	END //
DELIMITER ;

CALL CheckBooking ('2022-11-12', 3);

/* Task 3 */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS AddValidBooking(IN bookingDate DATE, IN tableNo INT)
	BEGIN
		DECLARE booked BOOLEAN;
		START TRANSACTION;
            SELECT EXISTS (
				SELECT BookingID 
				FROM Bookings
				WHERE Date = bookingDate
					AND TableNumber = tableNo
				) INTO booked;
        
			INSERT INTO Bookings (Date, TableNumber) VALUES 
				(bookingDate, tableNo);
			
            IF booked THEN
				SELECT CONCAT("Table ", tableNo, " is open - booking added") AS "Booking Status";
				COMMIT;
			ELSE 
				SELECT CONCAT("Table ", tableNo, " is already booked - booking cancelled") AS "Booking Status";
				ROLLBACK;
			END IF;
    END //
DELIMITER ;
    
CALL AddValidBooking("2022-12-17", 6);

/* Task 4 */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS AddBooking (IN id INT, custID INT, IN bookingDate DATE, IN tableNo INT)
	BEGIN
		INSERT INTO Customers (CustomerID) VALUES 
			(custID);
		INSERT INTO bookings (BookingID, Date, TableNumber, CustomerID) VALUES
			(id, bookingDate, tableNo, custID);
		SELECT CONCAT("New Booking Added") AS "Confirmation";
    END //
DELIMITER ;

CALL AddBooking(9, 4, "2022-12-30", 3);

/* Task 5 */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS UpdateBooking(IN id INT, IN bookingDate DATE)
	BEGIN
		UPDATE Bookings SET Date = bookingDate WHERE BookingID = id;
        SELECT CONCAT("Booking ", id, " updated") AS "Confirmation";
    END //
DELIMITER ;

CALL UpdateBooking(9, "2022-12-17");

/* Task 6 */
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS CancelBooking(IN id INT)
	BEGIN
		DELETE FROM Bookings WHERE BookingID = id;
        SELECT CONCAT("Booking ", id, " cancelled") AS "Confirmation";
    END //
DELIMITER ;

CALL CancelBooking(9);


    
    
    