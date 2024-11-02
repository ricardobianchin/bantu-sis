SET TERM ^;

CREATE OR ALTER PACKAGE GER_FORM_PA
AS
BEGIN
  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
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
    , ATIVO BOOLEAN

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  );  
END^

RECREATE PACKAGE BODY GER_FORM_PA
AS
BEGIN
  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
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
    , ATIVO BOOLEAN

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    SELECT FIRST(1)
      P.LOJA_ID
      , P.TERMINAL_ID
      , P.PESSOA_ID
      
      , LOJA.APELIDO

      , P.NOME
      , P.NOME_FANTASIA
      
      , P.C
      , P.I
      , P.M
      , P.M_UF
      , P.EMAIL
      , P.DT_NASC
      , P.ATIVO
      
      , E.LOGRADOURO
      , E.NUMERO
      , E.COMPLEMENTO
      , E.BAIRRO
      , E.UF_SIGLA
      , E.CEP
      , E.MUNICIPIO_IBGE_ID
      , E.DDD
      , E.FONE1
      , E.FONE2
      , E.FONE3
      , E.CONTATO
      , E.REFERENCIA
      
      , LOJA.SELECIONADO
      
    FROM AMBIENTE_SIS AMBI

    JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID = 1 -- FEATURE LOJA
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN
      
    JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID
      AND LOG_EN.LOJA_ID_ENVOLVIDO = AMBI.LOJA_ID  
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO IS NULL
      AND LOG_EN.ID_ENVOLVIDO IS NULL

    JOIN LOJA ON
      AMBI.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN LOJA_EH_PESSOA LEP ON
      LEP.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN PESSOA P ON
      LEP.LOJA_ID = P.LOJA_ID 
      AND LEP.TERMINAL_ID = P.TERMINAL_ID 
      AND LEP.PESSOA_ID = P.PESSOA_ID 

    LEFT JOIN ENDERECO E ON
      P.LOJA_ID = E.LOJA_ID
      AND P.TERMINAL_ID = E.TERMINAL_ID
      AND P.PESSOA_ID = E.PESSOA_ID
    INTO
      :LOJA_ID
      , :TERMINAL_ID
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
      , :ATIVO

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
      , :SELECIONADO
      ;
    SUSPEND;
  END
END^
SET TERM ;^
