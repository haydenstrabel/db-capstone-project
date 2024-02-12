USE LittleLemonDB;

/* Task 1 */
CREATE VIEW OrdersView AS
	SELECT OrderID
		, Quantity
        , Cost
	FROM Orders
    WHERE Quantity > 2;

SELECT *
FROM OrdersView;

/* Task 2 */
SELECT Cust.CustomerID
	, Cust.CustomerName
    , Ord.OrderID
    , Ord.Cost
    , Menu.CuisineName
    , Items.CourseName
FROM Orders AS Ord
	INNER JOIN Customers AS Cust
		ON Ord.CustomerID = Cust.CustomerID
	INNER JOIN Menu
		ON Ord.MenuID = Menu.MenuID
	LEFT JOIN MenuItems AS Items
		ON Menu.ItemID = Items.ItemID;

/* Task 3 */
SELECT CuisineName
FROM Menu
WHERE MenuID > ANY(SELECT MenuID 
					FROM Orders 
                    WHERE Quantity > 2);

/* Create Optimized Queries to Manage and Analyze Data */

/* Task 1 */
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
	BEGIN
		SELECT MAX(Quantity) AS "Max Quantity in Order" 
        FROM Orders;
    END //
DELIMITER ;

CALL GetMaxQuantity();

/* Task 2 */

PREPARE GetOrderDetail
FROM 'SELECT OrderID
			, Quantity
			, Cost 
		FROM Orders 
        WHERE OrderID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

/* Task 3 */
DELIMITER //
CREATE PROCEDURE CancelOrder(IN id INT)
	BEGIN
		DECLARE Confirmation VARCHAR(100);
		DELETE FROM Orders WHERE OrderID = id; 
        SET Confirmation = CONCAT("Order ", id, " is cancelled");
        SELECT Confirmation;
    END //
DELIMITER ;

CALL CancelOrder(5);

