# Bazy danych

**Autorzy:**
Jakub Skwarczek,
Tymoteusz Szwech,
Jakub Warchoł

## 1. Wymagania i funkcje systemu

System wspomaga działalność firmy świadczącej usługi turystyczne. Oferuje on rezerwację różnorodnych wycieczek z określoną datą, limitem miejsc i ceną. Klienci mogą dodatkowo rezerwować usługi i atrakcje związane z daną wycieczką, które również mają swoje limity miejsc i ceny.

Klientami są zarówno osoby prywatne, jak i firmy, które dokonują rezerwacji i płatności za uczestników wycieczki. Przy rezerwacji klient podaje liczbę miejsc oraz wybiera dodatkowe usługi, a najpóźniej na tydzień przed wyjazdem musi podać imiona i nazwiska uczestników. Brak tych danych lub pełnej wpłaty skutkuje anulowaniem zamówienia.

Rezerwacje dodatkowych usług są możliwe tylko wraz z rezerwacją wycieczki. Zmiany w rezerwacji można wprowadzać do tygodnia przed wyjazdem. Po tym terminie zamówienie musi być w pełni opłacone i nie można wprowadzać żadnych zmian. System zapewnia przejrzystość i wygodę obsługi, wspierając efektywne zarządzanie wycieczkami i usługami dodatkowymi.

Lista funkcji jakie użytkownik może wykonywać w systemie.

1. Uzyskanie informacji na temat dostępnej oferty wraz z ilością miejsc oraz ceną.
2. Dodanie rezerwacji wraz z wymaganymi danymi.
3. Zmiana informacji na temat rezerwacji.
4. Anulowanie rezerwacji.
5. Rezerwacja usług/atrakcji w ramach jednej wycieczki.
6. Dodanie informacji na temat płatności.
7. Rejestracja i modyfikacja danych uczestników wycieczki.

## 2. Baza danych

### Schemat bazy danych

![Schemat bazy danych](../ProjektBazy/final.png)

### Opis poszczególnych tabel

Nazwa tabeli: **Countries**

- Opis: Tabela słownikowa zawierająca nazwy państw.

| Nazwa atrybutu | Typ         | Opis/Uwagi             |
| -------------- | ----------- | ---------------------- |
| CountryName    | varchar(30) | Nazwa państwa (**PK, FK**) |

- kod DDL

```sql
CREATE TABLE Countries (
    CountryName varchar(30)  NOT NULL,
    CONSTRAINT Countries_pk PRIMARY KEY  (CountryName)
);
```

Nazwa tabeli: **Trips**

- Opis: Tabela zawierająca informacje dotyczące dostępnych do zamówienia wycieczek.

| Nazwa atrybutu       | Typ         | Opis/Uwagi                                                                        |
| -------------------- | ----------- | --------------------------------------------------------------------------------- |
| TripID               | int         | Identyfikator wycieczki (**PK**)                                                  |
| TripName             | varchar(90) | Nazwa wycieczki                                                                   |
| DestinationCity      | varchar(30) | Miasto, do którego jest wycieczka                                                 |
| DestinationCountry   | varchar(30) | Kraj, do którego jest wycieczka (**FK**)                                          |
| StartDate            | date        | Początek wycieczki; **StartDate < EndDate** - data początku jest przed datą końca |
| EndDate              | date        | Koniec wycieczki                                                                  |
| MaxParticipantsCount | smallint    | Maksymalna liczba osób, które mogą uczestniczyć; **MaxParticipantsCount > 0**     |
| Price                | money       | Koszt wycieczki; **Price >= 0**                                                   |
| IsAvailable          | bit         | Czy wycieczka jest dostępna do zamówienia (0 - nie, 1 - tak); **DEFAULT - 0**     |

- kod DDL

```sql
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

ALTER TABLE Trips ADD CONSTRAINT Trips_Countries
    FOREIGN KEY (DestinationCountry)
    REFERENCES Countries (CountryName);
```

Nazwa tabeli: **Attractions**

- Opis: Tabela zawierająca listę dostępnych atrakcji dla wycieczek.

