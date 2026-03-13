-- Top 10 produtos com maior receita

-- Versão com CTE

WITH MaisVendidos AS(
SELECT
	P.EnglishProductName			AS Produto
	,ROUND(SUM(V.SalesAmount),2)	AS Receita 
FROM FactInternetSales	AS V
JOIN DimProduct			AS P ON V.ProductKey = P.ProductKey
GROUP BY V.ProductKey,P.EnglishProductName
),
Filtro AS(
SELECT 
	*
	,RANK() OVER(ORDER BY receita DESC)	AS Ranking
from MaisVendidos
)
SELECT 
	*
FROM Filtro
WHERE Ranking between 1 and 10

-- Versão simplificada

SELECT TOP(10)
	P.EnglishProductName			AS Produto
	,ROUND(SUM(V.SalesAmount),2)	AS Receita 
FROM FactInternetSales	AS V
JOIN DimProduct			AS P ON V.ProductKey = P.ProductKey
GROUP BY V.ProductKey,P.EnglishProductName
order by Receita DESC

-- Receita por Categoria

SELECT
	C.EnglishProductCategoryName	AS Categoria
	,ROUND(SUM(V.SalesAmount),2)	AS Receita
FROM FactInternetSales		AS V
JOIN DimProduct				AS P ON V.ProductKey			= P.ProductKey
JOIN DimProductSubcategory	AS S ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
JOIN DimProductCategory		AS C ON S.ProductCategoryKey	= C.ProductCategoryKey
GROUP BY C.EnglishProductCategoryName
ORDER BY Receita DESC