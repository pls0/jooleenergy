
-- ### D_AGENTE

-- # Criar AGENTE "ND" na base de dados 

-- Para os casos de NULL (no data) nos campos sigla_perfil_agente_conectado | cod_perf_agente_conectado
SELECT distinct(sigla_perfil_agente_conectado), cod_perf_agente_conectado
from bronze.stg_varejista
order by cod_perf_agente_conectado

select distinct(sigla_perfil), cod_agente, cod_perfil, sk_agente
from gold.d_agente
order by cod_agente, cod_perfil

-- Criando Agente "ND" (No Data) na tabela gold.d_agente, para os casos de NULL
SET IDENTITY_INSERT gold.d_agente ON;

INSERT INTO gold.d_agente (sk_agente, cod_agente, sigla_agente, nome_empresa, CNPJ, 
    cod_perfil, sigla_perfil, classe_perfil, status_perfil, 
    categoria_agente, nome_submercado, tipo_energia_perfil)
VALUES (0, 0, 'ND', 'ND', '00000000000000', 
    0, 'ND', 'ND', 'ND', 
    'ND', 'ND', 'ND');

SET IDENTITY_INSERT gold.d_agente OFF;
GO

        -- + Tratado uma linha onde a sigla_perfil estava como NULL no d_agente
        SELECT * from gold.d_agente
        WHERE sigla_perfil = 'ND'


-- # Valores vazios coluna SUBMERCADO 

-- Campo não é null nem vazio
-- É char(160)
SELECT 
    cod_perfil,
    sigla_perfil,
    nome_submercado,
    LEN(nome_submercado) AS len,
    DATALENGTH(nome_submercado) AS bytes,
    ASCII(SUBSTRING(nome_submercado, 1, 1)) AS codigo_primeiro_char,
    UNICODE(SUBSTRING(nome_submercado, 1, 1)) AS unicode_primeiro_char
FROM test.d_agente
WHERE cod_perfil = 35676;

SELECT sk_agente, cod_perfil, sigla_perfil, nome_submercado
FROM test.d_agente
WHERE nome_submercado = CHAR(160)
   OR CHARINDEX(CHAR(160), nome_submercado) > 0;

   -- Valor tratado no Pentaho atráves de replace string, buscando char(160) - Alterando campo nulo para "ND"

select * from gold.d_agente
where cod_perfil = 85069