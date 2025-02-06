-- Step 1: Create Database
CREATE DATABASE InventoryManagementSystem;
USE InventoryManagementSystem;

-- Step 2: Create Tables

-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    Address TEXT,
    ContactPerson VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address TEXT,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(50)
);

-- Sales Table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- SaleDetails Table
CREATE TABLE SaleDetails (
    SaleDetailID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Step 3: Insert Sample Data

-- Insert Suppliers
INSERT INTO Suppliers (SupplierName, Address, ContactPerson, PhoneNumber) VALUES
('ABC Supply Co.', '123 Supplier St, City', 'Alice Johnson', '5559876543'),
('XYZ Goods Ltd.', '456 Supplier Rd, City', 'Bob Brown', '5551234567'),
('Fresh Produce Ltd.', '789 Supplier Ave, City', 'Charlie Davis', '5554567890');

-- Insert Products
INSERT INTO Products (Name, Category, Price, QuantityInStock, SupplierID) VALUES
('Milk', 'Dairy', 2.50, 100, 1),
('Bread', 'Bakery', 1.20, 50, 2),
('Apple', 'Fruits', 0.75, 200, 3),
('Soap', 'Toiletries', 1.50, 150, 2),
('Shampoo', 'Toiletries', 5.00, 80, 1);

-- Insert Customers
INSERT INTO Customers (Name, Address, PhoneNumber, Email) VALUES
('John Doe', '123 Main St, City', '1234567890', 'john@example.com'),
('Jane Smith', '456 Elm St, City', '9876543210', 'jane@example.com');

-- Insert Sales
INSERT INTO Sales (CustomerID, SaleDate, TotalAmount) VALUES
(1, '2024-11-20', 15.50),
(2, '2024-11-21', 8.40);

-- Insert SaleDetails
INSERT INTO SaleDetails (SaleID, ProductID, Quantity, UnitPrice, Subtotal) VALUES
(1, 1, 2, 2.50, 5.00),  -- 2 Milk
(1, 2, 1, 1.20, 1.20),  -- 1 Bread
(1, 4, 2, 1.50, 3.00),  -- 2 Soap
(2, 3, 5, 0.75, 3.75),  -- 5 Apples
(2, 2, 2, 1.20, 2.40);  -- 2 Bread

-- Step 4: Query Examples

-- View all Products with Supplier Information
SELECT p.ProductID, p.Name AS ProductName, p.Category, p.Price, p.QuantityInStock, s.SupplierName
FROM Products p
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- View Sales with Customer Details
SELECT s.SaleID, c.Name AS CustomerName, s.SaleDate, s.TotalAmount
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- View Sale Details for a Specific Sale
SELECT sd.SaleDetailID, p.Name AS ProductName, sd.Quantity, sd.UnitPrice, sd.Subtotal
FROM SaleDetails sd
JOIN Products p ON sd.ProductID = p.ProductID
WHERE sd.SaleID = 1;

-- Total Sales Amount for Each Customer
SELECT c.Name AS CustomerName, SUM(s.TotalAmount) AS TotalSpent
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID;
