-- Acumulado (Running Total)

WITH VendasMensais AS (
    SELECT
        d.CalendarYear          AS Ano
        ,d.MonthNumberOfYear    AS Mes
        ,SUM(f.SalesAmount)     AS Faturamento
    FROM dbo.FactInternetSales f
    INNER JOIN dbo.DimDate d ON f.OrderDateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT
    Ano
    ,Mes
    ,Faturamento
    ,SUM(Faturamento) OVER (
        PARTITION BY Ano
        ORDER BY Mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS AcumuladoAno
FROM VendasMensais
ORDER BY Ano, Mes;

-- Venda atual x venda anterior (mês a mês).

WITH VendasMensais AS (
    SELECT
        d.CalendarYear          AS Ano
        ,d.MonthNumberOfYear    AS Mes
        ,SUM(f.SalesAmount)     AS Faturamento
    FROM        dbo.FactInternetSales f
    INNER JOIN  dbo.DimDate d ON f.OrderDateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT
    *,
    LAG(Faturamento) OVER (ORDER BY Ano, Mes)                            AS MesAnterior,
    Faturamento - LAG(Faturamento) OVER (ORDER BY Ano, Mes)              AS Diferenca,
    (Faturamento - LAG(Faturamento) OVER (ORDER BY Ano, Mes)) * 100.0 /
        NULLIF(
            LAG(Faturamento) OVER (
                ORDER BY Ano, Mes
             ),
            0
        )                                                               AS VariacaoPercentual
FROM VendasMensais
ORDER BY Ano, Mes;