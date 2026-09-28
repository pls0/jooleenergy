
-- #Create Bronze Tables

CREATE TABLE bronze.stg_pld (
    mes_referencia VARCHAR(100),       
    submercado VARCHAR(100), 
    pld_media_mes VARCHAR(100), 
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME DEFAULT GETDATE(),
    flag_processado_silver BIT DEFAULT 0 
);

CREATE TABLE bronze.stg_consumo (
    mes_referencia VARCHAR(100),
    consumo_total_acr VARCHAR(100),
    consumo_total_acl VARCHAR(100),
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME DEFAULT GETDATE(),
    flag_processado_silver BIT DEFAULT 0 
);

CREATE TABLE bronze.stg_geracao (
    mes_referencia VARCHAR(100),
    submercado VARCHAR(100),
    fonte_primaria VARCHAR(100),
    estado VARCHAR(100),
    geracao VARCHAR(100),
    capacidade_instalada VARCHAR(100),
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME DEFAULT GETDATE(),
    flag_processado_silver BIT DEFAULT 0 
);

CREATE TABLE bronze.stg_varejista (
    mes_referencia VARCHAR(100),
    cod_perf_agente VARCHAR(100),
    sigla_perfil_agente VARCHAR(100),
    nome_empresarial VARCHAR(100),
    estado_uf_carga VARCHAR(100),
    submercado_carga VARCHAR(100),
    cod_perf_agente_conectado VARCHAR(100),
    sigla_perfil_agente_conectado VARCHAR(100),
    qtd_parcela_carga VARCHAR(100),
    consumo_total VARCHAR(100),
    
    -- Metadados de Auditoria
    arquivo_origem VARCHAR(255) NOT NULL,
    data_carga_bronze DATETIME DEFAULT GETDATE(),
    flag_processado_silver BIT DEFAULT 0 
);
