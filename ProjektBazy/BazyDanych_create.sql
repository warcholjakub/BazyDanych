-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-11 15:32:35.803

-- tables
-- Table: AttractionOrders
CREATE TABLE AttractionOrders (
    AttractionOrderID int  NOT NULL,
    OrderID int  NOT NULL,
    AttractionID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    ParticipantsCount int  NOT NULL,
    Price money  NOT NULL,
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
    AttracionName varchar(90)  NOT NULL,
    MaxParticipantsCount smallint  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Attractions_pk PRIMARY KEY  (AttractionID)
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    CompanyName varchar(100)  NULL,
    FistName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    City varchar(max)  NOT NULL,
    Country varchar(max)  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Participants
CREATE TABLE Participants (
    ParticipantID int  NOT NULL,
    OrderID int  NOT NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    AddDate datetime  NOT NULL,
    CONSTRAINT Participants_pk PRIMARY KEY  (ParticipantID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID int  NOT NULL,
    PaymentDate datetime  NOT NULL,
    Amount money  NOT NULL,
    OrderID int  NOT NULL,
    CONSTRAINT Payments_pk PRIMARY KEY  (PaymentID)
);

-- Table: Places
CREATE TABLE Places (
    PlaceID int  NOT NULL,
    City varchar(max)  NOT NULL,
    Country varchar(max)  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    CONSTRAINT Places_pk PRIMARY KEY  (PlaceID)
);

-- Table: TripOrders
CREATE TABLE TripOrders (
    OrderID int  NOT NULL,
    TripID int  NOT NULL,
    CustomerID int  NOT NULL,
    ParticipantsCount int  NOT NULL,
    OrderDate datetime  NOT NULL,
    Price money  NOT NULL,
    IsCancelled bit  NOT NULL,
    CONSTRAINT OrderID PRIMARY KEY  (OrderID)
);

-- Table: Trips
CREATE TABLE Trips (
    TripID int  NOT NULL,
    TripName varchar(90)  NOT NULL,
    DestinationCity varchar(max)  NOT NULL,
    DestinationCountry varchar(max)  NOT NULL,
    StartDate datetime  NOT NULL,
    EndDate datetime  NOT NULL,
    MaxParticipantsCount smallint  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Trips_pk PRIMARY KEY  (TripID)
);

-- foreign keys
-- Reference: AttractionOrders_Attractions (table: AttractionOrders)
ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_Attractions
    FOREIGN KEY (AttractionID)
    REFERENCES Attractions (AttractionID);

-- Reference: AttractionOrders_TripOrders (table: AttractionOrders)
ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_TripOrders
    FOREIGN KEY (OrderID)
    REFERENCES TripOrders (OrderID);

-- Reference: Attractions_Trips (table: Attractions)
ALTER TABLE Attractions ADD CONSTRAINT Attractions_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);

-- Reference: Orders_Customers (table: TripOrders)
ALTER TABLE TripOrders ADD CONSTRAINT Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Orders_Trips (table: TripOrders)
ALTER TABLE TripOrders ADD CONSTRAINT Orders_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);

-- Reference: Participants_Orders (table: Participants)
ALTER TABLE Participants ADD CONSTRAINT Participants_Orders
    FOREIGN KEY (OrderID)
    REFERENCES TripOrders (OrderID);

-- Reference: Payments_TripOrders (table: Payments)
ALTER TABLE Payments ADD CONSTRAINT Payments_TripOrders
    FOREIGN KEY (OrderID)
    REFERENCES TripOrders (OrderID);

-- Reference: do_nazwania_AttractionOrders (table: AttractionParticipants)
ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_AttractionOrders
    FOREIGN KEY (AttractionOrderID)
    REFERENCES AttractionOrders (AttractionOrderID);

-- Reference: do_nazwania_Participants (table: AttractionParticipants)
ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_Participants
    FOREIGN KEY (ParticipantID)
    REFERENCES Participants (ParticipantID);

-- End of file.