| Nazwa atrybutu       | Typ         | Opis/Uwagi                                                 |
| -------------------- | ----------- | ---------------------------------------------------------- |
| AttractionID         | int         | Identyfikator atrakcji (**PK**)                            |
| TripID               | int         | Identyfikator wycieczki (**FK**)                           |
| AttractionName       | varchar(90) | Nazwa atrakcji                                             |
| MaxParticipantsCount | smallint    | Maksymalna ilość uczestników; **MaxParticipantsCount > 0** |
| Price                | money       | Koszt atrakcji; **Price >= 0**                             |

- kod DDL

```sql
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

ALTER TABLE Attractions ADD CONSTRAINT Attractions_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);
```

Nazwa tabeli: **Orders**

- Opis: Tabela zawierająca najważniejsze informacje dotyczące głównego zamówienia tj. datę oraz identyfikator klienta.

| Nazwa atrybutu | Typ      | Opis/Uwagi                                                           |
| -------------- | -------- | -------------------------------------------------------------------- |
| OrderID        | int      | Identyfikator zamówienia (**PK**)                                    |
| OrderDate      | int      | Data złożenia zamówienia                                             |
| CustomerID     | datetime | Identyfikator klienta, który złożył zamówienie (**FK**)              |
| IsCancelled    | bit      | Czy zamówienie zostało anulowane (0 - nie, 1 - tak); **DEFAULT - 0** |

- kod DDL

```sql
CREATE TABLE Orders (
    OrderID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    CustomerID int  NOT NULL,
    IsCancelled bit  NOT NULL DEFAULT 0,
    CONSTRAINT Orders_pk PRIMARY KEY  (OrderID)
);

ALTER TABLE Orders ADD CONSTRAINT Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);
```

Nazwa tabeli: **Payments**

- Opis: Tabela zawierająca informacje dotyczące opłat: daty ich wykonania, kwoty, oraz tego jakiego zamówienia dotyczą.

| Nazwa atrybutu | Typ      | Opis/Uwagi                                             |
| -------------- | -------- | ------------------------------------------------------ |
| PaymentID      | int      | Identyfikator płatności (**PK**)                       |
| OrderID        | int      | Identyfikator zamówienia, które jest opłacane (**FK**) |
| PaymentDate    | datetime | Data dokonania płatności                               |
| Amount         | money    | Kwota płatności; **Amount >= 0**                       |

- kod DDL

```sql
CREATE TABLE Payments (
    PaymentID int  NOT NULL,
    OrderID int  NOT NULL,
    PaymentDate datetime  NOT NULL,
    Amount money  NOT NULL,
    CONSTRAINT Payments_AmountCheck CHECK (Amount >= 0),
    CONSTRAINT Payments_pk PRIMARY KEY  (PaymentID)
);

ALTER TABLE Payments ADD CONSTRAINT Payments_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);
```

Nazwa tabeli: **TripOrders**

- Opis: Tabela z zamówieniami wycieczek, zawierająca informacje między innymi na temat daty złożenia zamówienia.

| Nazwa atrybutu    | Typ      | Opis/Uwagi                                                         |
| ----------------- | -------- | ------------------------------------------------------------------ |
| TripOrderID       | int      | Identyfikator zamówienia wycieczki (**PK**)                        |
| OrderID           | int      | Identyfikator zamówienia (**FK**)                                  |
| TripID            | int      | Identyfikator wycieczki, która została zamówiona (**FK**)          |
| OrderDate         | datetime | Data, kiedy zostało złożone zamówienie                             |
| ParticipantsCount | int      | Liczba uczestników zamówionej wycieczki; **ParticipantsCount > 0** |
| Price             | money    | Cena zamówienia; **Price >= 0**                                    |

- kod DDL

```sql
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

ALTER TABLE TripOrders ADD CONSTRAINT TripOrders_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

ALTER TABLE TripOrders ADD CONSTRAINT TripOrders_Trips
    FOREIGN KEY (TripID)
    REFERENCES Trips (TripID);
```

Nazwa tabeli: **TripParticipants**

- Opis: Tabela zawierająca identyfikatory uczestników powiązane z konkretnymi zamówieniami wycieczek. Powiązani uczestnicy są na nie zapisani.

