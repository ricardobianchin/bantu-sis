/*
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Sis\LOG_HIST_PROD_PA.sql";
*/
SET TERM ^;
CREATE OR ALTER PACKAGE LOG_HIST_PROD_PA
AS
BEGIN
  PROCEDURE TEVE_PROD
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , DESCR              PROD_DESCR_DOM
    , DESCR_RED          PROD_DESCR_RED_DOM
    , FABR_ID            ID_SHORT_DOM
    , PROD_TIPO_ID       ID_SHORT_DOM
    , UNID_ID            ID_SHORT_DOM
    , ICMS_ID            ID_SHORT_DOM
    , CAPAC_EMB          NUMERIC(8, 3)
    , NCM                CHAR(8)
    , DE_SISTEMA         BOOLEAN
    , FABR_NOME          NOME_REDU_DOM
    , PROD_TIPO_DESCR    NOME_INTERM_DOM
    , UNID_DESCR         NOME_INTERM_DOM
    , UNID_SIGLA         CHAR(6)
    , ICMS_SIGLA         ID_CHAR_DOM
    , ICMS_DESCR         NOME_INTERM_DOM
    , ICMS_PERC          PERC_DOM
    , ATIVO              BOOLEAN
    , LOCALIZ            NOME_CURTO_DOM
    , BALANCA_EXIGE      BOOLEAN
    , CUSTO              CUSTO_DOM
    , PRECO              PRECO_DOM
    , CRIADO_EM          TIMESTAMP
    , ALTERADO_EM        TIMESTAMP
    , BARRAS VARCHAR(233)
  );
  
  PROCEDURE TEVE_CUSTO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , CUSTO              CUSTO_DOM
  );
  
  PROCEDURE TEVE_PRECO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , PRECO            PRECO_DOM
  );
  
END^

------ BODY

