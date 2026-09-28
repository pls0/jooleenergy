-- ##CREATE SCHEMA

CREATE SCHEMA [bronze];
GO
CREATE SCHEMA [silver];
GO 
CREATE SCHEMA [gold];
GO

-- ##TEST 

CREATE SCHEMA test;
GO

CREATE TABLE test.d_agente (
    sk_agente INT IDENTITY(1,1) NOT NULL,
    cod_agente INT NULL,
    sigla_agente VARCHAR(100) NULL,
    nome_empresa VARCHAR(255) NULL,
    CNPJ VARCHAR(45) NOT NULL,
    cod_perfil INT NOT NULL,
    sigla_perfil VARCHAR(45) NULL,
    classe_perfil VARCHAR(45) NOT NULL,
    status_perfil VARCHAR(45) NOT NULL,
    categoria_agente VARCHAR(45) NOT NULL,
    nome_submercado VARCHAR(20) NULL,
    tipo_energia_perfil VARCHAR(45) NOT NULL,
    PRIMARY KEY (sk_agente),
);
