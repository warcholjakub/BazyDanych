INSERT INTO Countries (CountryName) VALUES
('Austria'),
('Czech Republic'),
('France'),
('Germany'),
('Greece'),
('Ireland'),
('Italy'),
('Japan'),
('Poland'),
('Spain'),
('Thailand'),
('United Kingdom'),
('Argentina'),
('Australia'),
('Belgium'),
('Brazil'),
('Canada'),
('China'),
('Denmark'),
('Egypt'),
('Finland'),
('Hungary'),
('India'),
('Israel'),
('Mexico'),
('Netherlands'),
('New Zealand'),
('Norway'),
('Portugal'),
('Russia'),
('Saudi Arabia'),
('South Africa'),
('South Korea'),
('Sweden'),
('Switzerland'),
('Turkey'),
('United States');

INSERT INTO Trips (TripName, DestinationCity, DestinationCountry, StartDate, EndDate, MaxParticipantsCount, Price, IsAvailable) VALUES
('Vienna City Tour', 'Vienna', 'Austria', '2024-06-15', '2024-06-20', 30, 500.00, 1),
('Prague Historic Walk', 'Prague', 'Czech Republic', '2024-07-10', '2024-07-15', 25, 450.00, 1),
('Paris Museum Excursion', 'Paris', 'France', '2024-08-05', '2024-08-10', 20, 600.00, 1),
('Berlin Wall Experience', 'Berlin', 'Germany', '2024-09-01', '2024-09-06', 35, 550.00, 1),
('Athens Ancient Sites', 'Athens', 'Greece', '2024-10-01', '2024-10-07', 40, 650.00, 1),
('Dublin Literary Tour', 'Dublin', 'Ireland', '2024-05-20', '2024-05-25', 15, 400.00, 1),
('Rome Culinary Adventure', 'Rome', 'Italy', '2024-11-15', '2024-11-20', 10, 700.00, 1),
('Tokyo Technology Tour', 'Tokyo', 'Japan', '2024-12-01', '2024-12-08', 50, 1000.00, 1),
('Krakow Cultural Exploration', 'Krakow', 'Poland', '2024-04-10', '2024-04-15', 30, 300.00, 1),
('Barcelona Art Journey', 'Barcelona', 'Spain', '2024-03-05', '2024-03-10', 25, 550.00, 1),
('Bangkok Temple Tour', 'Bangkok', 'Thailand', '2024-02-20', '2024-02-25', 45, 500.00, 1),
('London Royal Sights', 'London', 'United Kingdom', '2024-01-15', '2024-01-20', 20, 800.00, 1);

INSERT INTO Attractions (TripID, AttractionName, MaxParticipantsCount, Price) VALUES
(1, 'Schönbrunn Palace Tour', 30, 50.00),
(1, 'Vienna State Opera Visit', 30, 45.00),
(1, 'Belvedere Museum Excursion', 30, 40.00),

(2, 'Prague Castle Walk', 25, 30.00),
(2, 'Charles Bridge Photo Stop', 25, 25.00),
(2, 'Old Town Square Exploration', 25, 20.00),

(3, 'Louvre Museum Tour', 20, 70.00),
(3, 'Eiffel Tower Visit', 20, 60.00),
(3, 'Seine River Cruise', 20, 50.00),

(4, 'Berlin Wall Memorial', 35, 35.00),
(4, 'Brandenburg Gate Visit', 35, 25.00),
(4, 'Museum Island Tour', 35, 45.00),

(5, 'Acropolis of Athens', 40, 60.00),
(5, 'Parthenon Guided Tour', 40, 50.00),
(5, 'National Archaeological Museum', 40, 55.00),

(6, 'Trinity College Library', 15, 20.00),
(6, 'Guinness Storehouse Tour', 15, 30.00),
(6, 'Dublin Castle Visit', 15, 25.00),

(7, 'Colosseum Tour', 10, 80.00),
(7, 'Vatican Museums Visit', 10, 90.00),
(7, 'Roman Forum Walk', 10, 70.00),

(8, 'Tokyo Skytree Visit', 50, 100.00),
(8, 'Akihabara Technology Tour', 50, 80.00),
(8, 'Meiji Shrine Exploration', 50, 75.00),

(9, 'Wawel Castle Tour', 30, 40.00),
(9, 'Salt Mine Excursion', 30, 35.00),
(9, 'Old Town Market Square Visit', 30, 20.00),

(10, 'Sagrada Familia Visit', 25, 60.00),
(10, 'Park Güell Tour', 25, 50.00),
(10, 'Gothic Quarter Walk', 25, 40.00),

(11, 'Grand Palace Tour', 45, 50.00),
(11, 'Wat Arun Temple Visit', 45, 40.00),
(11, 'Floating Market Excursion', 45, 45.00),

(12, 'Tower of London Visit', 20, 70.00),
(12, 'Buckingham Palace Tour', 20, 65.00),
(12, 'British Museum Exploration', 20, 60.00);

