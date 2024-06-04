SET TERM ^;
CREATE OR ALTER PACKAGE LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    ATIVO BOOLEAN
    , LOJA_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM
    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_EDITADO_EM TIMESTAMP
    
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(5)
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
  );
END^

RECREATE PACKAGE BODY LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    ATIVO BOOLEAN
    , LOJA_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM

    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_EDITADO_EM TIMESTAMP
    
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(5)
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
  )
  AS
  BEGIN
    FOR
      WITH LO AS
      (
        SELECT 
          LOJA_ID, 
          APELIDO, 
          ATIVO
        FROM 
          LOJA
      )
      , PE AS
      (
        SELECT
          P.LOJA_ID,
          P.PESSOA_ID, 
          P.NOME, 
          P.NOME_FANTASIA, 
          P.GENERO_ID, 
          P.ESTADO_CIVIL_ID, 
          P.C, 
          P.I, 
          P.M, 
          P.M_UF, 
          P.EMAIL, 
          P.DT_NASC, 
          P.CRIADO_EM PESS_CRIADO_EM,
          P.EDITADO_EM PESS_EDITADO_EM, 
          
          E.ORDEM ENDER_ORDEM,
          E.LOGRADOURO,
          E.NUMERO,
          E.COMPLEMENTO,
          E.BAIRRO,
          E.UF_SIGLA,
          E.CEP,
          E.MUNICIPIO_IBGE_ID,
          E.DDD,
          E.FONE1,
          E.FONE2,
          E.FONE3,
          E.CONTATO,
          E.REFERENCIA,
          E.CRIADO_EM ENDER_CRIADO_EM,
          E.ALTERADO_EM ENDER_ALTERADO_EM
          
        FROM 
          LOJA_EH_PESSOA LP 
        JOIN 
          PESSOA P ON LP.LOJA_ID = P.LOJA_ID AND LP.TERMINAL_ID = P.TERMINAL_ID AND LP.PESSOA_ID = P.PESSOA_ID
        LEFT JOIN ENDERECO E ON P.LOJA_ID = E.LOJA_ID AND P.TERMINAL_ID = E.TERMINAL_ID AND P.PESSOA_ID = E.PESSOA_ID AND E.ORDEM = 1
      )
      SELECT 
        LO.ATIVO,
        LO.LOJA_ID,
        PE.PESSOA_ID, 
        LO.APELIDO, 
        
        PE.NOME, 
        PE.NOME_FANTASIA, 
        
        PE.C, 
        PE.I, 
        PE.M, 
        PE.M_UF, 
        
        PE.EMAIL, 
        PE.DT_NASC, 
        
        PE.PESS_EDITADO_EM, 
        PE.PESS_CRIADO_EM, 
        
        PE.ENDER_ORDEM,
        PE.LOGRADOURO,
        PE.NUMERO,
        PE.COMPLEMENTO,
        PE.BAIRRO,
        PE.UF_SIGLA,
        PE.CEP,
        PE.MUNICIPIO_IBGE_ID,
        PE.DDD,
        PE.FONE1,
        PE.FONE2,
        PE.FONE3,
        PE.CONTATO,
        PE.REFERENCIA,
        PE.ENDER_CRIADO_EM,
        PE.ENDER_ALTERADO_EM
      FROM LO
      LEFT JOIN PE ON
      LO.LOJA_ID = PE.LOJA_ID

    INTO 
      :ATIVO
      , :LOJA_ID
      , :PESSOA_ID
      , :APELIDO

      , :NOME
      , :NOME_FANTASIA
      
      , :C
      , :I
      , :M
      , :M_UF
      
      , :EMAIL
      , :DT_NASC
      
      , :PESS_EDITADO_EM
      , :PESS_CRIADO_EM
      
      , :ENDER_ORDEM
      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP
      , :MUNICIPIO_IBGE_ID
      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3
      , :CONTATO
      , :REFERENCIA
      , :ENDER_CRIADO_EM
      , :ENDER_ALTERADO_EM      
    
    DO 
      SUSPEND; 
  END
END^
SET TERM ;^