| Nazwa atrybutu | Typ | Opis/Uwagi                                      |
| -------------- | --- | ----------------------------------------------- |
| TripOrderID    | int | Identyfikator zamówienia wycieczki (**PK, FK**) |
| ParticipantID  | int | Identyfikator uczestnika (**PK, FK**)           |

- kod DDL

```sql
CREATE TABLE TripParticipants (
    TripOrderID int  NOT NULL,
    ParticipantID int  NOT NULL,
    CONSTRAINT TripParticipants_pk PRIMARY KEY  (TripOrderID,ParticipantID)
);

ALTER TABLE TripParticipants ADD CONSTRAINT TripParticipants_Participants
    FOREIGN KEY (ParticipantID)
    REFERENCES Participants (ParticipantID);

ALTER TABLE TripParticipants ADD CONSTRAINT TripParticipants_TripOrders
    FOREIGN KEY (TripOrderID)
    REFERENCES TripOrders (TripOrderID);
```

Nazwa tabeli: **AttractionOrders**

- Opis: Dodatkowe zamówienia atrakcji podpięte pod zamówienie.

| Nazwa atrybutu    | Typ      | Opis/Uwagi                                    |
| ----------------- | -------- | --------------------------------------------- |
| AttractionOrderID | int      | Identyfikator zamówienia atrakcji (**PK**)    |
| OrderID           | int      | Identyfikator zamówienia wycieczki (**FK**)   |
| AttractionID      | int      | Identyfikator atrakcji (**FK**)               |
| OrderDate         | datetime | Data, kiedy zostało złożone zamówienie        |
| ParticipantsCount | int      | Liczba uczestników; **ParticipantsCount > 0** |
| Price             | money    | Koszt zamówienia; **Price >= 0**              |

- kod DDL

```sql
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

ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_Attractions
    FOREIGN KEY (AttractionID)
    REFERENCES Attractions (AttractionID);

ALTER TABLE AttractionOrders ADD CONSTRAINT AttractionOrders_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);
```

Nazwa tabeli: **AttractionParticipants**

- Opis: Tabela zawierająca identyfikatory uczestników powiązane z konkretnymi zamówieniami atrakcji. Powiązani uczestnicy są na nie zapisani.

| Nazwa atrybutu    | Typ | Opis/Uwagi                                     |
| ----------------- | --- | ---------------------------------------------- |
| AttractionOrderID | int | Identyfikator zamówienia atrakcji (**PK, FK**) |
| ParticipantID     | int | Identyfikator uczestnika (**PK, FK**)          |

- kod DDL

```sql
CREATE TABLE AttractionParticipants (
    AttractionOrderID int  NOT NULL,
    ParticipantID int  NOT NULL,
    CONSTRAINT AttractionParticipants_pk PRIMARY KEY  (AttractionOrderID,ParticipantID)
);

ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_AttractionOrders
    FOREIGN KEY (AttractionOrderID)
    REFERENCES AttractionOrders (AttractionOrderID);

ALTER TABLE AttractionParticipants ADD CONSTRAINT do_nazwania_Participants
    FOREIGN KEY (ParticipantID)
    REFERENCES Participants (ParticipantID);
```

Nazwa tabeli: **Participants**

- Opis: Tabela zawierająca informacje na temat uczestników.

| Nazwa atrybutu | Typ         | Opis/Uwagi                                       |
| -------------- | ----------- | ------------------------------------------------ |
| ParticipantID  | int         | Identyfikator uczestnika (**PK**)                |
| FirstName      | varchar(20) | Imię uczestnika                                  |
| LastName       | varchar(30) | Nazwisko uczestnika                              |
| PassportID     | varchar(40) | Identyfikator paszportu uczesnika                |
| City           | varchar(30) | Miasto zamieszkania uczestnika                   |
| Country        | varchar(30) | Kraj, z którego pochodzi uczestnik               |
| PostalCode     | varchar(10) | Kod pocztowy                                     |
| Phone          | varchar(15) | Telefon kontaktowy do uczestnika                 |


- kod DDL

```sql
CREATE TABLE Participants (
    ParticipantID int  NOT NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    PassportID varchar(40)  NOT NULL,
    City varchar(30)  NOT NULL,
    Country varchar(30)  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NOT NULL,
    CONSTRAINT Participants_pk PRIMARY KEY  (ParticipantID)
);
```

