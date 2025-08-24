-- Create the 'Customers' table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(255) UNIQUE,
    PhoneNumber VARCHAR(15),
    Address TEXT,
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(10),
    Country VARCHAR(100),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    PreferredLanguage VARCHAR(50),
    AccountStatus ENUM('Active', 'Inactive', 'Suspended'),
    TotalOrders INT DEFAULT 0,
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod ENUM('Credit Card', 'UPI', 'PayPal', 'Cash on Delivery')
);

-- Create the 'Categories' table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    ParentCategoryID INT DEFAULT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);

-- Create the 'Brands' table
CREATE TABLE Brands (
    BrandID INT AUTO_INCREMENT PRIMARY KEY,
    BrandName VARCHAR(100) NOT NULL,
    Country VARCHAR(100)
);

-- Create the 'Products' table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    BrandID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT DEFAULT 0,
    Description TEXT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Weight DECIMAL(10, 2),
    Dimensions VARCHAR(50),
    Color VARCHAR(50),
    Material VARCHAR(50),
    IsReturnable BOOLEAN DEFAULT TRUE,
    WarrantyPeriod INT,
    Rating DECIMAL(3, 2) DEFAULT 0,
    NumberOfReviews INT DEFAULT 0,
    DiscountPercentage DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);

-- Create the 'Orders' table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    OrderStatus ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    ShippingAddress TEXT,
    BillingAddress TEXT,
    TotalAmount DECIMAL(10, 2),
    ShippingCost DECIMAL(10, 2) DEFAULT 0,
    PaymentStatus ENUM('Paid', 'Unpaid', 'Refunded') DEFAULT 'Unpaid',
    DeliveryDate DATETIME,
    CourierService VARCHAR(100),
    TrackingNumber VARCHAR(100),
    OrderPriority ENUM('High', 'Medium', 'Low') DEFAULT 'Medium',
    DiscountCodeUsed VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the 'OrderDetails' table
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(10, 2) DEFAULT 0,
    TaxAmount DECIMAL(10, 2) DEFAULT 0,
    FinalPrice DECIMAL(10, 2),
    ProductCondition ENUM('New', 'Refurbished', 'Used') DEFAULT 'New',
    ReturnStatus ENUM('Not Returned', 'Returned', 'Replacement Requested') DEFAULT 'Not Returned',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the 'Reviews' table
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    ReviewText TEXT,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the 'Suppliers' table
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(255),
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(10),
    Country VARCHAR(100)
);

-- Create the 'SupplierProducts' table (many-to-many relationship between Suppliers and Products)
CREATE TABLE SupplierProducts (
    SupplierProductID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierID INT,
    ProductID INT,
    PurchasePrice DECIMAL(10, 2),
    SupplyDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the 'ShoppingCart' table
CREATE TABLE ShoppingCart (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the 'CartItems' table
CREATE TABLE CartItems (
    CartItemID INT AUTO_INCREMENT PRIMARY KEY,
    CartID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (CartID) REFERENCES ShoppingCart(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the 'Payments' table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentAmount DECIMAL(10, 2),
    PaymentMethod ENUM('Credit Card', 'UPI', 'Cash on Delivery', 'PayPal'),
    TransactionID VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create the 'Warehouses' table
CREATE TABLE Warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName VARCHAR(100),
    Location VARCHAR(255),
    Capacity INT
);

-- Create the 'Inventory' table
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the 'Promotions' table
CREATE TABLE Promotions (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    PromotionName VARCHAR(255),
    StartDate DATETIME,
    EndDate DATETIME,
    DiscountPercentage DECIMAL(5, 2),
    ApplicableCategoryID INT,
    ApplicableBrandID INT,
    FOREIGN KEY (ApplicableCategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (ApplicableBrandID) REFERENCES Brands(BrandID)
);

ALTER TABLE Orders
MODIFY COLUMN OrderStatus ENUM('Pending', 'Completed', 'Cancelled', 'Delivered', 'Shipped') DEFAULT 'Pending';

