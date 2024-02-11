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

    
    
    
    
    
    
    
    
    
    