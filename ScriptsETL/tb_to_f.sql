

-- # PLD

SELECT pld_media_mes, submercado, mes_referencia, data_carga_gold, getdate() AS data_carga_atual
FROM silver.tb_pld
WHERE data_carga_gold IS NULL

-- # Consumo

SELECT consumo_total_acr, consumo_total_acl, mes_referencia, data_carga_gold, getdate() AS data_carga_atual
FROM silver.tb_consumo
WHERE data_carga_gold IS NULL

-- ## Varejista

SELECT consumo_total, qtd_parcela_carga, submercado_carga, estado_uf_carga, mes_referencia, cod_perf_agente, cod_perf_agente_conectado
FROM silver.tb_varejista
WHERE data_carga_gold IS NULL

UPDATE silver.tb_varejista
SET data_carga_gold = getdate()
WHERE data_carga_gold IS NULL

-- # Geração

SELECT geracao, capacidade_instalada, estado, fonte_primaria, submercado, mes_referencia
FROM silver.tb_geracao
WHERE data_carga_gold IS NULL




