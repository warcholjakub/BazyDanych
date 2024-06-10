### AllUnpaidByCustomer

SELECT * FROM UnpaidOrders

EXEC AllUnpaidByCustomer 4

### AssociateParticipantWithTrip

    // Nie da się bo wycieczka jest za 4 dni
    EXEC AssociateParticipantWithTrip 1, 1

    SELECT TripOrderID, Trips.TripID, StartDate
    FROM TripOrders
    JOIN Trips ON TripOrders.TripID = Trips.TripID

    // Nie da się bo taki uczestnik nie istnieje
    EXEC AssociateParticipantWithTrip 40, 1

    // Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithTrip 1, 1