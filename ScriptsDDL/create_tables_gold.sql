
-- # Create Gold Dimensions Tables

CREATE TABLE gold.d_tempo (
    sk_tempo INT NOT NULL, -- e.g:202608
    nome_mes VARCHAR(20) NOT NULL,
    num_mes TINYINT NOT NULL,
    ano SMALLINT NOT NULL,
    data DATE NOT NULL,
    PRIMARY KEY (sk_tempo)
);

CREATE TABLE gold.d_submercado (
    sk_submercado INT IDENTITY(1,1) NOT NULL,
    nome_submercado VARCHAR(20) NOT NULL,
    sigla_submercado VARCHAR(10) NULL,
    PRIMARY KEY (sk_submercado),
    CONSTRAINT UQ_nome_submercado UNIQUE (nome_submercado)
);

CREATE TABLE gold.d_estado_geo (
    sk_uf INT IDENTITY(1,1) NOT NULL,
    cod_longi_estado DECIMAL(9,6) NULL,
    cod_lati_estado DECIMAL(9,6) NULL,
    nome_regiao_br VARCHAR(45) NULL,
    nome_uf VARCHAR(45) NULL,
    sigla_uf CHAR(2) NOT NULL,
    PRIMARY KEY (sk_uf),
    CONSTRAINT UQ_sigla_uf UNIQUE (sigla_uf)
);

CREATE TABLE gold.d_fonte_primaria (
    sk_fonte_primaria INT IDENTITY(1,1) NOT NULL,
    nome_fonte_primaria VARCHAR(45) NOT NULL,
    sigla_fonte_primaria VARCHAR(45) NULL,
    PRIMARY KEY (sk_fonte_primaria),
    CONSTRAINT UQ_nome_fonte_primaria UNIQUE (nome_fonte_primaria)
);

CREATE TABLE gold.d_agente (
    sk_agente INT IDENTITY(1,1) NOT NULL,
    cod_agente INT NOT NULL,
    sigla_agente VARCHAR(100) NOT NULL,
    nome_empresa VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(45) NOT NULL,
    cod_perfil INT NOT NULL,
    sigla_perfil VARCHAR(45) NOT NULL,
    classe_perfil VARCHAR(45) NOT NULL,
    status_perfil VARCHAR(45) NOT NULL,
    categoria_agente VARCHAR(45) NOT NULL,
    nome_submercado VARCHAR(20) NULL,
    tipo_energia_perfil VARCHAR(45) NOT NULL,
    PRIMARY KEY (sk_agente),
    CONSTRAINT UQ_cod_agente_perfil UNIQUE (cod_agente, cod_perfil),
);

--  #Create Gold Tables

CREATE TABLE gold.f_pld (
    valor_pld DECIMAL(10,2) NOT NULL,
    sk_submercado INT NOT NULL,
    sk_tempo INT NOT NULL,

    -- Constraints
    CONSTRAINT FK_fpld_tempo FOREIGN KEY (sk_tempo) REFERENCES gold.d_tempo (sk_tempo),
    CONSTRAINT FK_fpld_submercado FOREIGN KEY (sk_submercado) REFERENCES gold.d_submercado (sk_submercado),
    
    -- regra UNIQUE
    CONSTRAINT UQ_pld_mes_submercado UNIQUE (sk_tempo, sk_submercado)
);

CREATE TABLE gold.f_consumo (
    valor_consumo_total_acl_mwmed DECIMAL(22,12) NOT NULL,
    valor_consumo_total_acr_mwmed DECIMAL(22,12) NOT NULL,
    sk_tempo INT NOT NULL,

    -- Constraints
    CONSTRAINT FK_fconsumo_tempo FOREIGN KEY (sk_tempo) REFERENCES gold.d_tempo (sk_tempo),
    
    -- regra UNIQUE
    CONSTRAINT UQ_consumo_mes UNIQUE (sk_tempo)
)

CREATE TABLE gold.f_geracao (
  valor_geracao_mwmed DECIMAL(22,12) NOT NULL,
  valor_capacidade_instalada_mwmed DECIMAL(22,12) NOT NULL,
  sk_uf INT NOT NULL,
  sk_fonte_primaria INT NOT NULL,
  sk_submercado INT NOT NULL,
  sk_tempo INT NOT NULL,

  -- Constraints
  CONSTRAINT FK_fgeracao_uf FOREIGN KEY (sk_uf) REFERENCES gold.d_estado_geo (sk_uf),
  CONSTRAINT FK_fgeracao_fonte FOREIGN KEY (sk_fonte_primaria) REFERENCES gold.d_fonte_primaria (sk_fonte_primaria),
  CONSTRAINT FK_fgeracao_submercado FOREIGN KEY (sk_submercado) REFERENCES gold.d_submercado (sk_submercado),
  CONSTRAINT FK_fgeracao_tempo FOREIGN KEY (sk_tempo) REFERENCES gold.d_tempo (sk_tempo),

  -- regra UNIQUE
  CONSTRAINT UQ_geracao_mes_submercado_estado_fonte UNIQUE (sk_uf, sk_fonte_primaria, sk_submercado, sk_tempo)
)

CREATE TABLE gold.f_varejista (
  valor_consumo_mwh DECIMAL(16,6) NOT NULL,
  qtd_parcela_carga INT NOT NULL,
  sk_submercado INT NOT NULL,
  sk_uf INT NOT NULL,
  sk_tempo INT NOT NULL,
  sk_agente_varejista INT NOT NULL,
  sk_agente_conectado INT NOT NULL,

  -- Constraints
  CONSTRAINT FK_fvarejista_submercado FOREIGN KEY (sk_submercado) REFERENCES gold.d_submercado (sk_submercado),
  CONSTRAINT FK_fvarejista_uf FOREIGN KEY (sk_uf) REFERENCES gold.d_estado_geo (sk_uf),
  CONSTRAINT FK_fvarejista_tempo FOREIGN KEY (sk_tempo) REFERENCES gold.d_tempo (sk_tempo),
  CONSTRAINT FK_fvarejista_agente_varejista FOREIGN KEY (sk_agente_varejista) REFERENCES gold.d_agente (sk_agente),
  CONSTRAINT FK_fvarejista_agente_conectado FOREIGN KEY (sk_agente_conectado) REFERENCES gold.d_agente (sk_agente),

  -- regra UNIQUE
  CONSTRAINT UQ_varejista_mes_submercado_estado_agente UNIQUE (sk_tempo,sk_agente_varejista,sk_agente_conectado)
)

-- ## ALTERAÇÕES

-- # f_varejista

ALTER TABLE [gold].[f_varejista] DROP CONSTRAINT [UQ_varejista_mes_submercado_estado_agente]
GO

ALTER TABLE gold.f_varejista
ADD CONSTRAINT UQ_varejista_tempo_agentev_agentec_submercado_uf UNIQUE (
    sk_tempo, sk_agente_varejista, sk_agente_conectado, sk_submercado, sk_uf
);

-- # d_agente
ALTER TABLE gold.d_agente
ALTER COLUMN nome_empresa VARCHAR(255) not null

ALTER TABLE gold.d_agente
ALTER COLUMN nome_submercado VARCHAR(20) NOT NULL

-- # f_geracao
ALTER TABLE gold.f_geracao
ALTER COLUMN valor_capacidade_instalada_mwmed DECIMAL (13,3) NOT NULL

