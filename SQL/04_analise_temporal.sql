-- Receita por Ano

Select
	D.CalendarYear					AS Ano
	,round(sum(V.SalesAmount),2)	AS Receita
FROM FactInternetSales	V
JOIN DimDate			D ON V.OrderDateKey = D.DateKey
GROUP BY D.CalendarYear
ORDER BY D.CalendarYear	

-- Crescimento mensal

SELECT
    D.CalendarYear					AS Ano
    ,D.MonthNumberOfYear			AS Mes
    ,ROUND(SUM(F.SalesAmount),2)	AS Receita
FROM FactInternetSales F
JOIN DimDate D ON F.OrderDateKey = D.DateKey
GROUP BY D.CalendarYear, D.MonthNumberOfYear
ORDER BY D.CalendarYear, D.MonthNumberOfYear