Nazwa tabeli: **Customers**

- Opis: Tabela z listą klientów oraz ich danymi.

| Nazwa atrybutu | Typ          | Opis/Uwagi                             |
| -------------- | ------------ | -------------------------------------- |
| CustomerID     | int          | Identyfikator klienta (**PK**)         |
| CompanyName    | varchar(100) | Nazwa firmy klienta                    |
| FirstName      | varchar(20)  | Imię klienta / reprezentanta firmy     |
| LastName       | varchar(30)  | Nazwisko klienta / reprezentanta firmy |
| City           | varchar(30)  | Miasto, w którym znajduje się firma    |
| Country        | varchar(30)  | Kraj, w którym znajduje się firma      |
| PostalCode     | varchar(10)  | Kod pocztowy                           |
| Phone          | varchar(15)  | Telefon kontaktowy do klienta          |

- kod DDL

```sql
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
```

## 3. Widoki, procedury/funkcje, triggery

### Warunki integralności - triggery

Nazwa triggera: **ParticipantTripAssociationCheck**

- Opis: Przy dodawaniu uczestnika do atrakcji sprawdza czy dany uczestnik jest już powiązany z wycieczką, do której ta atrakcja jest przypisana.

```sql
CREATE TRIGGER ParticipantTripAssociationCheck
    ON AttractionParticipants
    AFTER INSERT
AS
BEGIN
    IF NOT EXISTS(SELECT 1
        FROM inserted
        JOIN AttractionOrders ON inserted.AttractionOrderID = AttractionOrders.AttractionOrderID
        JOIN TripParticipants ON inserted.ParticipantID = TripParticipants.ParticipantID
        JOIN TripOrders ON TripParticipants.TripOrderID = TripOrders.TripOrderID
        WHERE TripOrders.OrderID = AttractionOrders.OrderID
    )
    BEGIN
        THROW 50001, 'Participant is not associated with the trip for this attraction.', 1
    END
END;
```

### Widoki

Nazwa widoku: **TripParticipantsCount**

- Opis: Widok ten wyświetla sumę uczestników, która jest zapisana na konkretną wycieczkę. Oprócz tego podaje maksymalną liczbę uczestników na tę wycieczkę oraz ilość wolnych miejsc.

```sql
CREATE VIEW TripParticipantsCount
AS
SELECT Trips.TripID, StartDate AS TripDate, SUM(ParticipantsCount) AS SumParticipants,
       MaxParticipantsCount, MaxParticipantsCount - SUM(ParticipantsCount) as SlotsLeft
FROM TripOrders
JOIN Trips ON Trips.TripID = TripOrders.TripID
WHERE IsAvailable = 1
GROUP BY Trips.TripID, StartDate, MaxParticipantsCount;
```

| TripID | TripDate | SumParticipants | MaxParticipantsCount | SlotsLeft |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 2023-10-15 | 9 | 50 | 41 |
| 2 | 2023-11-05 | 8 | 40 | 32 |
| 3 | 2024-04-10 | 5 | 60 | 55 |
| 4 | 2024-05-01 | 7 | 55 | 48 |
| 5 | 2024-06-15 | 5 | 45 | 40 |
| 6 | 2024-07-10 | 6 | 50 | 44 |
| 7 | 2024-08-05 | 6 | 30 | 24 |
| 8 | 2024-09-10 | 8 | 35 | 27 |
| 9 | 2024-10-05 | 6 | 40 | 34 |
| 10 | 2024-11-01 | 7 | 50 | 43 |

Nazwa widoku: **AttractionParticipantsCount**

- Opis: Widok ten wyświetla sumę uczestników, która jest zapisana na konkretną atrakcję. Oprócz tego podaje maksymalną liczbę uczestników atrakcji, numer wycieczki, do której ta atrakcja jest przypisana, jak i liczbę pozostałych miejsc.

```sql
CREATE VIEW AttractionParticipantsCount
AS
SELECT Trips.TripID, Attractions.AttractionID, Trips.StartDate AS TripDate,
       SUM(ParticipantsCount) AS SumParticipants, Attractions.MaxParticipantsCount,
       Attractions.MaxParticipantsCount - SUM(ParticipantsCount) as SlotsLeft
FROM AttractionOrders
JOIN Attractions ON Attractions.AttractionID = AttractionOrders.AttractionID
JOIN Trips ON Trips.TripID = Attractions.TripID
WHERE IsAvailable = 1
GROUP BY Trips.TripID, Attractions.AttractionID, Trips.StartDate, Attractions.MaxParticipantsCount;
```

