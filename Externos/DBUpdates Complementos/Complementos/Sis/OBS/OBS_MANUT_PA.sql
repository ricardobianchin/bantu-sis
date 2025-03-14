SET TERM ^;
CREATE OR ALTER PACKAGE OBS_MANUT_PA
AS
BEGIN
  PROCEDURE OBS_INSERIR_DO
  (
    LOJA_ID ID_DOM NOT NULL,
    TERMINAL_ID ID_DOM NOT NULL,
    TEXTO OBS_DOM NOT NULL,
    PESSOA_ID ID_DOM NOT NULL,
    MODULO_SIS_ID ID_CHAR_DOM NOT NULL,
    MACHINE_ID ID_SHORT_DOM NOT NULL    
  )
  RETURNS
  (
    LOG_ID_RET BIGINT
  );
END^

------- BODY

RECREATE PACKAGE BODY OBS_MANUT_PA
AS
BEGIN
  PROCEDURE OBS_INSERIR_DO
  (
    LOJA_ID ID_DOM NOT NULL,
    TERMINAL_ID ID_DOM NOT NULL,
    TEXTO OBS_DOM NOT NULL,
    PESSOA_ID ID_DOM NOT NULL,
    MODULO_SIS_ID ID_CHAR_DOM NOT NULL,
    MACHINE_ID ID_SHORT_DOM NOT NULL    
  )
  RETURNS
  (
    LOG_ID_RET BIGINT
  )
  AS
    -- OBS MANUT LOGVAR LOGVARS VARS LOG VAR LOG VARLOG VARSLOG
    DECLARE FEATURE_SIS_ID ID_SHORT_DOM = 12; -- OBS
    --DECLARE TERMINAL_ID ID_SHORT_DOM = 0; -- RETAGUARDA
    --DECLARE MODULO_SIS_ID ID_CHAR_DOM = '!'; -- CONFIG
    --DECLARE MODULO_SIS_ID ID_CHAR_DOM = '"'; -- RETAGUARDA
    DECLARE ACAO_SIS_ID ID_CHAR_DOM = '%'; -- INSERIR
    --DECLARE LOG_ID_RET BIGINT;
  BEGIN
    SELECT LOG_ID_RET FROM LOG_PA.LOG_NOVO_GET
    (
      :LOJA_ID,
      :TERMINAL_ID,
      :LOG_PESSOA_ID,
      :MODULO_SIS_ID,
      :ACAO_SIS_ID,
      :FEATURE_SIS_ID,
      :MACHINE_ID
    ) INTO :LOG_ID_RET;

    INSERT INTO OBS
    (
      LOJA_ID,
      TERMINAL_ID,
      LOG_ID,
      TEXTO,
      ATIVO
    )
    VALUES 
    (
      :LOJA_ID,
      :TERMINAL_ID,
      :LOG_ID_RET,
      :TEXTO,
      :ATIVO
    );
    
    SUSPEND;
  END
END^
SET TERM ;^
