
-- dimension population [gold].[d_tempo] (Janeiro/2001 a Dezembro/2035)

-- CTE Recursiva para gerar a sequência mensal de 2001 a 2035
WITH CTE_GeradorDatas AS (
    SELECT CAST('2001-01-01' AS DATE) AS DataLoop
    UNION ALL
    SELECT DATEADD(MONTH, 1, DataLoop)
    FROM CTE_GeradorDatas
    WHERE DataLoop < '2035-12-01'
)
INSERT INTO [gold].[d_tempo] (
    [sk_tempo],
    [data],
    [ano],
    [num_mes],
    [nome_mes]
)
SELECT 
    FORMAT(DataLoop, 'yyyyMM') AS [sk_tempo],
    DataLoop AS [data],
    YEAR(DataLoop) AS [ano],
    MONTH(DataLoop) AS [num_mes],
    CASE MONTH(DataLoop)
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS [nome_mes]
FROM CTE_GeradorDatas
OPTION (MAXRECURSION 500); -- Permite recursão para os 420 meses do período
GO

-- Validação da Carga
SELECT 
    MIN([sk_tempo]) AS [Primeiro_Mes],
    MAX([sk_tempo]) AS [Ultimo_Mes],
    COUNT(*) AS [Total_Meses_Inseridos]
FROM [gold].[d_tempo];
GO

SELECT *
FROM gold.d_tempo
ORDER BY [sk_tempo] ASC;