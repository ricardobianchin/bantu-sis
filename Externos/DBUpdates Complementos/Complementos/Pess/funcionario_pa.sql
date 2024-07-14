SET TERM ^;
CREATE OR ALTER PACKAGE FUNCIONARIO_PA
AS
BEGIN
  PROCEDURE GARANTIR_NOMES
  (
    LOJA_ID ID_SHORT_NOTN_DOM,
    NOME NOME_DOM NOT NULL,
    APELIDO VARCHAR(20) NOT NULL,
    PESSOA_ID INTEGER 
  )
  RETURNS
  (
    PESSOA_ID_GRAVADA INTEGER 
  );

  PROCEDURE GARANTIR
  (
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,
    NOME VARCHAR(60),
    APELIDO VARCHAR(20),
    NOME_FANTASIA VARCHAR(60),
    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),
    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),
    EMAIL VARCHAR(50),
    DT_NASC DATE,
    PESSOA_ID INTEGER,
    
    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,
    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(5),
    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,
    CONTATO           NOME_DOM,
    REFERENCIA        OBS1_DOM
  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_GRAVADA INTEGER
  );
END^

RECREATE PACKAGE BODY FUNCIONARIO_PA
AS
BEGIN
  PROCEDURE GARANTIR_NOMES
  (
    LOJA_ID ID_SHORT_NOTN_DOM,
    NOME NOME_DOM NOT NULL,
    APELIDO VARCHAR(20) NOT NULL,
    PESSOA_ID INTEGER 
  )
  RETURNS
  (
    PESSOA_ID_GRAVADA  INTEGER 
  )
  AS
  BEGIN
    EXECUTE PROCEDURE PESSOA_PA.GARANTIR_NOMES(:LOJA_ID, 0, :NOME, :APELIDO, :PESSOA_ID)
      RETURNING_VALUES :PESSOA_ID_GRAVADA;
    
    UPDATE OR INSERT INTO FUNCIONARIO (LOJA_ID, TERMINAL_ID, PESSOA_ID)
    VALUES (:LOJA_ID, 0, :PESSOA_ID_GRAVADA)
    MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID);
    
    SUSPEND; -- RETORNA O VALOR DE PESSOA_ID_GRAVADA
  END

  PROCEDURE GARANTIR
  (
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,
    NOME VARCHAR(60),
    APELIDO VARCHAR(20),
    NOME_FANTASIA VARCHAR(60),
    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),
    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),
    EMAIL VARCHAR(50),
    DT_NASC DATE,
    PESSOA_ID INTEGER,
    
    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,
    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(5),
    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,
    CONTATO           NOME_DOM,
    REFERENCIA        OBS1_DOM
  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_GRAVADA INTEGER
  )
  AS
  BEGIN
    EXECUTE PROCEDURE PESSOA_PA.GARANTIR(
      :LOJA_ID,
      :TERMINAL_ID,
      :NOME,
      :NOME_FANTASIA,
      :APELIDO,
      :GENERO_ID,
      :ESTADO_CIVIL_ID,
      :C,
      :I,
      :M,
      :M_UF,
      :EMAIL,
      :DT_NASC,
      :PESSOA_ID,
      :LOGRADOURO,
      :NUMERO,
      :COMPLEMENTO,
      :BAIRRO,
      :UF_SIGLA,
      :CEP,
      :MUNICIPIO_IBGE_ID,
      :DDD,
      :FONE1,
      :FONE2,
      :FONE3,
      :CONTATO,
      :REFERENCIA
    )
    RETURNING_VALUES :PESSOA_ID_GRAVADA;

    UPDATE OR INSERT INTO FUNCIONARIO (LOJA_ID, TERMINAL_ID, PESSOA_ID)
    VALUES (:LOJA_ID, :TERMINAL_ID, :PESSOA_ID_GRAVADA)
    MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID);

    :LOJA_ID_RET = :LOJA_ID;
    :TERMINAL_ID_RET = :TERMINAL_ID;
    
    SUSPEND;
  END
END^
SET TERM ;^