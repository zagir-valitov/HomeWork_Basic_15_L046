-- 2), 3)
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

-- 4)
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
--select * from Products;

INSERT INTO Orders (CustomerID, ProductID, Quantity)
VALUES
(1, 10, 1), (2, 9, 5), (3, 1, 3), (4, 7, 10), (5, 6, 8),
(6, 1, 7), (7, 1, 2), (8, 3, 6), (9, 1, 11), (10, 1, 9);

--CREATE INDEX idx_Products_ID
--ON Products(ID);
--drop index idx_Products_ID;

SELECT 
	Customers.ID AS CustomerID, 
	Customers.Firstname AS FirstName,
	Customers.Lastname AS LastName, 
	Customers.Age AS CustomerAge,
	Products.ID AS ProductsID,
	Orders.Quantity AS ProductQuantity,
	Products.Price AS Price,
	Products.Price * Orders.Quantity AS TotalPrice	
FROM 
	Customers, 
	Orders, 
	Products
WHERE Orders.CustomerID = Customers.ID 
	AND Orders.ProductID = Products.ID 
	AND Products.ID = 1 
	AND Customers.Age > 30
GROUP BY 
	Customers.ID, 
	FirstName, LastName, CustomerAge,
	ProductsID,
	ProductQuantity, 
	Price,
	TotalPrice
ORDER BY 
	FirstName
;
