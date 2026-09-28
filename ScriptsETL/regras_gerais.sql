
-- ### F_VAREJISTA / D_AGENTE

-- ## Tratar Permissionárias (f_varejista_cod_perf_agente_conectado)
-- Não foram encontrados registros desses perfis na lista_perfil CCEE
SELECT * 
from silver.tb_varejista
WHERE cod_perf_agente_conectado = 18234 -- CERES

SELECT * 
from silver.tb_varejista
WHERE cod_perf_agente_conectado = 85070 -- CASTRO DIS

SELECT * 
from silver.tb_varejista
WHERE cod_perf_agente_conectado = 85071 -- CERCI

SELECT * 
from silver.tb_varejista
WHERE cod_perf_agente_conectado = 58883 -- CERCOS

-- # Necessário criar registros manuais para realizar lookup na dimensão d_agente
SET IDENTITY_INSERT gold.d_agente ON;

INSERT INTO gold.d_agente (
    sk_agente,
    cod_agente,
    sigla_agente,
    nome_empresa,
    CNPJ,
    cod_perfil,
    sigla_perfil,
    classe_perfil,
    status_perfil,
    categoria_agente,
    nome_submercado,
    tipo_energia_perfil
)
VALUES 
(
    -1,
    -1,
    'CERCOS',
    'COOPERATIVA DE ELETRIFICACAO E DESENVOLVIMENTO RURAL CENTRO SUL DE SERGIPE LTDA',
    '13107842000199',
    58883,
    'CERCOS',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'NORDESTE',
    'Convencional Não Especial N/A'
),
( -- verificar!!
    -2,
    -2,
    'CERCI',
    'COOPERATIVA DE ELETRIFICACAO RURAL CACHOEIRAS ITABORAI LTDA',
    '27707397000102',
    85071,
    'CERCI',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUDESTE',
    'Convencional Não Especial N/A'
),
(
    -3,
    -3,
    'CASTRO',
    'CASTRO DISTRIBUICAO DE ENERGIA S.A.',
    '10871936000128',
    85070,
    'CASTRO DIS',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -4,
    -4,
    'CERES',
    'COOPERATIVA DE ELETRIFICACAO RURAL DE RESENDE LTDA',
    '31465487000101',
    18234,
    'CERES',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUDESTE',
    'Convencional Não Especial N/A'
);

SET IDENTITY_INSERT gold.d_agente OFF;
GO

SELECT * from gold.d_agente
ORDER BY cod_agente 

    --  sk_agente/cod_agente negativos(-) para diferenciar dos registros da fonte: lista_perfil CCEE

-- atualizando 
UPDATE gold.d_agente
SET
    nome_empresa = 'COOPERATIVA DE DISTRIBUICAO DE ENERGIA ELETRICA DE CASTRO',
    CNPJ = '30460297000139'
WHERE 
    sk_agente = -3

-- check-up completo
SELECT 
    s.cod_perf_agente_conectado, 
    COUNT(*) AS total_agentes,
    s.sigla_perfil_agente_conectado
FROM silver.tb_varejista s
LEFT JOIN gold.d_agente a
    ON s.cod_perf_agente_conectado = a.cod_perfil 
WHERE a.sk_agente IS NULL 
GROUP BY s.cod_perf_agente_conectado, s.sigla_perfil_agente_conectado
ORDER BY total_agentes DESC;

-- Por hora criar manualmente, posteriormente aprimorar atualização automática no csv lista-permissionarias-não-agente da CCEE.
SET IDENTITY_INSERT gold.d_agente ON;

INSERT INTO gold.d_agente (
    sk_agente,
    cod_agente,
    sigla_agente,
    nome_empresa,
    CNPJ,
    cod_perfil,
    sigla_perfil,
    classe_perfil,
    status_perfil,
    categoria_agente,
    nome_submercado,
    tipo_energia_perfil
)
VALUES 
(
    -5,
    -5,
    'CERTREL',
    'COOPERATIVA DE ENERGIA TREVISO',
    '76583962000182',
    85069,
    'CERTREL',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -6,
    -6,
    'COOPERA',
    'COOPERATIVA PIONEIRA DE ELETRIFICACAO - COOPERA',
    '83646653000170',
    16145,
    'COOPERA',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -7,
    -7,
    'CERPALO ACL',
    'COOPERATIVA DE ELETRICIDADE DE PAULO LOPES - CERPALO',
    '85318640000105',
    204819,
    'CERPALO ACL',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -8,
    -8,
    'CEREJ',
    'COOPERATIVA DE PRESTACAO DE SERVICOS PUBLICOS DE DISTRIBUICAO DE ENERGIA ELETRICA SENADOR ESTEVES JUNIOR',
    '82574864000181',
    58785,
    'CEREJ',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -9,
    -9,
    'CERMC',
    'COOPERATIVA DE ELETRIFICACAO E DESENVOLVIMENTO DA REGIAO DE MOGI DAS CRUZES',
    '52548732000114',
    85077,
    'CERMC',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUDESTE',
    'Convencional Não Especial N/A'
),
(
    -10,
    -10,
    'JOAOCESA',
    'EMPRESA FORCA E LUZ JOAO CESA LTDA',
    '86301124000122',
    21585,
    'JOAOCESA',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -11,
    -11,
    'CERAL ANITAPOLIS',
    'COOPERATIVA DE DISTRIBUICAO DE ENERGIA ELETRICA DE ANITAPOLIS - CERAL',
    '75826404000138',
    58882,
    'CERAL ANITAPOLIS',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUL',
    'Convencional Não Especial N/A'
),
(
    -12,
    -12,
    'CEDRI',
    'COOPERATIVA DE ELETRIFICACAO E DISTRIBUICAO DA REGIAO DE ITARIRI',
    '50105865000190',
    89304,
    'CEDRI',
    'Distribuidor',
    'ATIVO',
    'Distribuição',
    'SUDESTE',
    'Convencional Não Especial N/A'
);

SET IDENTITY_INSERT gold.d_agente OFF;
GO

-- ### F_GERACAO: CSV UTF8/ANSI (Mojibake)
                -- obs.: para 23/24 UTF8 e ANSI a partir de 2025, exatamente 07/25


