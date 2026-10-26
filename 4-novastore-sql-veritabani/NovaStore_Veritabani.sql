CREATE DATABASE NovaStoreDB;
GO
USE NovaStoreDB;
GO

-- BÖLÜM 1: Tablo Yapıları
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(50),
    City VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Stock INT DEFAULT 0,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    DetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT
);

-- BÖLÜM 2: Veri Girişi
INSERT INTO Categories (CategoryName) VALUES 
('Elektronik'), ('Giyim'), ('Kitap'), ('Kozmetik'), ('Ev ve Yaşam');

INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES 
('Laptop', 25000, 15, 1), 
('Akıllı Telefon', 15000, 30, 1),
('T-Shirt', 450, 100, 2), 
('Pantolon', 800, 50, 2),
('Veri Analizi Kitabı', 120, 10, 3), -- Güncellenen ürün
('Dünya Klasikleri Romanı', 85, 25, 3),
('Parfüm', 1200, 12, 4), 
('Nemlendirici', 300, 40, 4),
('Kahve Makinesi', 4500, 5, 5), 
('Nevresim Takımı', 950, 20, 5);

INSERT INTO Customers (FullName, City, Email) VALUES 
('Ahmet Yılmaz', 'İstanbul', 'ahmet@mail.com'),
('Ayşe Demir', 'Ankara', 'ayse@mail.com'),
('Mehmet Kaya', 'İzmir', 'mehmet@mail.com'),
('Canan Öz', 'Bursa', 'canan@mail.com'),
('Selin Aksoy', 'İstanbul', 'selin@mail.com');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES 
(1, '2026-02-01', 25450), 
(2, '2026-02-05', 1200),
(3, '2026-02-10', 4500), 
(1, '2026-02-12', 800),
(5, '2026-02-14', 150);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES 
(1, 1, 1), (1, 3, 1), (2, 7, 1), (3, 9, 1), (4, 4, 1);

-- BÖLÜM 3: Sorgular
-- 1. Stok Analizi
SELECT ProductName, Stock 
FROM Products 
WHERE Stock < 20 
ORDER BY Stock DESC;

-- 2. Sipariş Listesi
SELECT C.FullName, C.City, O.OrderDate, O.TotalAmount
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID;

-- 3. Müşteri Detay Raporu
SELECT C.FullName, P.ProductName, P.Price, Cat.CategoryName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories Cat ON P.CategoryID = Cat.CategoryID
WHERE C.FullName = 'Ahmet Yılmaz';

-- 4. Kategori Bazlı Sayım
SELECT Cat.CategoryName, COUNT(P.ProductID) AS UrunSayisi
FROM Categories Cat
LEFT JOIN Products P ON Cat.CategoryID = P.CategoryID
GROUP BY Cat.CategoryName;

-- 5. Ciro Raporu
SELECT C.FullName, SUM(O.TotalAmount) AS ToplamCiro
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FullName
ORDER BY ToplamCiro DESC;

-- 6. Zaman Analizi
SELECT OrderID, OrderDate, DATEDIFF(DAY, OrderDate, GETDATE()) AS GecenGun
FROM Orders;

-- BÖLÜM 4: Görünüm ve Yedekleme
GO
CREATE VIEW vw_SiparisOzet AS
SELECT C.FullName AS MusteriAdi, O.OrderDate, P.ProductName, OD.Quantity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID;
GO

-- BACKUP DATABASE NovaStoreDB TO DISK = 'C:\Yedek\NovaStoreDB.bak';