
-- ## PLD
SELECT mes_referencia, submercado, pld_media_mes, arquivo_origem, data_carga_bronze, flag_processado_silver
FROM bronze.stg_pld
WHERE flag_processado_silver = 0


-- ## Consumo
SELECT mes_referencia,consumo_total_acr, consumo_total_acl, arquivo_origem, data_carga_bronze, flag_processado_silver, getdate() AS data_carga_silver
FROM bronze.stg_consumo
WHERE flag_processado_silver = 0

-- ## Varejista 
SELECT * 
FROM bronze.stg_varejista
WHERE flag_processado_silver = 0

UPDATE bronze.stg_varejista
SET flag_processado_silver = 1
WHERE flag_processado_silver = 0

-- ## GERAÇÃO

SELECT * 
FROM bronze.stg_geracao
WHERE flag_processado_silver = 0

-- # Error converting data type nvarchar to numeric.
SELECT 
    mes_referencia,
    submercado,
    estado,
    fonte_primaria,
    geracao,
    capacidade_instalada,
    arquivo_origem
FROM bronze.stg_geracao
WHERE 
    -- Verifica se o campo não é um número válido (testando ponto e vírgula)
    TRY_CAST(REPLACE(geracao, ',', '.') AS DECIMAL(22,12)) IS NULL
    OR TRY_CAST(REPLACE(capacidade_instalada, ',', '.') AS DECIMAL(22,12)) IS NULL;


-- # Confirmando quantidade de casas decimais nas colunas Capacidade instalada_mwm para adaptação.
    SELECT TOP 10
    mes_referencia,
    submercado,
    estado,
    fonte_primaria,
    capacidade_instalada AS valor_original_bronze,
    CASE 
        WHEN CHARINDEX('.', valor_expandido) = 0 THEN 0
        ELSE LEN(valor_expandido) - CHARINDEX('.', valor_expandido)
    END AS total_casas_decimais
FROM (
    SELECT 
        mes_referencia,
        submercado,
        estado,
        fonte_primaria,
        capacidade_instalada,
        LTRIM(RTRIM(
            FORMAT(
                TRY_CAST(REPLACE(capacidade_instalada, ',', '.') AS FLOAT), 
                '0.####################'
            )
        )) AS valor_expandido
    FROM bronze.stg_geracao
    WHERE capacidade_instalada IS NOT NULL
      AND LTRIM(RTRIM(capacidade_instalada)) <> ''
) AS sub
ORDER BY total_casas_decimais DESC;
