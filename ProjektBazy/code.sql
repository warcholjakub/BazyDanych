-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-14 10:50:39.117

-- tables
-- Table: AttractionOrders
CREATE TABLE AttractionOrders (
    AttractionOrderID int  NOT NULL,
    OrderID int  NOT NULL,
    AttractionID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    ParticipantsCount int  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT AttractionOrders_PriceCheck CHECK (Price >= 0),
    CONSTRAINT AttractionOrders_PCCheck CHECK (ParticipantsCount > 0),
    CONSTRAINT AttractionOrders_pk PRIMARY KEY  (AttractionOrderID)
);

-- Table: AttractionParticipants
CREATE TABLE AttractionParticipants (
    AttractionOrderID int  NOT NULL,
    ParticipantID int  NOT NULL,
    CONSTRAINT AttractionParticipants_pk PRIMARY KEY  (AttractionOrderID,ParticipantID)
);

-- Table: Attractions
CREATE TABLE Attractions (
    AttractionID int  NOT NULL,
    TripID int  NOT NULL,
    AttractionName varchar(90)  NOT NULL,
    MaxParticipantsCount smallint  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Attractions_PriceCheck CHECK (Price >= 0),
    CONSTRAINT Attractions_MPCheck CHECK (MaxParticipantsCount > 0),
    CONSTRAINT Attractions_pk PRIMARY KEY  (AttractionID)
);

-- Table: Countries
CREATE TABLE Countries (
    CountryName varchar(30)  NOT NULL,
    CONSTRAINT Countries_pk PRIMARY KEY  (CountryName)
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    CompanyName varchar(100)  NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    City varchar(30)  NOT NULL,
    Country varchar(30)  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    CustomerID int  NOT NULL,
    IsCancelled bit  NOT NULL DEFAULT 0,
    CONSTRAINT Orders_pk PRIMARY KEY  (OrderID)
);

-- Table: Participants
CREATE TABLE Participants (
    ParticipantID int  NOT NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    AddDate datetime  NOT NULL DEFAULT GETDATE(),
    CONSTRAINT Participants_pk PRIMARY KEY  (ParticipantID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID int  NOT NULL,
    OrderID int  NOT NULL,
    PaymentDate datetime  NOT NULL,
    Amount money  NOT NULL,
    CONSTRAINT Payments_AmountCheck CHECK (Amount >= 0),
    CONSTRAINT Payments_pk PRIMARY KEY  (PaymentID)
);

-- Table: TripOrders
CREATE TABLE TripOrders (
    TripOrderID int  NOT NULL,
    OrderID int  NOT NULL,
    TripID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    ParticipantsCount int  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT TripOrders_PriceCheck CHECK (Price >= 0),
    CONSTRAINT TripOrders_ParticipantCountCheck CHECK (ParticipantsCount > 0),
    CONSTRAINT OrderID PRIMARY KEY  (TripOrderID)
);

-- Table: TripParticipants
CREATE TABLE TripParticipants (
    TripOrderID int  NOT NULL,
    ParticipantID int  NOT NULL,
    CONSTRAINT TripParticipants_pk PRIMARY KEY  (TripOrderID,ParticipantID)
);

-- Table: Trips
CREATE TABLE Trips (
    TripID int  NOT NULL,
    TripName varchar(90)  NOT NULL,
    DestinationCity varchar(30)  NOT NULL,
    DestinationCountry varchar(30)  NOT NULL,
    StartDate date  NOT NULL,
    EndDate date  NOT NULL,
    MaxParticipantsCount smallint  NOT NULL,
    Price money  NOT NULL,
    IsAvailable bit  NOT NULL DEFAULT 0,
    CONSTRAINT Trips_DateCheck CHECK (StartDate < EndDate),
    CONSTRAINT Trips_PriceCheck CHECK (Price >= 0),
    CONSTRAINT Trips_MPCheck CHECK (MaxParticipantsCount > 0),
    CONSTRAINT Trips_pk PRIMARY KEY  (TripID)
);

-- foreign keys
-- Reference: AttractionOrders_Attractions (table: AttractionOrders)
ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_Attractions
    FOREIGN KEY (AttractionID)
    REFERENCES Attractions (AttractionID);

-- Reference: AttractionOrders_Orders (table: AttractionOrders)
ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Attractions_Trips (table: Attractions)
ALTER TABLE Attractions ADD CONSTRAINT Attractions_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);

-- Reference: Orders_Customers (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Payments_Orders (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT Payments_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: TripOrders_Orders (table: TripOrders)
ALTER TABLE TripOrders ADD CONSTRAINT TripOrders_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: TripOrders_Trips (table: TripOrders)
ALTER TABLE TripOrders ADD CONSTRAINT TripOrders_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);

-- Reference: TripParticipants_Participants (table: TripParticipants)
ALTER TABLE TripParticipants ADD CONSTRAINT TripParticipants_Participants
    FOREIGN KEY (ParticipantID)
    REFERENCES Participants (ParticipantID);

-- Reference: TripParticipants_TripOrders (table: TripParticipants)
ALTER TABLE TripParticipants ADD CONSTRAINT TripParticipants_TripOrders
    FOREIGN KEY (TripOrderID)
    REFERENCES TripOrders (TripOrderID);

-- Reference: do_nazwania_AttractionOrders (table: AttractionParticipants)
ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_AttractionOrders
    FOREIGN KEY (AttractionOrderID)
    REFERENCES AttractionOrders (AttractionOrderID);

-- Reference: do_nazwania_Participants (table: AttractionParticipants)
ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_Participants
    FOREIGN KEY (ParticipantID)
    REFERENCES Participants (ParticipantID);

-- End of file.