| TripID | AttractionID | TripDate | SumParticipants | MaxParticipantsCount | SlotsLeft |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | 2023-10-15 | 7 | 30 | 23 |
| 1 | 2 | 2023-10-15 | 7 | 40 | 33 |
| 1 | 3 | 2023-10-15 | 7 | 25 | 18 |
| 2 | 4 | 2023-11-05 | 10 | 35 | 25 |
| 2 | 5 | 2023-11-05 | 10 | 40 | 30 |
| 2 | 6 | 2023-11-05 | 10 | 30 | 20 |
| 3 | 7 | 2024-04-10 | 7 | 50 | 43 |
| 3 | 8 | 2024-04-10 | 7 | 45 | 38 |
| 3 | 9 | 2024-04-10 | 9 | 40 | 31 |
| 4 | 10 | 2024-05-01 | 11 | 50 | 39 |
| 4 | 11 | 2024-05-01 | 11 | 55 | 44 |
| 4 | 12 | 2024-05-01 | 7 | 50 | 43 |
| 5 | 13 | 2024-06-15 | 4 | 45 | 41 |
| 5 | 14 | 2024-06-15 | 5 | 40 | 35 |
| 5 | 15 | 2024-06-15 | 6 | 50 | 44 |
| 6 | 16 | 2024-07-10 | 3 | 50 | 47 |
| 6 | 17 | 2024-07-10 | 3 | 45 | 42 |
| 6 | 18 | 2024-07-10 | 1 | 50 | 49 |
| 7 | 19 | 2024-08-05 | 2 | 30 | 28 |
| 7 | 20 | 2024-08-05 | 2 | 25 | 23 |
| 7 | 21 | 2024-08-05 | 3 | 35 | 32 |
| 8 | 22 | 2024-09-10 | 3 | 35 | 32 |
| 8 | 23 | 2024-09-10 | 3 | 30 | 27 |
| 8 | 24 | 2024-09-10 | 1 | 35 | 34 |
| 9 | 25 | 2024-10-05 | 1 | 40 | 39 |
| 9 | 26 | 2024-10-05 | 1 | 35 | 34 |
| 9 | 27 | 2024-10-05 | 2 | 45 | 43 |
| 10 | 28 | 2024-11-01 | 2 | 50 | 48 |
| 10 | 29 | 2024-11-01 | 2 | 45 | 43 |

Nazwa widoku: **TotalPrice**

- Opis: Widok ten wyświetla sumę kosztów wszystkich zamówionych wycieczek oraz atrakcji dla konkretnego zamówienia. Wyświetla również sumę wszelkich opłat wykonanych w ramach tego zamówienie.

```sql
CREATE VIEW TotalPrice
AS
SELECT OrderID,
        (SELECT ISNULL(SUM(Price), 0)
         FROM TripOrders
         WHERE Orders.OrderID = TripOrders.OrderID) AS TripPrice,
        (SELECT ISNULL(SUM(Price), 0)
         FROM AttractionOrders
         WHERE Orders.OrderID = AttractionOrders.OrderID) AS AttractionPrice,
        (SELECT ISNULL(SUM(Amount), 0)
         FROM Payments
         WHERE Orders.OrderID = Payments.OrderID) AS Amount
FROM Orders;
```

