INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, Address, City, State, PostalCode, Country, RegistrationDate, DateOfBirth, Gender, PreferredLanguage, AccountStatus, TotalOrders, LoyaltyPoints, PreferredPaymentMethod)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'Bangalore', 'Karnataka', '560001', 'India', '2023-01-01', '1990-05-15', 'Male', 'English', 'Active', 10, 500, 'Credit Card'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Elm St', 'Mumbai', 'Maharashtra', '400001', 'India', '2023-02-01', '1985-07-22', 'Female', 'English', 'Active', 8, 400, 'UPI'),
('Amit', 'Sharma', 'amit.sharma@example.com', '9123456789', '789 Oak St', 'Delhi', 'Delhi', '110001', 'India', '2023-03-01', '1992-12-10', 'Male', 'Hindi', 'Active', 15, 600, 'PayPal'),
('Priya', 'Kumar', 'priya.kumar@example.com', '8123456789', '123 Pine St', 'Chennai', 'Tamil Nadu', '600001', 'India', '2023-04-01', '1988-09-25', 'Female', 'Tamil', 'Active', 12, 700, 'Cash on Delivery'),
('Rahul', 'Verma', 'rahul.verma@example.com', '7123456789', '567 Birch St', 'Hyderabad', 'Telangana', '500001', 'India', '2023-05-01', '1995-06-30', 'Male', 'Hindi', 'Active', 5, 200, 'UPI'),
('Simran', 'Gill', 'simran.gill@example.com', '6123456789', '890 Maple St', 'Pune', 'Maharashtra', '411001', 'India', '2023-06-01', '1993-11-12', 'Female', 'Punjabi', 'Inactive', 7, 300, 'Credit Card'),
('Arjun', 'Reddy', 'arjun.reddy@example.com', '5123456789', '234 Cedar St', 'Kolkata', 'West Bengal', '700001', 'India', '2023-07-01', '1991-03-05', 'Male', 'English', 'Active', 9, 450, 'PayPal'),
('Meera', 'Naik', 'meera.naik@example.com', '4123456789', '567 Walnut St', 'Ahmedabad', 'Gujarat', '380001', 'India', '2023-08-01', '1996-08-18', 'Female', 'Gujarati', 'Active', 6, 250, 'UPI'),
('Vikram', 'Singh', 'vikram.singh@example.com', '3123456789', '678 Chestnut St', 'Jaipur', 'Rajasthan', '302001', 'India', '2023-09-01', '1994-02-28', 'Male', 'Hindi', 'Active', 11, 550, 'Cash on Delivery'),
('Ananya', 'Rao', 'ananya.rao@example.com', '2123456789', '789 Spruce St', 'Lucknow', 'Uttar Pradesh', '226001', 'India', '2023-10-01', '1989-04-10', 'Female', 'English', 'Active', 10, 500, 'Credit Card');


INSERT INTO Categories (CategoryName, ParentCategoryID)
VALUES
('Electronics', NULL),
('Home Appliances', NULL),
('Clothing', NULL),
('Men', 3),
('Women', 3),
('Mobiles', 1),
('Laptops', 1),
('Television', 1),
('Kitchen', 2),
('Furniture', 2);


INSERT INTO Brands (BrandName, Country)
VALUES
('Samsung', 'South Korea'),
('Apple', 'USA'),
('Sony', 'Japan'),
('LG', 'South Korea'),
('Whirlpool', 'USA'),
('Nike', 'USA'),
('Adidas', 'Germany'),
('Puma', 'Germany'),
('HP', 'USA'),
('Dell', 'USA');


ALTER TABLE Orders
MODIFY COLUMN OrderStatus ENUM('Pending', 'Completed', 'Cancelled', 'Delivered', 'Shipped') DEFAULT 'Pending';


