# Bazy danych

**Autorzy:**
Jakub Skwarczek,
Tymoteusz Szwech,
Jakub Warchoł

## 1. Wymagania i funkcje systemu

Lista funkcji jakie użytkownik może wykonywać w systemie.

1. Uzyskanie informacji na temat dostępnej oferty wraz z ilością miejsc oraz ceną.
2. Dodanie rezerwacji wraz z wymaganymi danymi.
3. Zmiana informacji na temat rezerwacji.
4. Anulowanie rezerwacji.
5. Rezerwacja usług/atrakcji w ramach jednej wycieczki.
6. Dodanie informacji na temat płatności.
7. Rejestracja danych uczestników wycieczki. _(**Pytanie:** Czy można zmieniać dane uczestników przed deadlinem?)_

## 2. Baza danych

### Schemat bazy danych

<img src="../ProjektBazy/schemat.png">

### Opis poszczególnych tabel

Nazwa tabeli: **Payments**

- Opis: Tabela zawierająca informacje dotyczące opłat: daty ich wykonania, kwoty, oraz tego jakiego zamówienia dotyczą.

| Nazwa atrybutu | Typ      | Opis/Uwagi                                    |
| -------------- | -------- | --------------------------------------------- |
| PaymentID      | int      | Identyfikator płatności                       |
| PaymentDate    | datetime | Data dokonania płatności                      |
| Amount         | money    | Kwota płatności                               |
| OrderID        | int      | Identyfikator zamówienia, które jest opłacane |

- kod DDL

```sql
CREATE TABLE Payments (
    PaymentID int  NOT NULL,
    PaymentDate datetime  NOT NULL,
    Amount money  NOT NULL,
    OrderID int  NOT NULL,
    CONSTRAINT Payments_pk PRIMARY KEY  (PaymentID)
);
```

Nazwa tabeli: **TripOrders**

- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu    | Typ      | Opis/Uwagi                                       |
| ----------------- | -------- | ------------------------------------------------ |
| OrderID           | int      | Identyfikator zamówienia                         |
| TripID            | int      | Identyfikator wycieczki, która została zamówiona |
| CustomerID        | int      | Identyfikator klienta składającego zamówienie    |
| ParticipantsCount | int      | Liczba uczestników zamówionej wycieczki          |
| OrderDate         | datetime | Data, kiedy zostało wykonane zamówienie          |
| Price             | money    | Cena zamówienia                                  |
| IsCancelled       | bit      | Czy zamówienie jest anulowane                    |

- kod DDL

```sql
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
```

Nazwa tabeli: **Participants**

- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ         | Opis/Uwagi                                                  |
| -------------- | ----------- | ----------------------------------------------------------- |
| ParticipantID  | int         | Identyfikator uczestnika                                    |
| OrderID        | int         | Identyfikator zamówienia, do którego wpisany jest uczestnik |
| FirstName      | varchar(20) | Imię uczestnika                                             |
| LastName       | varchar(30) | Nazwisko uczestnika                                         |
| AddDate        | datetime    | Data dodania uczestnika do zamówienia                       |

- kod DDL

```sql
CREATE TABLE Participants (
    ParticipantID int  NOT NULL,
    OrderID int  NOT NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    AddDate datetime  NOT NULL,
    CONSTRAINT Participants_pk PRIMARY KEY  (ParticipantID)
);
```

Nazwa tabeli: **Customers**

- Opis: (opis tabeli, komentarz)

| Nazwa atrybutu | Typ          | Opis/Uwagi                          |
| -------------- | ------------ | ----------------------------------- |
| CustomerID     | int          | Identyfikator klienta               |
| CompanyName    | varchar(100) | Nazwa firmy klienta                 |
| FirstName      | varchar(20)  | Imię klienta                        |
| LastName       | varchar(30)  | Nazwisko klienta                    |
| City           | varchar(max) | Miasto, w którym znajduje się firma |
| Country        | varchar(max) | Kraj, w którym znajduje się firma   |
| PostalCode     | varchar(10)  | Kod pocztowy                        |
| Phone          | varchar(15)  | Telefon kontaktowy do klienta       |

- kod DDL

```sql
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    CompanyName varchar(100)  NULL,
    FirstName varchar(20)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    City varchar(max)  NOT NULL,
    Country varchar(max)  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);
```

## 3. Widoki, procedury/funkcje, triggery

## 4. Inne