| OrderID | TripPrice | AttractionPrice | Amount |
| :--- | :--- | :--- | :--- |
| 1 | 2000.0000 | 360.0000 | 100.0000 |
| 2 | 3600.0000 | 300.0000 | 0.0000 |
| 3 | 1500.0000 | 195.0000 | 1695.0000 |
| 4 | 5600.0000 | 420.0000 | 0.0000 |
| 5 | 3200.0000 | 350.0000 | 0.0000 |
| 6 | 1000.0000 | 180.0000 | 0.0000 |
| 7 | 4000.0000 | 190.0000 | 0.0000 |
| 8 | 3300.0000 | 510.0000 | 0.0000 |
| 9 | 1300.0000 | 185.0000 | 0.0000 |
| 10 | 2400.0000 | 500.0000 | 0.0000 |
| 11 | 4800.0000 | 400.0000 | 0.0000 |
| 12 | 3000.0000 | 190.0000 | 0.0000 |
| 13 | 5400.0000 | 510.0000 | 0.0000 |
| 14 | 1400.0000 | 85.0000 | 0.0000 |
| 15 | 3200.0000 | 300.0000 | 0.0000 |
| 16 | 2000.0000 | 180.0000 | 0.0000 |
| 17 | 2000.0000 | 190.0000 | 0.0000 |
| 18 | 3300.0000 | 510.0000 | 0.0000 |
| 19 | 1300.0000 | 185.0000 | 0.0000 |
| 20 | 2400.0000 | 500.0000 | 0.0000 |
| 21 | 4000.0000 | 720.0000 | 0.0000 |
| 22 | 5400.0000 | 270.0000 | 0.0000 |
| 23 | 3000.0000 | 390.0000 | 0.0000 |
| 24 | 1200.0000 | 105.0000 | 0.0000 |
| 25 | 2800.0000 | 0.0000 | 0.0000 |
| 26 | 6000.0000 | 0.0000 | 0.0000 |
| 27 | 1600.0000 | 0.0000 | 0.0000 |
| 28 | 2200.0000 | 0.0000 | 0.0000 |
| 29 | 5200.0000 | 0.0000 | 0.0000 |
| 30 | 3600.0000 | 0.0000 | 0.0000 |

Nazwa widoku: **SumCustomerOrders**

- Opis: Widok ten wyświetla liczbę zamówień złożonych przez każdego klienta.

```sql
CREATE VIEW SumCustomerOrders
AS
SELECT Customers.CustomerID, COUNT(OrderID) AS AllOrders
FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID;
```

| CustomerID | AllOrders |
| :--- | :--- |
| 1 | 4 |
| 2 | 3 |
| 3 | 3 |
| 4 | 3 |
| 5 | 3 |
| 6 | 2 |
| 7 | 3 |
| 8 | 3 |
| 9 | 3 |
| 10 | 3 |

Nazwa widoku: **UnpaidOrders**

- Opis: Wyświetla numery wszystkich zamówień (oraz identyfikator klienta, który je złożył), które nie zostały jeszcze w pełni opłacone oraz brakującą sumę do zapłacenia.

```sql
CREATE VIEW UnpaidOrders
AS
SELECT TotalPrice.OrderID, Orders.CustomerID,
       TripPrice + AttractionPrice - Amount AS LeftToPay
FROM TotalPrice
JOIN Orders ON Orders.OrderID = TotalPrice.OrderID
WHERE TripPrice + AttractionPrice - Amount > 0
```

| OrderID | CustomerID | LeftToPay |
| :--- | :--- | :--- |
| 1 | 1 | 2260.0000 |
| 2 | 2 | 3900.0000 |
| 4 | 4 | 6020.0000 |
| 5 | 5 | 3550.0000 |
| 6 | 1 | 1180.0000 |
| 7 | 7 | 4190.0000 |
| 8 | 8 | 3810.0000 |
| 9 | 9 | 1485.0000 |
| 10 | 10 | 2900.0000 |
| 11 | 2 | 5200.0000 |
| 12 | 3 | 3190.0000 |
| 13 | 6 | 5910.0000 |
| 14 | 4 | 1485.0000 |
| 15 | 5 | 3500.0000 |
| 16 | 7 | 2180.0000 |
| 17 | 1 | 2190.0000 |
| 18 | 8 | 3810.0000 |
| 19 | 9 | 1485.0000 |
| 20 | 10 | 2900.0000 |
| 21 | 1 | 4720.0000 |
| 22 | 6 | 5670.0000 |
| 23 | 3 | 3390.0000 |
| 24 | 2 | 1305.0000 |
| 25 | 4 | 2800.0000 |
| 26 | 7 | 6000.0000 |
| 27 | 5 | 1600.0000 |
| 28 | 8 | 2200.0000 |
| 29 | 9 | 5200.0000 |
| 30 | 10 | 3600.0000 |