INSERT INTO Customers (CompanyName, FirstName, LastName, City, Country, PostalCode, Phone)
VALUES
(NULL, 'Marek', 'Xardas', 'Berlin', 'Germany', '10115', '+4915791234567'),
(NULL, 'Lester', 'Goodman', 'London', 'United Kingdom', 'SW1A 1AA', '+442071234567'),
('Rebel Solutions', 'Lares', 'Rebel', 'Madrid', 'Spain', '28001', '+34911234567'),
('de la Vega Corp.', 'Diego', 'de la Vega', 'Rome', 'Italy', '00100', '+390612345678'),
('Stormeye Innovations', 'Milten', 'Stormeye', 'Paris', 'France', '75001', '+33123456789'),
('Kagan Smithing', 'Gorn', 'Kagan', 'Warsaw', 'Poland', '00-001', '+48123456789'),
('de Varel Manufacturing', 'Lester', 'de Varel', 'Athens', 'Greece', '105 64', '+302103456789'),
('Ironfist Holdings', 'Thorus', 'Ironfist', 'Bangkok', 'Thailand', '10100', '+6623456789'),
('Lukor Industries', 'Baal', 'Lukor', 'Prague', 'Czech Republic', '110 00', '+420234567890'),
('Guillame Enterprises', 'Corristo', 'Guillame', 'Vienna', 'Austria', '1010', '+431234567890');

INSERT INTO Orders (OrderDate, CustomerID, IsCancelled)
VALUES
('2024-05-01', 1, 0),
('2024-05-02', 2, 0),
('2024-05-03', 3, 0),
('2024-05-04', 4, 0),
('2024-05-05', 5, 0),
('2024-05-06', 6, 0),
('2024-05-07', 7, 0),
('2024-05-08', 8, 0),
('2024-05-09', 9, 0),
('2024-05-10', 10, 0);

INSERT INTO TripOrders (OrderID, TripID, OrderDate, ParticipantsCount, Price)
VALUES
(1, 1, '2024-05-01', 2, 1000),
(2, 2, '2024-05-02', 2, 900),
(3, 3, '2024-05-03', 1, 600),
(4, 4, '2024-05-04', 1, 550),
(5, 5, '2024-05-05', 1, 650),
(6, 6, '2024-05-06', 1, 400),
(7, 7, '2024-05-07', 1, 700),
(8, 10, '2024-05-08', 1, 550),
(9, 10, '2024-05-09', 1, 550),
(10, 10, '2024-05-10', 1, 550);

INSERT INTO AttractionOrders (OrderID, AttractionID, OrderDate, ParticipantsCount, Price)
VALUES
    (6, 16, '2024-05-13', 1, 20.00),
    (2, 5, '2024-05-14', 1, 25.00),
    (5, 13, '2024-05-15', 1, 60.00);

INSERT INTO Participants (FirstName, LastName, PassportID, City, Country, PostalCode, Phone)
VALUES
    ('Walter', 'White', 'AB123456', 'Vienna', 'Austria', '1010', '+43123456789'),
    ('Jesse', 'Pinkman', 'CD789012', 'Prague', 'Czech Republic', '11000', '+420987654321'),
    ('Skyler', 'White', 'EF345678', 'Paris', 'France', '75001', '+33192837465'),
    ('Hank', 'Schrader', 'GH901234', 'Berlin', 'Germany', '10115', '+49308475645'),
    ('Marie', 'Schrader', 'IJ567890', 'Athens', 'Greece', '10563', '+30213647382'),
    ('Saul', 'Goodman', 'KL123456', 'Dublin', 'Ireland', 'D01 E2P2', '+353384756192'),
    ('Gus', 'Fring', 'MN789012', 'Rome', 'Italy', '00184', '+39074619283'),
    ('Mike', 'Ehrmantraut', 'OP345678', 'Tokyo', 'Japan', '100-0001', '+813927364518'),
    ('Tuco', 'Salamanca', 'QR901234', 'Krakow', 'Poland', '31-001', '+48192736451'),
    ('Hector', 'Salamanca', 'ST567890', 'Barcelona', 'Spain', '08002', '+34638472819'),
    ('Walter Jr.', 'White', 'UV123456', 'London', 'United Kingdom', 'SW1A 1AA', '+441234567890'),
    ('Gale', 'Boetticher', 'WX789012', 'New York', 'United States', '10001', '+12128675309');

INSERT INTO TripParticipants(TripOrderID, ParticipantID)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (4, 6),
    (5, 7),
    (6, 8),
    (7, 9),
    (8, 10),
    (9, 11),
    (10, 12);

INSERT INTO AttractionParticipants(AttractionOrderID, ParticipantID)
VALUES
    (1, 8),
    (2, 3),
    (3, 7);

INSERT INTO Payments(OrderID, PaymentDate, Amount, PaymentMethod)
VALUES
    (1, '2024-05-20', 300, 'Cash');