-- Insert 20 Orders distributed across 5 customers
INSERT INTO Orders (CustomerID, OrderDate, OrderStatus, ShippingAddress, BillingAddress, TotalAmount, ShippingCost, PaymentStatus, DeliveryDate, CourierService, TrackingNumber, OrderPriority, DiscountCodeUsed)
VALUES
(1, '2025-01-10 10:30:00', 'Completed', '123 Main St, Bangalore', '123 Main St, Bangalore', 5000.00, 100.00, 'Paid', '2025-01-13', 'BlueDart', 'TRK001', 'High', 'NEWYEAR50'),
(1, '2025-01-15 12:45:00', 'Pending', '123 Main St, Bangalore', '123 Main St, Bangalore', 2500.00, 50.00, 'Unpaid', NULL, NULL, NULL, 'Medium', NULL),
(1, '2025-01-20 14:30:00', 'Cancelled', '123 Main St, Bangalore', '123 Main St, Bangalore', 800.00, 20.00, 'Refunded', NULL, NULL, NULL, 'Low', 'FREESHIP'),
(2, '2025-01-08 09:30:00', 'Completed', '456 Elm St, Bangalore', '456 Elm St, Bangalore', 12000.00, 200.00, 'Paid', '2025-01-11', 'DTDC', 'TRK004', 'High', 'WELCOME10'),
(2, '2025-01-13 16:00:00', 'Shipped', '456 Elm St, Bangalore', '456 Elm St, Bangalore', 6000.00, 150.00, 'Paid', NULL, 'FedEx', 'TRK005', 'Medium', NULL),
(2, '2025-01-18 10:00:00', 'Pending', '456 Elm St, Bangalore', '456 Elm St, Bangalore', 3500.00, 100.00, 'Unpaid', NULL, NULL, NULL, 'Low', 'NEWYEAR50'),
(3, '2025-01-05 11:20:00', 'Completed', '789 Maple St, Bangalore', '789 Maple St, Bangalore', 9000.00, 150.00, 'Paid', '2025-01-08', 'BlueDart', 'TRK007', 'High', 'FREESHIP'),
(3, '2025-01-09 14:45:00', 'Shipped', '789 Maple St, Bangalore', '789 Maple St, Bangalore', 7000.00, 120.00, 'Paid', NULL, 'DTDC', 'TRK008', 'Medium', 'SUMMER15'),
(3, '2025-01-14 12:10:00', 'Pending', '789 Maple St, Bangalore', '789 Maple St, Bangalore', 4500.00, 80.00, 'Unpaid', NULL, NULL, NULL, 'Low', NULL),
(4, '2025-01-03 10:15:00', 'Completed', '321 Oak St, Bangalore', '321 Oak St, Bangalore', 15000.00, 250.00, 'Paid', '2025-01-06', 'FedEx', 'TRK010', 'High', 'WINTER20'),
(4, '2025-01-12 16:20:00', 'Shipped', '321 Oak St, Bangalore', '321 Oak St, Bangalore', 8000.00, 100.00, 'Paid', NULL, 'BlueDart', 'TRK011', 'Medium', NULL),
(4, '2025-01-17 13:30:00', 'Cancelled', '321 Oak St, Bangalore', '321 Oak St, Bangalore', 4000.00, 50.00, 'Refunded', NULL, NULL, NULL, 'Low', 'FREESHIP'),
(5, '2025-01-07 09:00:00', 'Completed', '567 Pine St, Bangalore', '567 Pine St, Bangalore', 20000.00, 300.00, 'Paid', '2025-01-10', 'DTDC', 'TRK013', 'High', 'WELCOME10'),
(5, '2025-01-10 14:00:00', 'Shipped', '567 Pine St, Bangalore', '567 Pine St, Bangalore', 12000.00, 180.00, 'Paid', NULL, 'FedEx', 'TRK014', 'Medium', 'NEWYEAR50'),
(5, '2025-01-15 11:30:00', 'Pending', '567 Pine St, Bangalore', '567 Pine St, Bangalore', 6000.00, 100.00, 'Unpaid', NULL, NULL, NULL, 'Low', 'SUMMER15'),
(1, '2025-01-16 10:20:00', 'Completed', '123 Main St, Bangalore', '123 Main St, Bangalore', 3000.00, 50.00, 'Paid', '2025-01-18', 'BlueDart', 'TRK016', 'Medium', NULL),
(2, '2025-01-17 15:30:00', 'Shipped', '456 Elm St, Bangalore', '456 Elm St, Bangalore', 8000.00, 120.00, 'Paid', NULL, 'DTDC', 'TRK017', 'High', 'WELCOME10'),
(3, '2025-01-11 12:40:00', 'Pending', '789 Maple St, Bangalore', '789 Maple St, Bangalore', 6000.00, 80.00, 'Unpaid', NULL, NULL, NULL, 'Low', NULL),
(4, '2025-01-18 09:15:00', 'Cancelled', '321 Oak St, Bangalore', '321 Oak St, Bangalore', 5000.00, 70.00, 'Refunded', NULL, NULL, NULL, 'Low', 'FREESHIP'),
(5, '2025-01-19 14:50:00', 'Completed', '567 Pine St, Bangalore', '567 Pine St, Bangalore', 25000.00, 350.00, 'Paid', '2025-01-21', 'FedEx', 'TRK018', 'High', 'WINTER20');




INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, Discount, TaxAmount, FinalPrice, ProductCondition, ReturnStatus)
VALUES
(41, 1, 2, 500.00, 0.00, 50.00, 1050.00, 'New', 'Not Returned'),
(41, 2, 1, 1000.00, 0.00, 100.00, 1100.00, 'New', 'Not Returned'),
(42, 3, 1, 750.00, 0.00, 75.00, 825.00, 'New', 'Not Returned'),
(43, 4, 3, 300.00, 20.00, 50.00, 910.00, 'Refurbished', 'Not Returned'),
(43, 5, 2, 400.00, 30.00, 60.00, 830.00, 'New', 'Not Returned'),
(44, 6, 1, 1500.00, 0.00, 150.00, 1650.00, 'New', 'Returned'),
(45, 7, 2, 200.00, 10.00, 20.00, 430.00, 'Used', 'Replacement Requested'),
(45, 8, 1, 1000.00, 0.00, 100.00, 1100.00, 'New', 'Not Returned'),
(46, 9, 1, 750.00, 0.00, 75.00, 825.00, 'New', 'Not Returned'),
(46, 10, 3, 350.00, 30.00, 50.00, 1070.00, 'Refurbished', 'Not Returned'),
(47, 11, 2, 500.00, 0.00, 50.00, 1050.00, 'New', 'Not Returned'),
(48, 12, 1, 1200.00, 0.00, 120.00, 1320.00, 'New', 'Not Returned'),
(48, 13, 3, 400.00, 20.00, 40.00, 1240.00, 'Used', 'Not Returned'),
(49, 14, 2, 300.00, 15.00, 30.00, 615.00, 'New', 'Not Returned'),
(49, 15, 1, 800.00, 0.00, 80.00, 880.00, 'Refurbished', 'Not Returned'),
(50, 16, 3, 250.00, 10.00, 25.00, 765.00, 'Used', 'Replacement Requested'),
(51, 17, 2, 600.00, 0.00, 60.00, 1260.00, 'New', 'Not Returned'),
(51, 18, 1, 1000.00, 50.00, 100.00, 1050.00, 'New', 'Not Returned'),
(52, 19, 2, 150.00, 5.00, 15.00, 330.00, 'Refurbished', 'Returned'),
(53, 20, 3, 200.00, 0.00, 20.00, 620.00, 'New', 'Not Returned'),
(54, 1, 1, 1200.00, 100.00, 120.00, 1220.00, 'New', 'Not Returned'),
(55, 2, 2, 300.00, 10.00, 30.00, 630.00, 'Refurbished', 'Not Returned'),
(56, 3, 3, 450.00, 20.00, 45.00, 1415.00, 'New', 'Not Returned'),
(57, 4, 2, 600.00, 0.00, 60.00, 1260.00, 'Used', 'Replacement Requested'),
(58, 5, 1, 2000.00, 0.00, 200.00, 2200.00, 'New', 'Not Returned'),
(59, 6, 2, 350.00, 15.00, 35.00, 770.00, 'New', 'Not Returned'),
(60, 7, 3, 400.00, 20.00, 40.00, 1240.00, 'Refurbished', 'Not Returned');



