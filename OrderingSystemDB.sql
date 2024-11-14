create database ordering_system
go
use ordering_system
go

create table Users
(
   UserID int PRIMARY KEY,
   UserName VARCHAR(100) NOT NULL,
   Pass varchar(255) NOT NULL,
   FullName nvarchar(50) NOT NULL,
   PhoneNumber VARCHAR(10) CHECK (PhoneNumber LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
   Email varchar(50),
   Address NVARCHAR(50)  NULL,
   AvtImg nvarchar(200) null,
   ShopID int,
   Role int not null
)

go

CREATE TRIGGER trg_InsertUser
ON Users
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @UserID INT;
    DECLARE @UserName varchar(100) ;
    DECLARE @Pass varchar(255);
    DECLARE @FullName nvarchar (50);
    DECLARE @PhoneNumber VARCHAR(10);
    DECLARE @Email varchar(50);
	DECLARE @Address nvarchar(50);
	DECLARE @AvtImg nvarchar(200) ;
    DECLARE @ShopID int;
    DECLARE @Role int ;


    DECLARE insert_cursor CURSOR FOR
    SELECT UserName, Pass, FullName, PhoneNumber, Email,Address, AvtImg,ShopID, Role
    FROM inserted;

    OPEN insert_cursor;

    FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address,@AvtImg,@ShopID, @Role;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        WHILE 1=1
        BEGIN
            SET @UserID = ABS(CHECKSUM(NEWID()) % 100000000);

            IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
            BEGIN

                INSERT INTO Users (UserID, UserName, Pass, FullName, PhoneNumber, Email, Address, AvtImg,ShopID, Role)
                VALUES (@UserID,@UserName, @Pass, @FullName, @PhoneNumber, @Email,@Address,@AvtImg, @ShopID, @Role);
                BREAK;
            END
        END

        FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email,@Address, @AvtImg, @ShopID, @Role;
    END

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;

GO


CREATE TABLE password_reset_tokens (
    id INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expiration_time DATETIME NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
);




delete from users where UserName like 'huesuong'

select * from Users


ALTER TABLE Users
ADD code nvarchar(25);

-- start here------------------------------

ALTER TABLE Users
ADD Status BIT;

CREATE TABLE Shop (
    ShopID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Status BIT NOT NULL,
    ShopImage NVARCHAR(255),
    Address NVARCHAR(255),
    TimeOpen TIME,
    TimeClose TIME
);

INSERT INTO Shop (Name, Description, Status, ShopImage, Address, TimeOpen, TimeClose)
VALUES 
('Hana Chicken', 'Fried chicken restaurants.', 1, 'https://i.pinimg.com/564x/f8/a7/01/f8a70144eb881afe78df0164e657e966.jpg', '321 ABC, Da Nang, VietNam', '09:00', '21:00'),
('Viet Restaurants', 'Hemispheres Steak & Seafood Grill', 1, 'https://i.pinimg.com/564x/a9/14/a1/a914a1fd5994a1997154155256d751cc.jpg', '321 ABC, Ha Noi, VietNam', '10:00', '22:00');

select * from Shop

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX)
);

INSERT INTO Categories (Type, Description)
VALUES 
    ('Food', 'All kinds of dishes, snacks, and meals.'),
    ('Drink', 'A variety of beverages including soft drinks and hot drinks.'),
    ('Dessert', 'Sweet treats and baked goods.'),
    ('Snacks', 'Quick bites and light refreshments.'),
    ('Beverages', 'A wide range of cold and hot drinks, from sodas to specialty teas.');



CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18, 2) NOT NULL,
    Status BIT NOT NULL,
    ShopID INT FOREIGN KEY REFERENCES Shop(ShopID),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    PurchaseCount INT DEFAULT 0,
    Rating DECIMAL(3, 2) CHECK (Rating BETWEEN 0 AND 5)
);


-- Food Category
INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, PurchaseCount, Rating)
VALUES
    ('Grilled Salmon', 'Delicately grilled salmon fillet served with a variety of roasted vegetables, drizzled with a tangy lemon butter sauce for a flavorful experience.', 15.99, 1, 3, 1, 200, 4.6),
    ('Spaghetti Bolognese', 'Classic Italian dish with perfectly cooked spaghetti topped with a slow-cooked, savory meat sauce made from tomatoes, garlic, and ground beef.', 10.50, 1, 4, 1, 350, 4.7),
    ('Vegan Buddha Bowl', 'A nourishing bowl featuring quinoa, roasted sweet potatoes, avocado, chickpeas, and a creamy tahini dressing, offering a balanced and healthy meal.', 12.00, 1, 3, 1, 180, 4.5);

