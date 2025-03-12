-- ?????????? ??????? Subscribers
INSERT INTO Subscribers (FullName, ContactInfo, IsActive, Debt) VALUES
('Ivan Petrenko', 'ivan.petrenko@example.com', 1, 0.00),
('Mariya Sydorenko', 'mariya.sydorenko@example.com', 1, 50.00),
('Oleksandr Kovalchuk', 'oleksandr.kovalchuk@example.com', 0, 25.50),
('Nataliya Lysenko', 'nataliya.lysenko@example.com', 1, 0.00);

-- ?????????? ??????? Services
INSERT INTO Services (ServiceName, ServiceType, Tariff) VALUES
('Basic Package', 'basic', 100.00),
('Extended Package', 'extended', 250.00),
('Premium Package', 'extended', 400.00);

-- ?????????? ??????? Orders
INSERT INTO Orders (SubscriberID, ServiceID, OrderDate, TotalAmount) VALUES
(1, 1, '2023-01-15', 100.00),
(2, 2, '2023-02-20', 250.00),
(3, 1, '2023-03-10', 100.00),
(4, 3, '2023-04-05', 400.00);

-- ?????????? ??????? Payments
INSERT INTO Payments (SubscriberID, PaymentDate, Amount, PaymentStatus) VALUES
(1, '2023-01-25', 100.00, 'success'),
(2, '2023-03-01', 200.00, 'success'),
(3, '2023-03-15', 50.00, 'success'),
(4, '2023-04-10', 400.00, 'success'),
(2, '2023-04-15', 50.00, 'failed'); -- ??????? ????????? ???????

-- ?????????? ??????? Movies
INSERT INTO Movies (Title, Category, ReleaseDate, PopularityRating) VALUES
('Fast X', 'Action', '2023-05-19', 8),
('Guardians of the Galaxy Vol. 3', 'Sci-Fi', '2023-05-05', 9),
('John Wick: Chapter 4', 'Action', '2023-03-24', 7),
('The Little Mermaid', 'Family', '2023-05-26', 6);

-- ?????????? ??????? MovieOrders
INSERT INTO MovieOrders (SubscriberID, MovieID, OrderDate, Price) VALUES
(1, 2, '2023-05-06', 50.00),
(2, 1, '2023-05-20', 60.00),
(3, 3, '2023-03-25', 45.00),
(4, 4, '2023-05-27', 55.00);

-- ?????????? ??????? TariffPlans
INSERT INTO TariffPlans (TariffName, BasePrice) VALUES
('Economy', 50.00),
('Standard', 150.00),
('Premium', 300.00);

-- ?????????? ??????? Reports
INSERT INTO Reports (ReportType, ReportDate) VALUES
('Daily Sales Report', '2023-05-28'),
('User Activity Report', '2023-05-28'),
('Payment Report', '2023-05-28');

-- ?????? ?????????? ?????

-- ????????? ????????? SubscriberID ? ???????? Orders, Payments ? MovieOrders
SELECT *
FROM Orders
WHERE SubscriberID NOT IN (SELECT SubscriberID FROM Subscribers);

SELECT *
FROM Payments
WHERE SubscriberID NOT IN (SELECT SubscriberID FROM Subscribers);

SELECT *
FROM MovieOrders
WHERE SubscriberID NOT IN (SELECT SubscriberID FROM Subscribers);

-- ????????? ????????? ServiceID ? ??????? Orders
SELECT *
FROM Orders
WHERE ServiceID NOT IN (SELECT ServiceID FROM Services);

-- ????????? ????????? MovieID ? ??????? MovieOrders
SELECT *
FROM MovieOrders
WHERE MovieID NOT IN (SELECT MovieID FROM Movies);

-- ????????? ????? Subscribers ? ??????????? Payments
SELECT
    s.SubscriberID,
    s.FullName,
    s.Debt,
    SUM(p.Amount) AS TotalPayments,
    s.Debt - SUM(p.Amount) AS RemainingDebt
FROM
    Subscribers s
LEFT JOIN
    Payments p ON s.SubscriberID = p.SubscriberID
WHERE p.PaymentStatus = 'success'
GROUP BY s.SubscriberID, s.FullName, s.Debt
HAVING s.Debt - SUM(p.Amount) > 0;

-- ????????? ??????????????? PaymentStatus
SELECT * FROM Payments WHERE PaymentStatus NOT IN ('success', 'failed');