INSERT INTO Suppliers (SupplierName, ContactName, ContactEmail, Phone, Address, City, State, PostalCode, Country)
VALUES
('ABC Electronics', 'John Abraham', 'john.abraham@abc.com', '1234567890', '123 Main St', 'Bangalore', 'Karnataka', '560001', 'India'),
('Global Traders', 'Jane Doe', 'jane.doe@global.com', '9876543210', '456 Elm St', 'Mumbai', 'Maharashtra', '400001', 'India'),
('Tech Distributors', 'Amit Gupta', 'amit.gupta@techdist.com', '9123456789', '789 Oak St', 'Delhi', 'Delhi', '110001', 'India'),
('Wholesale Hub', 'Priya Reddy', 'priya.reddy@wholesalehub.com', '8123456789', '123 Pine St', 'Chennai', 'Tamil Nadu', '600001', 'India');

INSERT INTO SupplierProducts (SupplierID, ProductID, PurchasePrice, SupplyDate) VALUES
(1, 1, 25.50, '2025-01-15 08:30:00'),
(2, 2, 18.75, '2025-01-16 09:00:00'),
(3, 3, 40.00, '2025-01-17 10:15:00'),
(1, 4, 22.30, '2025-01-18 11:45:00'),
(2, 5, 35.60, '2025-01-19 12:00:00'),
(3, 6, 12.99, '2025-01-20 13:30:00'),
(4, 7, 28.90, '2025-01-21 14:00:00'),
(1, 8, 15.50, '2025-01-22 15:15:00'),
(2, 9, 20.00, '2025-01-23 16:45:00'),
(2, 10, 33.40, '2025-01-24 17:00:00');

INSERT INTO Reviews (ProductID, CustomerID, Rating, ReviewText, ReviewDate) VALUES
(1, 1, 5, 'Excellent product! Highly recommended for daily use.', '2025-01-15 08:45:00'),
(2, 2, 4, 'Good quality, but a bit expensive for the features offered.', '2025-01-16 09:30:00'),
(3, 3, 3, 'It’s okay, but it didn’t meet my expectations.', '2025-01-17 10:00:00'),
(4, 1, 5, 'Great value for money! Will buy again.', '2025-01-18 11:00:00'),
(5, 4, 2, 'Not satisfied with the product quality, needs improvement.', '2025-01-19 12:15:00'),
(6, 2, 4, 'Very comfortable and stylish. Would recommend.', '2025-01-20 13:45:00'),
(7, 5, 1, 'Terrible product, it broke within a week of use.', '2025-01-21 14:30:00'),
(8, 3, 3, 'Average quality. Not bad but not great either.', '2025-01-22 15:00:00'),
(9, 6, 5, 'Absolutely love it! Perfect for my needs.', '2025-01-23 16:30:00'),
(10, 2, 4, 'Good, but the color was slightly different from the image.', '2025-01-24 17:00:00'),
(11, 1, 5, 'Fantastic product, exceeded my expectations!', '2025-01-15 08:50:00'),
(12, 2, 4, 'Great quality, very durable and well worth the price.', '2025-01-16 09:35:00'),
(13, 3, 3, 'Decent product, but could be better.', '2025-01-17 10:10:00'),
(14, 4, 2, 'Not as good as advertised, disappointed.', '2025-01-18 11:10:00'),
(15, 1, 5, 'Absolutely loved this product! Will purchase again.', '2025-01-19 12:30:00'),
(16, 6, 4, 'Good product overall, but it could use some improvements.', '2025-01-20 13:50:00'),
(17, 5, 1, 'Do not buy! The product broke on the first use.', '2025-01-21 14:40:00'),
(18, 3, 3, 'Average, nothing special about it.', '2025-01-22 15:10:00'),
(19, 2, 4, 'Very stylish and comfortable. Would buy again.', '2025-01-23 16:40:00'),
(20, 4, 5, 'Excellent quality, exactly what I was looking for!', '2025-01-24 17:10:00');