RECREATE PACKAGE BODY LOG_HIST_PROD_PA
AS
BEGIN
  PROCEDURE TEVE_PROD
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , DESCR              PROD_DESCR_DOM
    , DESCR_RED          PROD_DESCR_RED_DOM
    , FABR_ID            ID_SHORT_DOM
    , PROD_TIPO_ID       ID_SHORT_DOM
    , UNID_ID            ID_SHORT_DOM
    , ICMS_ID            ID_SHORT_DOM
    , CAPAC_EMB          NUMERIC(8, 3)
    , NCM                CHAR(8)
    , DE_SISTEMA         BOOLEAN
    , FABR_NOME          NOME_REDU_DOM
    , PROD_TIPO_DESCR    NOME_INTERM_DOM
    , UNID_DESCR         NOME_INTERM_DOM
    , UNID_SIGLA         CHAR(6)
    , ICMS_SIGLA         ID_CHAR_DOM
    , ICMS_DESCR         NOME_INTERM_DOM
    , ICMS_PERC          PERC_DOM
    , ATIVO              BOOLEAN
    , LOCALIZ            NOME_CURTO_DOM
    , BALANCA_EXIGE      BOOLEAN
    , CUSTO              CUSTO_DOM
    , PRECO              PRECO_DOM
    , CRIADO_EM          TIMESTAMP
    , ALTERADO_EM        TIMESTAMP
    , BARRAS VARCHAR(233)
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    FOR
      SELECT
        DISTINCT 
        PROD.PROD_ID
        , PROD.DESCR
        , PROD.DESCR_RED
        
        , FABR.FABR_ID 
        , PROD_TIPO.PROD_TIPO_ID 
        , UNID.UNID_ID 
        , ICMS.ICMS_ID
        
        , PROD.CAPAC_EMB
        , PROD.NCM
        , PROD.DE_SISTEMA
        
        , FABR.NOME FABR_NOME
        , PROD_TIPO.DESCR PROD_TIPO_DESCR 

        , UNID.DESCR UNID_DESCR
        , UNID.SIGLA UNID_SIGLA

        , ICMS.SIGLA ICMS_SIGLA
        , ICMS.DESCR ICMS_DESCR
        , ICMS.PERC ICMS_PERC
        , PROD_COMPL.ATIVO
        , PROD_COMPL.LOCALIZ
        , PROD_COMPL.BALANCA_EXIGE
        , PROD_CUSTO.CUSTO
        , PROD_PRECO.PRECO

        , PROD.CRIADO_EM
        , PROD.ALTERADO_EM

        , LIST(TRIM(PROD_BARRAS.COD_BARRAS))
      
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
        AMBI.LOJA_ID = LOG.LOJA_ID
        AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
        AND FEATURE_SIS_ID = 7 -- FEATURE PROD
        AND LOG_ID >= :LOG_ID_INI
        AND LOG_ID <= :LOG_ID_FIN

      JOIN LOG_ENVOLVE_ID LOG_EN ON
        LOG_EN.LOJA_ID = LOG.LOJA_ID
        AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
        AND LOG_EN.LOG_ID = LOG.LOG_ID

      JOIN PROD ON
        LOG_EN.ID_ENVOLVIDO = PROD.PROD_ID
      
      JOIN PROD_COMPL ON
        PROD.PROD_ID = PROD_COMPL.PROD_ID 
        AND PROD_COMPL.LOJA_ID = AMBI.LOJA_ID
      
      JOIN FABR ON
        FABR.FABR_ID = PROD.FABR_ID 

      JOIN PROD_TIPO ON
        PROD_TIPO.PROD_TIPO_ID = PROD.PROD_TIPO_ID 

      JOIN UNID ON
        UNID.UNID_ID = PROD.UNID_ID 

      JOIN ICMS ON
        ICMS.ICMS_ID = PROD.ICMS_ID
      
      LEFT JOIN PROD_CUSTO ON
        PROD.PROD_ID  = PROD_CUSTO.PROD_ID 
        AND PROD_CUSTO.LOJA_ID = AMBI.LOJA_ID

      LEFT JOIN PROD_PRECO ON
        PROD.PROD_ID  = PROD_PRECO.PROD_ID 
        AND PROD_PRECO.LOJA_ID = AMBI.LOJA_ID

      LEFT JOIN PROD_BARRAS ON
        PROD.PROD_ID = PROD_BARRAS.PROD_ID
      
      GROUP BY
        PROD.PROD_ID
        , PROD.DESCR
        , PROD.DESCR_RED
        
        , FABR.FABR_ID 
        , PROD_TIPO.PROD_TIPO_ID 
        , UNID.UNID_ID 
        , ICMS.ICMS_ID
        
        , PROD.CAPAC_EMB
        , PROD.NCM
        , PROD.DE_SISTEMA
        
        , FABR.NOME
        , PROD_TIPO.DESCR  

        , UNID.DESCR
        , UNID.SIGLA

        , ICMS.SIGLA
        , ICMS.DESCR
        , ICMS.PERC
        , PROD_COMPL.ATIVO
        , PROD_COMPL.LOCALIZ
        , PROD_COMPL.BALANCA_EXIGE
        , PROD_CUSTO.CUSTO
        , PROD_PRECO.PRECO

        , PROD.CRIADO_EM
        , PROD.ALTERADO_EM
        
      ORDER BY  PROD.PROD_ID
    INTO
      :PROD_ID
      , :DESCR
      , :DESCR_RED
      , :FABR_ID
      , :PROD_TIPO_ID
      , :UNID_ID
      , :ICMS_ID
      , :CAPAC_EMB
      , :NCM
      , :DE_SISTEMA
      , :FABR_NOME
      , :PROD_TIPO_DESCR
      , :UNID_DESCR
      , :UNID_SIGLA
      , :ICMS_SIGLA
      , :ICMS_DESCR
      , :ICMS_PERC
      , :ATIVO
      , :LOCALIZ
      , :BALANCA_EXIGE
      , :CUSTO
      , :PRECO
      , :CRIADO_EM
      , :ALTERADO_EM
      , :BARRAS
      DO
    SUSPEND;
  END
  
  PROCEDURE TEVE_CUSTO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , CUSTO              CUSTO_DOM
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    FOR
      SELECT
        DISTINCT 
        PROD.PROD_ID
        , PROD_CUSTO.CUSTO
      
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
        AMBI.LOJA_ID = LOG.LOJA_ID
        AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
        AND FEATURE_SIS_ID = 9 -- FEATURE PROD
        AND LOG_ID >= :LOG_ID_INI
        AND LOG_ID <= :LOG_ID_FIN

      JOIN LOG_ENVOLVE_ID LOG_EN ON
        LOG_EN.LOJA_ID = LOG.LOJA_ID
        AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
        AND LOG_EN.LOG_ID = LOG.LOG_ID

      JOIN PROD ON
        LOG_EN.ID_ENVOLVIDO = PROD.PROD_ID
    
      JOIN PROD_CUSTO ON
        PROD.PROD_ID  = PROD_CUSTO.PROD_ID 
        AND PROD_CUSTO.LOJA_ID = AMBI.LOJA_ID

      ORDER BY PROD.PROD_ID
    INTO
      :PROD_ID
      , :CUSTO
      DO
    SUSPEND;
  END
  
  PROCEDURE TEVE_PRECO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PROD_ID            ID_DOM
    , PRECO            PRECO_DOM
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    FOR
      SELECT
        DISTINCT 
        PROD.PROD_ID
        , PROD_PRECO.PRECO
      
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
        AMBI.LOJA_ID = LOG.LOJA_ID
        AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
        AND FEATURE_SIS_ID = 9 -- FEATURE PROD
        AND LOG_ID >= :LOG_ID_INI
        AND LOG_ID <= :LOG_ID_FIN

      JOIN LOG_ENVOLVE_ID LOG_EN ON
        LOG_EN.LOJA_ID = LOG.LOJA_ID
        AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
        AND LOG_EN.LOG_ID = LOG.LOG_ID

      JOIN PROD ON
        LOG_EN.ID_ENVOLVIDO = PROD.PROD_ID
    
      JOIN PROD_PRECO ON
        PROD.PROD_ID  = PROD_PRECO.PROD_ID 
        AND PROD_PRECO.LOJA_ID = AMBI.LOJA_ID

      ORDER BY PROD.PROD_ID
    INTO
      :PROD_ID
      , :PRECO
      DO
    SUSPEND;
  END
END^
SET TERM ;^