Nazwa widoku: **CustomerParticipantList**

- Opis: Wyświetla listę wszystkich dodanych uczestników przez danego klienta w ramach danej wycieczki.

```sql
CREATE VIEW CustomerParticipantList
AS
SELECT Customers.CustomerID, Participants.ParticipantID, Orders.OrderID, Orders.OrderDate
FROM Customers
JOIN Orders on Customers.CustomerID = Orders.CustomerID
JOIN TripOrders on Orders.OrderID = TripOrders.OrderID
JOIN TripParticipants on TripOrders.TripOrderID = TripParticipants.TripOrderID
JOIN Participants on TripParticipants.ParticipantID = Participants.ParticipantID;
```

| CustomerID | ParticipantID | OrderID | OrderDate |
| :--- | :--- | :--- | :--- |
| 1 | 1 | 1 | 2024-04-01 10:15:00.000 |
| 1 | 2 | 1 | 2024-04-01 10:15:00.000 |
| 2 | 3 | 2 | 2024-04-02 11:30:00.000 |
| 2 | 4 | 2 | 2024-04-02 11:30:00.000 |
| 2 | 5 | 2 | 2024-04-02 11:30:00.000 |
| 3 | 6 | 3 | 2024-04-03 14:45:00.000 |
| 4 | 7 | 4 | 2024-04-04 09:00:00.000 |
| 4 | 8 | 4 | 2024-04-04 09:00:00.000 |
| 4 | 9 | 4 | 2024-04-04 09:00:00.000 |
| 4 | 10 | 4 | 2024-04-04 09:00:00.000 |
| 5 | 11 | 5 | 2024-04-05 13:15:00.000 |
| 5 | 12 | 5 | 2024-04-05 13:15:00.000 |
| 1 | 13 | 6 | 2024-04-06 16:00:00.000 |
| 7 | 14 | 7 | 2024-04-07 08:45:00.000 |
| 7 | 15 | 7 | 2024-04-07 08:45:00.000 |
| 8 | 16 | 8 | 2024-04-08 10:30:00.000 |
| 8 | 17 | 8 | 2024-04-08 10:30:00.000 |
| 8 | 18 | 8 | 2024-04-08 10:30:00.000 |
| 9 | 19 | 9 | 2024-04-09 12:00:00.000 |
| 10 | 20 | 10 | 2024-04-10 15:45:00.000 |
| 10 | 21 | 10 | 2024-04-10 15:45:00.000 |
| 2 | 22 | 11 | 2024-04-11 09:30:00.000 |
| 2 | 23 | 11 | 2024-04-11 09:30:00.000 |
| 2 | 24 | 11 | 2024-04-11 09:30:00.000 |
| 2 | 25 | 11 | 2024-04-11 09:30:00.000 |
| 3 | 26 | 12 | 2024-04-12 14:00:00.000 |
| 3 | 27 | 12 | 2024-04-12 14:00:00.000 |
| 6 | 28 | 13 | 2024-04-13 11:15:00.000 |
| 6 | 29 | 13 | 2024-04-13 11:15:00.000 |
| 6 | 30 | 13 | 2024-04-13 11:15:00.000 |
| 4 | 1 | 14 | 2024-04-14 13:45:00.000 |
| 5 | 2 | 15 | 2024-04-15 08:30:00.000 |
| 5 | 3 | 15 | 2024-04-15 08:30:00.000 |
| 7 | 4 | 16 | 2024-04-16 10:00:00.000 |
| 1 | 5 | 17 | 2024-04-17 12:45:00.000 |
| 1 | 6 | 17 | 2024-04-17 12:45:00.000 |
| 8 | 7 | 18 | 2024-04-18 14:30:00.000 |
| 8 | 8 | 18 | 2024-04-18 14:30:00.000 |
| 8 | 9 | 18 | 2024-04-18 14:30:00.000 |
| 9 | 10 | 19 | 2024-04-19 09:15:00.000 |
| 10 | 11 | 20 | 2024-04-20 11:00:00.000 |
| 10 | 12 | 20 | 2024-04-20 11:00:00.000 |
| 1 | 13 | 21 | 2024-04-21 10:45:00.000 |
| 1 | 14 | 21 | 2024-04-21 10:45:00.000 |
| 1 | 15 | 21 | 2024-04-21 10:45:00.000 |
| 1 | 16 | 21 | 2024-04-21 10:45:00.000 |
| 6 | 17 | 22 | 2024-04-22 12:15:00.000 |
| 6 | 18 | 22 | 2024-04-22 12:15:00.000 |
| 6 | 19 | 22 | 2024-04-22 12:15:00.000 |
| 3 | 20 | 23 | 2024-04-23 14:45:00.000 |
| 3 | 21 | 23 | 2024-04-23 14:45:00.000 |
| 2 | 22 | 24 | 2024-04-24 09:30:00.000 |
| 4 | 23 | 25 | 2024-04-25 11:00:00.000 |
| 4 | 24 | 25 | 2024-04-25 11:00:00.000 |
| 7 | 25 | 26 | 2024-04-26 13:30:00.000 |
| 7 | 26 | 26 | 2024-04-26 13:30:00.000 |
| 7 | 27 | 26 | 2024-04-26 13:30:00.000 |
| 5 | 28 | 27 | 2024-04-27 15:00:00.000 |
| 8 | 29 | 28 | 2024-04-28 16:30:00.000 |
| 8 | 30 | 28 | 2024-04-28 16:30:00.000 |
| 9 | 1 | 29 | 2024-04-29 09:45:00.000 |
| 9 | 2 | 29 | 2024-04-29 09:45:00.000 |
| 9 | 3 | 29 | 2024-04-29 09:45:00.000 |
| 9 | 4 | 29 | 2024-04-29 09:45:00.000 |
| 10 | 5 | 30 | 2024-04-30 11:15:00.000 |
| 10 | 6 | 30 | 2024-04-30 11:15:00.000 |
| 10 | 7 | 30 | 2024-04-30 11:15:00.000 |

