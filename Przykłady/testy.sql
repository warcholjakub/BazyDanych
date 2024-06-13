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

    INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod)
         VALUES (4, 1, N'2024-05-29 13:29:08.000', 250.0000, N'Unsupported payment method')
    
    INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod)
         VALUES (4, 1, N'2024-05-29 13:29:08.000', -250.0000, N'Card')

-- ### Trips

    INSERT INTO Trips (TripID, TripName, DestinationCity, DestinationCountry, StartDate, EndDate, MaxParticipantsCount, Price)
         VALUES (14, 1, 'City', 'Nonexistent country', N'2024-12-20', N'2024-12-27', 10, 300)
    
    INSERT INTO Trips (TripID, TripName, DestinationCity, DestinationCountry, StartDate, EndDate, MaxParticipantsCount, Price)
         VALUES (14, 1, 'Warsaw', 'Poland', N'2024-12-27', N'2024-12-20', 10, 300)

-- ### BuyTrip

    -- Nie można bo wycieczka jest za 4 dni
    EXEC BuyTrip 1,1,1,1

    -- Nieistniejący OrderID (utworzy nowy Order)
    EXEC BuyTrip 15, 10, 5, 3

    SELECT *
    FROM Orders
    WHERE OrderID = 15

    SELECT TripID
    FROM TripOrders
    WHERE OrderID = 15

    -- Za duży ParticipantsCount
    EXEC BuyTrip 15, 10, 3000, 3

    -- Nieistniejący TripID
    EXEC BuyTrip 15, 300, 5, 3

    -- Niedostępny Trip
    EXEC BuyTrip 15, 13, 5, 3

    -- Brak miejsc
    EXEC BuyTrip 15, 5, 5, 3

-- ### BuyAttraction

    -- Brak miejsc
    EXEC BuyAttraction 5, 13, 3

    -- Za duży ParticipantsCount
    EXEC BuyAttraction 6, 16, 3000

    -- Brak wykupionej odpowiedniej wycieczki (trigger AttractionOrderCheck)
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
    EXEC AssociateParticipantWithTrip 40, 1

    -- Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithTrip 1, 12

    -- Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithTrip 1, 1

    -- Normalnie się da
    EXEC AssociateParticipantWithTrip 2, 12

-- ### AssociateParticipantWithAttraction

    -- Nie da się bo wycieczka jest za 4 dni
    EXEC AssociateParticipantWithAttraction 1, 1

    -- Nie da się bo taki uczestnik nie istnieje
    EXEC AssociateParticipantWithAttraction 40, 1

    -- Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithAttraction 8, 1

    -- Uczestnik nie uczestniczy w głównej wycieczce (trigger ParticipantTripAssociationCheck)
    EXEC AssociateParticipantWithAttraction 8, 3

    -- Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithAttraction 1, 1

    -- Normalnie się da
    EXEC AssociateParticipantWithAttraction 1, 4
