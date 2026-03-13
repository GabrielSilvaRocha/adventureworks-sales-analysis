-- Receita Total

SELECT
	ROUND(SUM(SalesAmount),2)	AS ReceitaTotal
FROM FactInternetSales

-- Ticket Medio

SELECT 
    ROUND(SUM(SalesAmount) / COUNT(DISTINCT SalesOrderNumber),2) AS TicketMedio
FROM FactInternetSales