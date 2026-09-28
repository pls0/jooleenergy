
-- ### SILVER TABLES

-- ## CREATE TABLES
-- # PLD

CREATE TABLE silver.tb_pld (
    pld_media_mes DECIMAL(10,2) NOT NULL,
    submercado VARCHAR(20) NOT NULL, 
    mes_referencia INT NOT NULL,
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME NOT NULL,
    data_processamento_silver DATETIME DEFAULT GETDATE(), 
    data_carga_gold DATETIME NULL,
);


-- # Consumo

CREATE TABLE silver.tb_consumo (
    consumo_total_acl DECIMAL(22,12) NOT NULL,
    consumo_total_acr DECIMAL(22,12) NOT NULL,
    mes_referencia INT NOT NULL,
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME NOT NULL,
    data_processamento_silver DATETIME DEFAULT GETDATE(), 
    data_carga_gold DATETIME NULL
);


-- # Geracao 

CREATE TABLE silver.tb_geracao (
    geracao DECIMAL(22,12) NOT NULL,
    capacidade_instalada DECIMAL(22,12) NOT NULL,
    estado CHAR(2) NOT NULL,
    fonte_primaria VARCHAR(45) NOT NULL,
    submercado VARCHAR(20) NOT NULL,
    mes_referencia INT NOT NULL,
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME NOT NULL,
    data_processamento_silver DATETIME DEFAULT GETDATE(),
    data_carga_gold DATETIME NULL
);


-- # Varejista

CREATE TABLE silver.tb_varejista (
    consumo_total DECIMAL(16,6) NOT NULL,
    qtd_parcela_carga INT NOT NULL,
    submercado_carga VARCHAR(20) NOT NULL,
    estado_uf_carga CHAR(2) NOT NULL,
    mes_referencia INT NOT NULL,
    cod_perf_agente INT NOT NULL,
    sigla_perfil_agente VARCHAR(45) NOT NULL,
    nome_empresarial VARCHAR(100) NOT NULL,
    cod_perf_agente_conectado INT NOT NULL,
    sigla_perfil_agente_conectado VARCHAR(45) NOT NULL,

    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME NOT NULL,
    data_processamento_silver DATETIME DEFAULT GETDATE(),
    data_carga_gold DATETIME NULL
);

-- ## ALTERAÇÕES

-- # Varejista
ALTER table silver.tb_varejista
ALTER COLUMN cod_perf_agente_conectado int NOT NULL

ALTER table silver.tb_varejista
ALTER COLUMN sigla_perfil_agente_conectado VARCHAR(45) NOT NULL

-- # Geração
ALTER TABLE silver.tb_geracao
ALTER COLUMN capacidade_instalada DECIMAL (13,3) NOT NULL