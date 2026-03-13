-- Receita por Região

-- Por Continente

SELECT
	t.SalesTerritoryGroup			AS Continente
	,ROUND(SUM(V.salesamount),2)	AS Receita
FROM FactInternetSales AS V
JOIN DimSalesTerritory AS T ON V.SalesTerritoryKey = T.SalesTerritoryKey
GROUP BY t.SalesTerritoryGroup

-- Por Pais

SELECT
	t.SalesTerritoryCountry		 AS Pais
	,ROUND(SUM(V.salesamount),2) AS Receita
FROM FactInternetSales AS V
JOIN DimSalesTerritory AS T ON V.SalesTerritoryKey = T.SalesTerritoryKey
GROUP BY t.SalesTerritoryCountry