INSERT INTO ShoppingCart (CustomerID, CreatedDate) VALUES
(1, '2025-01-15 08:00:00'),
(2, '2025-01-16 09:15:00'),
(3, '2025-01-17 10:30:00'),
(4, '2025-01-18 11:45:00'),
(5, '2025-01-19 12:00:00'),
(6, '2025-01-20 13:10:00'),
(7, '2025-01-21 14:20:00'),
(8, '2025-01-22 15:25:00'),
(9, '2025-01-23 16:35:00'),
(10, '2025-01-24 17:40:00');


INSERT INTO CartItems (CartID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 5, 1),
(2, 3, 3),
(2, 7, 2),
(3, 2, 1),
(3, 4, 5),
(4, 6, 2),
(4, 8, 1),
(5, 9, 4),
(5, 10, 2),
(6, 11, 1),
(6, 12, 3),
(7, 13, 2),
(7, 14, 1),
(8, 15, 1),
(8, 16, 2),
(9, 17, 3),
(9, 18, 1),
(10, 19, 2),
(10, 20, 4);



INSERT INTO Payments (OrderID, PaymentAmount, PaymentMethod, TransactionID) VALUES
(41, 220.00, 'UPI', 'TXN9876543210'),
(42, 90.50, 'Cash on Delivery', 'TXN1122334455'),
(43, 180.30, 'PayPal', 'TXN5566778899'),
(44, 75.20, 'Credit Card', 'TXN6677889900'),
(45, 250.00, 'UPI', 'TXN9988776655'),
(46, 130.00, 'Cash on Delivery', 'TXN3344556677'),
(47, 95.40, 'PayPal', 'TXN7788990011'),
(48, 180.25, 'Credit Card', 'TXN4433221100'),
(49, 300.00, 'UPI', 'TXN5566770022'),
(50, 200.00, 'Credit Card', 'TXN2233445566'),
(51, 120.50, 'Cash on Delivery', 'TXN1122336677'),
(52, 175.00, 'PayPal', 'TXN9988773344'),
(53, 220.75, 'UPI', 'TXN5566772233'),
(54, 90.30, 'Credit Card', 'TXN6677882233'),
(55, 250.50, 'Cash on Delivery', 'TXN3344559988'),
(56, 140.00, 'PayPal', 'TXN1122337799'),
(57, 180.00, 'UPI', 'TXN2233447788'),
(58, 95.20, 'Credit Card', 'TXN5566774455'),
(59, 310.50, 'Cash on Delivery', 'TXN6677883322'),
(60, 225.00, 'PayPal', 'TXN3344556677');


INSERT INTO Warehouses (WarehouseName, Location, Capacity) VALUES
('Central Warehouse', 'Bangalore, India', 1000),
('East Zone Warehouse', 'Chennai, India', 800),
('North Zone Warehouse', 'Delhi, India', 1200),
('South Zone Warehouse', 'Hyderabad, India', 950),
('West Zone Warehouse', 'Mumbai, India', 1100),
('International Warehouse', 'Dubai, UAE', 1500),
('Suburban Warehouse', 'Pune, India', 700),
('Regional Warehouse', 'Kolkata, India', 850),
('Northern Peak Warehouse', 'Lucknow, India', 600),
('Southern Peak Warehouse', 'Coimbatore, India', 400);