-- Drink Category
INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, PurchaseCount, Rating)
VALUES
    ('Fresh Orange Juice', 'Made from 100% freshly squeezed oranges, this juice is naturally sweet and packed with vitamin C, giving you a perfect start to your morning.', 4.99, 1, 3, 2, 250, 4.8),
    ('Mocha Latte', 'Rich espresso combined with velvety steamed milk and chocolate syrup, topped with whipped cream and a drizzle of chocolate sauce for indulgence.', 5.50, 1, 4, 2, 400, 4.9),
    ('Lemonade', 'A refreshing homemade lemonade made with fresh lemon juice, cold water, and just a hint of honey, ideal for a hot summer day.', 3.99, 1, 4, 2, 300, 4.6);

-- Dessert Category
INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, PurchaseCount, Rating)
VALUES
    ('Tiramisu', 'This Italian classic dessert features layers of espresso-soaked ladyfingers, creamy mascarpone cheese, and is dusted with cocoa powder for a rich flavor.', 6.99, 1, 3, 3, 220, 4.8),
    ('Cheesecake', 'Our creamy New York-style cheesecake with a buttery graham cracker crust is topped with a sweet strawberry compote for the perfect balance of flavors.', 7.50, 1, 4, 3, 350, 4.9),
    ('Apple Pie', 'A deliciously spiced apple filling wrapped in a flaky golden crust, served warm and topped with a scoop of vanilla ice cream for extra indulgence.', 5.99, 1, 3, 3, 300, 4.7);

-- Snacks Category
INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, PurchaseCount, Rating)
VALUES
    ('Trail Mix', 'A delightful blend of roasted nuts, dried fruits, and a touch of chocolate, perfect for a quick, energizing snack during your busy day.', 3.50, 1, 4, 4, 450, 4.5),
    ('Pretzels', 'Crispy baked pretzels with a hint of salt, offering a satisfying crunch and great for snacking on their own or paired with dips.', 2.50, 1, 4, 4, 500, 4.4),
    ('Popcorn', 'Freshly popped popcorn seasoned lightly with salt and butter, ideal for movie nights or a quick, tasty snack at any time.', 1.99, 1, 3, 4, 600, 4.3);

-- Beverages Category
INSERT INTO Product (Name, Description, Price, Status, ShopID, CategoryID, PurchaseCount, Rating)
VALUES
    ('Iced Green Tea', 'Refreshing iced green tea brewed from high-quality leaves, with a hint of lemon for a balanced and naturally sweet flavor.', 3.99, 1, 3, 5, 350, 4.7),
    ('Sparkling Water', 'Crisp and bubbly sparkling water with a touch of natural lime essence, offering a refreshing and hydrating experience any time of day.', 2.99, 1, 4, 5, 200, 4.5),
    ('Herbal Chamomile Tea', 'Calming chamomile tea made from organic flowers, perfect for relaxation and soothing your senses before bedtime.', 2.99, 1, 3, 5, 150, 4.8);
<<<<<<< HEAD

=======
	
>>>>>>> main
	select * from product

CREATE TABLE ProductImage (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
	IsAvatar BIT,
	ImgURL nvarchar(200) NOT NULL

);


<<<<<<< HEAD
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (1, 1, 'https://i.pinimg.com/564x/78/b8/a8/78b8a8068cae03ae1918c553ebb5b59f.jpg'),  
    (1, 0, 'https://i.pinimg.com/564x/50/83/f6/5083f664913f20fc6efe9e378f2a62f1.jpg'), 
    (1, 0, 'https://i.pinimg.com/564x/e8/bd/db/e8bddb0b456b9b7f8417b5dd6bc6e75b.jpg'); 
=======
>>>>>>> main

CREATE TABLE CartItem (
    CartItemID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	ProductID INT NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
	Quantity INT DEFAULT 1,
	ShopID INT NOT NULL FOREIGN KEY REFERENCES Shop(ShopID)
);
select * from CartItem



<<<<<<< HEAD
=======

