CREATE TABLE City(
	CityId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	GeoLocation POINT
)

CREATE TABLE Job(
	JobId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
)


CREATE TABLE FoodCategories(
	FoodCategoryId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
)

CREATE TABLE Customer(
	CustomerId SERIAL PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL
)

CREATE TABLE Restaurant(
	RestaurantId SERIAL PRIMARY KEY,
	CityId INT REFERENCES City(CityId),
	Capacity INT,
	Open_time TIME,
	Close_time TIME,
	Adress VARCHAR(100) NOT NULL
)

CREATE TABLE Employee(
	EmployeeId SERIAL PRIMARY KEY,
	RestaurantId INT REFERENCES Restaurant(RestaurantId),
	JobId INT REFERENCES Job(JobId),
	DateOfBirth Date,
	Has_DriversLiscence Bool,
	Name VARCHAR(50),
	CityId INT REFERENCES City(CityId)
)


CREATE TABLE Food(
	FoodId SERIAL PRIMARY KEY,
	Name VARCHAR(50),
	FoodCategoryId INT REFERENCES FoodCategories(FoodCategoryId),
	Caloric_Value INT
)


CREATE TABLE Restaurant_Food(
	RestaurantId INT REFERENCES Restaurant(RestaurantId),
	FoodId INT REFERENCES Food(FoodId),
	Is_Available BOOL,
	Price FLOAT
)

ALTER TABLE Restaurant_Food
	ADD PRIMARY KEY(RestaurantId, FoodId)


CREATE TABLE Orders(
	OrderId SERIAL PRIMARY KEY,
	RestaurantId INT REFERENCES Restaurant(RestaurantId),
	CustomerId INT REFERENCES Customer(CustomerId),
	Total FLOAT,
	Is_Delivery BOOL
)

ALTER TABLE Orders
	ADD COLUMN DateOfOrder Date 



CREATE TABLE Order_Items(
	OrderId INT REFERENCES Orders(OrderId),
	FoodId INT REFERENCES Food,
	Amount INT
)


CREATE TABLE Deliveries(
	OrderId INT REFERENCES Orders(OrderId),
	EmployeeId INT REFERENCES Employee(EmployeeId),
	TimeOfDelivery TIME,
	SpecialRequest VARCHAR(200),
	Adress VARCHAR(100),
	PRIMARY KEY(OrderId, EmployeeId)
)


CREATE TABLE Delivery_Review(
	DeliveryReviewId SERIAL PRIMARY KEY,
	Review INT,
	Comment VARCHAR(200)
)
--Add constraint review must be between 1 and 5

CREATE TABLE Food_Review(
	FoodReviewId SERIAL PRIMARY KEY,
	FoodId INT REFERENCES Food(FoodId),
	Rating INT,
	Comment VARCHAR(200),
	CustomerId INT REFERENCES Customer(CustomerId)
)









