-- 2), 3) -------------------------------------------------------
CREATE TABLE Customers
(
	ID SERIAL PRIMARY KEY,
	FirstName CHARACTER VARYING(30),
	LastName CHARACTER VARYING(30),
	Age SMALLINT	
);

CREATE TABLE Products
(
	ID SERIAL PRIMARY KEY,
	Description CHARACTER VARYING(200),
	StockQuantity INTEGER,
	Price NUMERIC(5,2)
);

CREATE TABLE Orders
(
		ID SERIAL PRIMARY KEY,
		CustomerID INTEGER REFERENCES Customers(ID) ON DELETE CASCADE,
		ProductID INTEGER REFERENCES Products(ID) ON DELETE CASCADE,
		Quantity INTEGER		
);

-- 4) -----------------------------------------------------------
INSERT INTO Customers (FirstName, LastName, Age) 
VALUES 
('Anton', 'Antonov', 28),
('Boris', 'Boriskin', 45),
('Victoria', 'Vetlitskaya', 32),
('Galina', 'Gerasimova', 24),
('Dmitry', 'Davydov', 50),
('Evgeny', 'Ezhgurov', 35),
('Zhanna', 'Zhuravleva', 20),
('Irina', 'Ignachkova', 37),
('Klavdiya', 'Kosygina', 50),
('Lyudmilla', 'Lyubimova', 40);

INSERT INTO Products (Description, StockQuantity, Price)
VALUES
('Bread', 20, 35.55),
('Butter', 50, 200.80),
('Sugar', 80, 45.30),
('Salt', 100, 15.25),
('Eggs', 30, 60.99),
('Milk', 60, 85.00),
('Sausage', 30, 350.99),
('Fish', 15, 200.85),
('Tomato', 200, 40.50),
('Apple', 300, 65.00);

INSERT INTO Orders (CustomerID, ProductID, Quantity)
VALUES
(1, 10, 1), (2, 1, 5), (3, 8, 3), (4, 1, 10), (5, 6, 8),
(6, 1, 7), (7, 4, 2), (8, 1, 6), (9, 2, 11), (10, 1, 9);

--5) -----------------------------------------------------------
SELECT
	customers.id AS CustomerID, customers.firstname AS FirstName, customers.lastname AS LastName, 
	customers.age AS CustomerAge, products.id AS ProductID, orders.quantity AS ProductQuantity, 
	products.price AS ProductPrice, Products.Price * Orders.Quantity AS TotalPrice
FROM 
	Orders
	JOIN Products ON products.id = orders.productid 
	JOIN Customers ON customers.id = orders.customerid
WHERE 
	products.id = 1 AND customers.age > 30
GROUP BY 
	customers.id, customers.firstname, customers.lastname, customers.age,
	products.id, orders.quantity, products.price, TotalPrice
ORDER BY 
	customers.age;
	