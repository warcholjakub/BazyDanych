-- ### AllUnpaidByCustomer

    SELECT * FROM UnpaidOrders

    EXEC AllUnpaidByCustomer 4

    EXEC AllUnpaidByCustomer 1

    SELECT Price
    FROM TripOrders
    WHERE OrderID = 1
    
    SELECT Amount
    FROM Payments
    WHERE OrderID = 1

-- ### Payments

    INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod)
         VALUES (1, N'2024-05-29 13:29:08.000', 250.0000, N'Unsupported payment method')
    
    INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod)
         VALUES (1, N'2024-05-29 13:29:08.000', -250.0000, N'Card')

-- ### Trips

    INSERT INTO Trips (TripName, DestinationCity, DestinationCountry, StartDate, EndDate, MaxParticipantsCount, Price)
         VALUES ('test', 'City', 'Nonexistent country', N'2024-12-20', N'2024-12-27', 10, 300)
    
    INSERT INTO Trips (TripName, DestinationCity, DestinationCountry, StartDate, EndDate, MaxParticipantsCount, Price)
         VALUES ('test', 'Warsaw', 'Poland', N'2024-12-27', N'2024-12-20', 10, 300)

-- ### BuyTrip

    -- Nie można bo wycieczka jest za 4 dni
    EXEC BuyTrip 1,1,1,1

    -- Nieistniejący OrderID (utworzy nowy Order)
    EXEC BuyTrip 25, 10, 5, 3

    SELECT *
    FROM Orders
    WHERE OrderID = 25

    SELECT TripID
    FROM TripOrders
    WHERE OrderID = 25

    -- Za duży ParticipantsCount
    EXEC BuyTrip 15, 10, 3000, 3

    -- Nieistniejący TripID
    EXEC BuyTrip 15, 300, 5, 3

    -- Niedostępny Trip
    EXEC BuyTrip 15, 13, 5, 3

    -- Brak miejsc
    EXEC BuyTrip 15, 5, 100, 3

-- ### BuyAttraction

    -- Brak miejsc
    EXEC BuyAttraction 5, 13, 30

    -- Za duży ParticipantsCount
    EXEC BuyAttraction 6, 16, 3000

    -- Brak wykupionej odpowiedniej wycieczki (trigger AttractionOrderCheck)
    EXEC BuyAttraction 12, 4, 3

    -- Powiązana wycieczka jest niedostępna
    EXEC BuyAttraction 12, 1, 3

    -- Poprawne zamówienie
    EXEC BuyAttraction 12, 36, 3

-- ### AssociateParticipantWithTrip

    -- Nie da się bo wycieczka jest za 4 dni
    EXEC AssociateParticipantWithTrip 1, 1

    SELECT TripOrderID, Trips.TripID, StartDate
    FROM TripOrders
    JOIN Trips ON TripOrders.TripID = Trips.TripID

    -- Nie da się bo taki uczestnik nie istnieje
    EXEC AssociateParticipantWithTrip 40, 24

    -- Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithTrip 1, 24

    -- Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithTrip 1, 13

    -- Normalnie się da
    EXEC AssociateParticipantWithTrip 10, 22

-- ### AssociateParticipantWithAttraction

    -- Nie da się bo wycieczka jest za 4 dni
    EXEC AssociateParticipantWithAttraction 1, 1

    -- Nie da się bo taki uczestnik nie istnieje
    EXEC AssociateParticipantWithAttraction 40, 9

    -- Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithAttraction 7, 9

    -- Uczestnik nie uczestniczy w głównej wycieczce (trigger ParticipantTripAssociationCheck)
    EXEC AssociateParticipantWithAttraction 1, 9

    -- Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithAttraction 1, 2

    -- Normalnie się da
    EXEC AssociateParticipantWithAttraction 1, 4

-- ### CancelOrder

    EXEC CancelOrder 23

    SELECT * FROM Orders
    WHERE OrderID = 23

-- ### ChangeAvailability

    EXEC ChangeAvailability 1, 0

    SELECT * FROM Trips WHERE TripID = 1

    EXEC ChangeAvailability 1, 1

-- ### AddParticipant

    EXEC AddParticipant 'Jan', 'Kowalski', '12345', 'Krakow', 'Polska', 'postal', '883111111' 