INSERT INTO Inventory (WarehouseID, ProductID, Quantity) VALUES
-- Products in Warehouse 1
(1, 1, 500), (1, 2, 300), (1, 3, 400), (1, 4, 250), (1, 5, 100),
(1, 6, 450), (1, 7, 350), (1, 8, 200), (1, 9, 600), (1, 10, 550),
(1, 11, 400), (1, 12, 300), (1, 13, 150), (1, 14, 100), (1, 15, 250),
(2, 2, 600), (2, 3, 500), (2, 4, 450), (2, 5, 350), (2, 6, 400),
(2, 7, 300), (2, 8, 250), (2, 9, 200), (2, 10, 650), (2, 11, 550),
(2, 12, 450), (2, 13, 350), (2, 14, 400), (2, 15, 300), (2, 16, 250),
(3, 3, 700), (3, 4, 600), (3, 5, 500), (3, 6, 400), (3, 7, 300),
(3, 8, 550), (3, 9, 600), (3, 10, 750), (3, 11, 650), (3, 12, 450),
(3, 13, 350), (3, 14, 500), (3, 15, 250), (3, 16, 300), (3, 17, 200),
(4, 4, 800), (4, 5, 600), (4, 6, 450), (4, 7, 550), (4, 8, 500),
(4, 9, 650), (4, 10, 750), (4, 11, 800), (4, 12, 700), (4, 13, 400),
(4, 14, 300), (4, 15, 450), (4, 16, 350), (4, 17, 250), (4, 18, 150),
(5, 5, 750), (5, 6, 850), (5, 7, 950), (5, 8, 650), (5, 9, 500),
(5, 10, 550), (5, 11, 400), (5, 12, 350), (5, 13, 300), (5, 14, 250),
(5, 15, 200), (5, 16, 150), (5, 17, 100), (5, 18, 250), (5, 19, 350),
(6, 6, 950), (6, 7, 850), (6, 8, 750), (6, 9, 650), (6, 10, 550),
(6, 11, 450), (6, 12, 350), (6, 13, 250), (6, 14, 150), (6, 15, 100),
(6, 16, 200), (6, 17, 300), (6, 18, 400), (6, 19, 500), (6, 20, 600),
(7, 7, 600), (7, 8, 500), (7, 9, 400), (7, 10, 300), (7, 11, 250),
(7, 12, 200), (7, 13, 150), (7, 14, 100), (7, 15, 200), (7, 16, 300),
(7, 17, 400), (7, 18, 500), (7, 19, 600), (7, 20, 700), (7, 1, 800),
(8, 8, 550), (8, 9, 450), (8, 10, 350), (8, 11, 250), (8, 12, 150),
(8, 13, 100), (8, 14, 200), (8, 15, 300), (8, 16, 400), (8, 17, 500),
(8, 18, 600), (8, 19, 700), (8, 20, 800), (8, 1, 900), (8, 2, 950),
(9, 9, 400), (9, 10, 350), (9, 11, 300), (9, 12, 250), (9, 13, 200),
(9, 14, 150), (9, 15, 100), (9, 16, 200), (9, 17, 300), (9, 18, 400),
(9, 19, 500), (9, 20, 600), (9, 1, 700), (9, 2, 800), (9, 3, 900),
(10, 10, 500), (10, 11, 450), (10, 12, 400), (10, 13, 350), (10, 14, 300),
(10, 15, 250), (10, 16, 200), (10, 17, 150), (10, 18, 100), (10, 19, 200),
(10, 20, 300), (10, 1, 400), (10, 2, 500), (10, 3, 600), (10, 4, 700);

INSERT INTO Promotions (PromotionName, StartDate, EndDate, DiscountPercentage, ApplicableCategoryID, ApplicableBrandID) VALUES
('Winter Festive Sale', '2025-01-15 00:00:00', '2025-01-31 23:59:59', 20.00, 1, 2),
('New Year Mega Offer', '2025-01-01 00:00:00', '2025-01-10 23:59:59', 25.00, 3, NULL),
('Valentine’s Special', '2025-02-10 00:00:00', '2025-02-14 23:59:59', 15.00, NULL, 4),
('End of Season Clearance', '2025-01-20 00:00:00', '2025-02-05 23:59:59', 30.00, 2, NULL),
('Brand Loyalty Offer', '2025-01-25 00:00:00', '2025-02-15 23:59:59', 10.00, NULL, 1);


select * from Orders;