>>>>>>> main
CREATE TRIGGER UpdateCartItemQuantity
ON CartItem
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UserID INT;
    DECLARE @ShopID INT;

    SELECT @ProductID = ProductID, @Quantity = Quantity, @UserID = UserID, @ShopID = ShopID FROM inserted;

    IF EXISTS (SELECT 1 FROM CartItem WHERE ProductID = @ProductID AND UserID = @UserID AND ShopID = @ShopID)
    BEGIN

        UPDATE CartItem
        SET Quantity = Quantity + @Quantity
        WHERE ProductID = @ProductID AND UserID = @UserID AND ShopID = @ShopID;
    END 
    ELSE 
    BEGIN

        INSERT INTO CartItem (UserID, ProductID, Quantity, ShopID) 
        VALUES (@UserID, @ProductID, @Quantity, @ShopID);
    END
END;


CREATE TABLE Favourite (
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    PRIMARY KEY (UserID, ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	ProductID INT NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
	Rating INT NOT NULL,
	Comment NVARCHAR (MAX),
	CreatedDate DATETIME DEFAULT GETDATE(),
);

CREATE TABLE Discount (
    DiscountID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),  
    DiscountName NVARCHAR(100) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    DiscountPercentage DECIMAL(5, 2) NOT NULL,   
    Type NVARCHAR(50) NOT NULL
);






CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),  
    Status NVARCHAR(50) NOT NULL,
    Address NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE(),
    DeliveryOption NVARCHAR(50),
    TimePickup DATETIME,
    TotalAmount DECIMAL(18, 2) NOT NULL,
    DiscountID INT FOREIGN KEY REFERENCES Discount(DiscountID),  
    PaymentOption NVARCHAR(50) NOT NULL
);





CREATE TABLE OrderItem (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(18, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)  

)

