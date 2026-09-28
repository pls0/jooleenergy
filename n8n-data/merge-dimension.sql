
-- n8n node: Merge Dimension submercado

MERGE gold.d_submercado AS target
USING (SELECT '{{ $json.nome_submercado }}' AS nome_submercado, 
              '{{ $json.sigla_submercado }}' AS sigla_submercado) AS source
ON (target.nome_submercado = source.nome_submercado)
WHEN MATCHED THEN
    UPDATE SET target.sigla_submercado = source.sigla_submercado
WHEN NOT MATCHED THEN
    INSERT (nome_submercado, sigla_submercado)
    VALUES (source.nome_submercado, source.sigla_submercado);


-- n8n node: Merge Dimension fonte_primaria

MERGE gold.d_fonte_primaria AS target
USING (SELECT '{{ $json.nome_fonte_primaria }}' AS nome_fonte_primaria, 
              '{{ $json.sigla_fonte_primaria }}' AS sigla_fonte_primaria) AS source
ON (target.nome_fonte_primaria = source.nome_fonte_primaria)
WHEN MATCHED THEN
    UPDATE SET target.sigla_fonte_primaria = source.sigla_fonte_primaria
WHEN NOT MATCHED THEN
    INSERT  (nome_fonte_primaria, sigla_fonte_primaria)
    VALUES (source.nome_fonte_primaria, source.sigla_fonte_primaria);

-- n8n node: Merge Dimension estado_geo

MERGE gold.d_estado_geo AS target
USING (SELECT '{{ $json.sigla_uf }}' AS sigla_uf,
              '{{ $json.nome_uf }}' AS nome_uf,
              '{{ $json.nome_regiao_br }}' AS nome_regiao_br,
              CAST('{{ $json.cod_lati_estado }}' AS DECIMAL(9,6)) AS cod_lati_estado,
              CAST('{{ $json.cod_longi_estado }}' AS DECIMAL(9,6)) AS cod_longi_estado) AS source
ON (target.sigla_uf = source.sigla_uf)
WHEN MATCHED THEN
    UPDATE SET target.nome_uf = source.nome_uf,
               target.nome_regiao_br = source.nome_regiao_br,
               target.cod_lati_estado = source.cod_lati_estado,
               target.cod_longi_estado = source.cod_longi_estado
WHEN NOT MATCHED THEN
    INSERT (sigla_uf, nome_uf, nome_regiao_br, cod_lati_estado, cod_longi_estado)
    VALUES (source.sigla_uf, source.nome_uf, source.nome_regiao_br, source.cod_lati_estado, source.cod_longi_estado);