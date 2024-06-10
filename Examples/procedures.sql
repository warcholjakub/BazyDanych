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
    EXEC AssociateParticipantWithTrip 1, 12

    // Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithTrip 1, 1

    // Normalnie się da
    EXEC AssociateParticipantWithTrip 2, 12

### AssociateParticipantWithAttraction

    // Nie da się bo wycieczka jest za 4 dni
    EXEC AssociateParticipantWithAttraction 1, 1

    // Nie da się bo taki uczestnik nie istnieje
    EXEC AssociateParticipantWithAttraction 40, 1

    // Nie da się bo taki uczestnik już uczestniczy
    EXEC AssociateParticipantWithAttraction 8, 1

    // Nie da się bo już jest maksymalna liczba uczestników
    EXEC AssociateParticipantWithAttraction 1, 1

    // Normalnie się da
    EXEC AssociateParticipantWithAttraction 1, 4

### BuyTrip

    // Nie można bo wycieczka jest za 4 dni
    EXEC BuyTrip 1,1,1,1

### BuyAttraction