CREATE TABLE RewardRedemption (
    RedemptionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    NumberOfPoint INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Post (
    PostID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	ImgURL nvarchar(200) NOT NULL,
	Heading NVARCHAR (MAX) NOT NULL,
	Content NVARCHAR (MAX) NOT NULL,
	CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Comment(
    CommentID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	PostID INT NOT NULL FOREIGN KEY REFERENCES Post(PostID),
	Content NVARCHAR (MAX) NOT NULL
);




select * from product

INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (1, 1, 'https://i.pinimg.com/564x/78/b8/a8/78b8a8068cae03ae1918c553ebb5b59f.jpg'),  
    (1, 0, 'https://i.pinimg.com/564x/50/83/f6/5083f664913f20fc6efe9e378f2a62f1.jpg'), 
    (1, 0, 'https://i.pinimg.com/564x/e8/bd/db/e8bddb0b456b9b7f8417b5dd6bc6e75b.jpg'); 


	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (2, 1, 'https://i.pinimg.com/564x/8e/a1/38/8ea138d9fedca1f76cf4310b00e6c452.jpg'),  
    (2, 0, 'https://i.pinimg.com/474x/d9/b4/a7/d9b4a7273b8d7bcb0972806fe425144e.jpg'), 
    (2, 0, 'https://i.pinimg.com/474x/d1/77/d8/d177d8ae87485414cacd5b7e26792c68.jpg'); 


	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (3, 1, 'https://i.pinimg.com/control/474x/4d/1e/85/4d1e856247793d122d674af58fb386ad.jpg'),  
    (3, 0, 'https://i.pinimg.com/control/474x/2f/88/6a/2f886a2c26919593cb658e76664708e0.jpg');


	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (4, 1, 'https://i.pinimg.com/474x/21/4a/41/214a41d1c28f5f02d4439d129252281e.jpg'),  
    (4, 0, 'https://i.pinimg.com/474x/3d/7c/7d/3d7c7d47fad02baf7d903fcce0a7e5e9.jpg'); 



INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (5, 1, 'https://i.pinimg.com/control/474x/70/0f/11/700f116df1ff53ecc03ca6aa75404ee8.jpg'),  
    (5, 0, 'https://i.pinimg.com/474x/02/d3/d5/02d3d53f06208bd21ebf396828a1777d.jpg'); 



INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (6, 1, 'https://i.pinimg.com/control/474x/ff/02/5b/ff025bc01db3a954679604c06cd73b00.jpg'),  
    (6, 0, 'https://i.pinimg.com/control/474x/7d/c5/2a/7dc52a2e06d9c703cce83627dd8c9cc7.jpg'); 



INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (7, 1, 'https://i.pinimg.com/474x/f1/44/21/f144215b5844b9265879b22952259022.jpg'),  
    (7, 0, 'https://i.pinimg.com/474x/b1/80/7f/b1807fb41b72e16edc165a5e85c4e91c.jpg'); 


	

INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (8, 1, 'https://i.pinimg.com/control/474x/d5/7a/04/d57a041198ee755555cfd6797308051c.jpg'),  
    (8, 0, 'https://i.pinimg.com/control/474x/9d/8c/93/9d8c93ac5dfbebea6dd1ede27aeee719.jpg'); 



INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (9, 1, 'https://i.pinimg.com/474x/19/73/8d/19738dbeac866d5cff287cb9d8f2822a.jpg'),  
    (9, 0, 'https://i.pinimg.com/474x/cb/5b/2f/cb5b2f828cf5c572a36e75e865d1308a.jpg'); 




	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (10, 1, 'https://i.pinimg.com/474x/80/27/aa/8027aab180b25938201a60897ed17d2c.jpg'),  
    (10, 0, 'https://i.pinimg.com/474x/12/3b/10/123b1037d2654b5de3428849287df0c4.jpg'); 


	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (11, 1, 'https://i.pinimg.com/control/474x/da/1e/af/da1eaff9e88f15d7d9ccd0304d4fa3ff.jpg'),  
    (11, 0, 'https://i.pinimg.com/control/474x/44/8a/d2/448ad28a830d3b73d78a31c61b0472ca.jpg'); 

	
	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (12, 1, 'https://i.pinimg.com/474x/0b/2f/51/0b2f5103ac649178ceacc418e8f577fc.jpg'),  
    (12, 0, 'https://i.pinimg.com/control/474x/ee/38/ab/ee38ab9a3fc95be435c74f75d5adc27a.jpg'); 

	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (13, 1, 'https://i.pinimg.com/474x/bf/5e/4a/bf5e4ade35d7f69d067975d06ae65bad.jpg'),  
    (13, 0, 'https://i.pinimg.com/474x/a6/99/85/a69985621f0a297d34cb8dd1822548af.jpg'); 

	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (14, 1, 'https://i.pinimg.com/474x/fb/76/4f/fb764fb4308fd0fcc4bfe122a537f903.jpg'),  
    (14, 0, 'https://i.pinimg.com/474x/0a/85/75/0a8575a3726b99926282dc42b4b90ebe.jpg'); 

	
INSERT INTO ProductImage (ProductID, IsAvatar, ImgURL)
VALUES
    (15, 1, 'https://i.pinimg.com/474x/89/74/69/89746945cde435909f8fa2719908fe4e.jpg'),  
    (15, 0, 'https://i.pinimg.com/474x/84/7c/61/847c61710be1177bb997310fdcbcf699.jpg'); 

	select * from ProductImage

    CREATE TABLE Bill (
    BillID BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Total MONEY NOT NULL,
    Payment VARCHAR(250) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    Date DATETIME NOT NULL,
    Phone VARCHAR(10) NOT NULL CHECK (Phone LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);


//Fix
DROP TABLE IF EXISTS OrderItem;

DROP TABLE IF EXISTS [Order];

CREATE TABLE [Order] (
    OrderID INT, -- Không tự động tăng
    UserID INT FOREIGN KEY REFERENCES Users(UserID),  
    Status NVARCHAR(50) NOT NULL,
    Address NVARCHAR(255),
    CreatedDate DATETIME DEFAULT GETDATE(),
    DeliveryOption NVARCHAR(50),
    TimePickup DATETIME,
    TotalAmount DECIMAL(18, 2) NOT NULL,
    DiscountID INT FOREIGN KEY REFERENCES Discount(DiscountID),  
    PaymentOption NVARCHAR(50) NOT NULL,
    PRIMARY KEY(OrderID)  
);

CREATE TABLE OrderItem (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES [Order](OrderID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(18, 2) NOT NULL
);


select * from [Order] order by CreatedDate DESC
--update 17/10
ALTER TABLE [Order]
add PaymentID int not null default 0000

ALTER TABLE Discount 
DROP COLUMN DiscountName, StartDate, EndDate;
ALTER TABLE Discount 
ADD 
    DiscountCODE NVARCHAR(100) NOT NULL,
    NumberOfDiscount INT NOT NULL,
    TotalUse INT NOT NULL

ALTER TABLE Discount 
ADD 
ShopID int 
SELECT DiscountPercentage FROM Discount WHERE DiscountCODE = 'O00IZLP4' AND Status = 1

ALTER TABLE [Order] 
ADD 
Phone nvarchar(11)
ALTER TABLE Discount 
DROP COLUMN DiscountName, StartDate, EndDate;

select * from Discount

Alter table Refund 
Add RefundOption int default 1;
UPDATE Users
SET Status = 1
WHERE Status IS NULL;

ALTER TABLE Discount
DROP CONSTRAINT FK_Discount_Users, 
ADD CONSTRAINT FK_Discount_Shop FOREIGN KEY (ShopID) REFERENCES Shop(ShopID);

ALTER TABLE VNPay_Bill
ALTER COLUMN vnpAmount DECIMAL(10, 2) NOT NULL;




ALTER TABLE Users
ADD CONSTRAINT DF_Users_Status DEFAULT 1 FOR Status;

drop trigger trg_InsertUser
go


CREATE TRIGGER trg_InsertUser
ON Users
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @UserID INT;
    DECLARE @UserName VARCHAR(100);
    DECLARE @Pass VARCHAR(255);
    DECLARE @FullName NVARCHAR(50);
    DECLARE @PhoneNumber VARCHAR(10);
    DECLARE @Email VARCHAR(50);
    DECLARE @Address NVARCHAR(50);
    DECLARE @AvtImg NVARCHAR(200);
    DECLARE @ShopID INT;
    DECLARE @Role INT;
    DECLARE @Status BIT; -- Khai báo biến Status

    DECLARE insert_cursor CURSOR FOR
    SELECT UserName, Pass, FullName, PhoneNumber, Email, Address, AvtImg, ShopID, Role, Status
    FROM inserted; -- Thêm Status vào phần SELECT

    OPEN insert_cursor;

    FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        WHILE 1=1
        BEGIN
            SET @UserID = ABS(CHECKSUM(NEWID()) % 100000000);

            IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
            BEGIN
                INSERT INTO Users (UserID, UserName, Pass, FullName, PhoneNumber, Email, Address, AvtImg, ShopID, Role, Status)
                VALUES (@UserID, @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status); -- Thêm Status 
                BREAK;
            END
        END

        FETCH NEXT FROM insert_cursor INTO @UserName, @Pass, @FullName, @PhoneNumber, @Email, @Address, @AvtImg, @ShopID, @Role, @Status;
    END

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;

GO
EXEC sp_rename 'Order.Status', 'PaymentStatus', 'COLUMN';


ALTER TABLE [Order]
ADD Delivery_Status NVARCHAR(50);
select * from [Order] order by CreatedDate DESC

CREATE TABLE VNPay_Bill (
    vnp_TxnRef INT NOT NULL,
    vnp_Amount FLOAT,
    vnp_PayDate NVARCHAR(50),
    vnp_TransactionStatus INT,
    PRIMARY KEY (vnp_TxnRef)
);


select * from VNPay_Bill

Alter table [Order]
Add IsRefund int default 0

ALTER TABLE [Order]
DROP CONSTRAINT DF__Order__PaymentID__2739D489;

SELECT 
    name, 
    type_desc 
FROM sys.objects 
WHERE parent_object_id = OBJECT_ID('[Order]');

ALTER TABLE [Order]
DROP COLUMN PaymentID;

ALTER TABLE [Order]
ADD PaymentID NVARCHAR(8);

Alter table [order]
Add isRefund int default 0

drop table VNPay_Bill

CREATE TABLE VNPay_Bill (
    vnpTxnRef VARCHAR(255) PRIMARY KEY,  
    vnpAmount FLOAT NOT NULL,
    vnpPayDate VARCHAR(255) NOT NULL,      
    vnpTransactionStatus VARCHAR(50) NOT NULL,
	OrderId int

	Constraint FK_Order_ID FOREIGN KEY (OrderId) REFERENCES [Order](OrderId)
);


CREATE TABLE Refund (
	RefundID INT IDENTITY(1,1)  PRIMARY KEY,
    OrderId INT NOT NULL,
    RefundReason nvarchar(MAX) NOT NULL,
    RefundAmount DECIMAL(10, 2) NOT NULL,
    RefundStatus VARCHAR(50) NOT NULL DEFAULT 'PENDING', 
    created_at DATETIME DEFAULT GETDATE(),
   
	Constraint FK_Order_ID_Refund FOREIGN KEY (OrderId) REFERENCES [Order](OrderId)

);
ALTER TABLE Refund
Add RefundReasonImg nvarchar(100)