### Procedury

Nazwa procedury: **AllUnpaidByCustomer**

- Opis: Wyświetla wszystkie numery wycieczek, które nie zostały opłacone przez danego klienta, wraz z brakującą kwotą.

```sql
CREATE PROCEDURE AllUnpaidByCustomer @CustomerID int
AS
SELECT OrderID, LeftToPay
FROM UnpaidOrders
WHERE CustomerID = @CustomerID
```

Dla *CustomerID* równego 1:

| OrderID | LeftToPay |
| :--- | :--- |
| 1 | 2260.0000 |
| 6 | 1180.0000 |
| 17 | 2190.0000 |
| 21 | 4720.0000 |

Nazwa procedury: **ListTripParticipants**

- Opis: Wylistowuje dane wszystkich uczestników, którzy są zapisani do konkretnego zamówienia.

```sql
CREATE PROCEDURE ListTripParticipants @OrderID int
AS
SELECT OrderID, ParticipantID
FROM CustomerParticipantList
WHERE OrderID = @OrderID;
```

Dla *OrderID* równego 1:

| OrderID | ParticipantID |
| :--- | :--- |
| 1 | 1 |
| 1 | 2 |

Nazwa procedury: **TripsWithXSlotsLeft**

- Opis: Wyświetla wszystkie dostępne wycieczki, w ramach których jest conajmniej podana liczba wolnych miejsc.

```sql
CREATE PROCEDURE TripsWithXSlotsLeft @SlotsLeft int
AS
SELECT TripID, TripDate
FROM TripParticipantsCount
WHERE SlotsLeft >= @SlotsLeft
```

Dla *SlotsLeft* równego 40:

| TripID | TripDate |
| :--- | :--- |
| 1 | 2023-10-15 |
| 3 | 2024-04-10 |
| 4 | 2024-05-01 |
| 5 | 2024-06-15 |
| 6 | 2024-07-10 |
| 10 | 2024-11-01 |

Nazwa procedury: **TripsTo**

- Opis: Wylistowuje numery oraz nazwy wycieczek odbywających się w danym kraju.

```sql
CREATE PROCEDURE TripsTo @Country varchar(30)
AS
SELECT TripID, TripName
FROM Trips
WHERE DestinationCountry = @Country;
```

Dla *Country* równego 'Poland':

| TripID | TripName |
| :--- | :--- |
| 1 | Malowniczy Kraków |

## 4. Inne

