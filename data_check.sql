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