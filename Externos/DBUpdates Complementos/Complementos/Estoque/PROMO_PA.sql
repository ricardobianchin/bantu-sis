/*
C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\PROMO_PA.sql
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\PROMO_PA.sql";

- SINTAXE FIREBIRD
- FINAL DE PROCEDURE TERMINA SO COM END, SEM ;
- IF (CONDICAO) THEN
  BEGIN
    -- AQUI VAI O CODIGO
  END -- SEM ;
  drop package PROMO_PA;
  
*/
SET TERM ^;
CREATE OR ALTER PACKAGE PROMO_PA
AS
BEGIN
  -- PROMO_PA.LISTA_GET DEF
  PROCEDURE LISTA_GET
  RETURNS 
  (
    LOJA_ID ID_SHORT_DOM,
    PROMO_ID ID_DOM,
    COD VARCHAR(20),
    NOME NOME_INTERM_DOM,
    ATIVO BOOLEAN,
    INICIA_EM TIMESTAMP,
    TERMINA_EM TIMESTAMP
  );

  PROCEDURE PROMO_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL

    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
)
  RETURNS
  (
    PROMO_ID_RET ID_DOM
  );

  PROCEDURE PROMO_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , PROMO_ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL
    , GRAVA_CABEC BOOLEAN NOT NULL
    , PROD_ID ID_DOM NOT NULL
    , PRECO_PROMO PRECO_DOM NOT NULL
  
    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
  )
  RETURNS
  (
    PROMO_ID_RET ID_DOM
  );

  PROCEDURE ALTERAR_DO
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL

    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
  );
END^

---- BODY

RECREATE PACKAGE BODY PROMO_PA
AS
BEGIN
  -- PROMO_PA.LISTA_GET IMP
  PROCEDURE LISTA_GET
  RETURNS 
  (
    LOJA_ID ID_SHORT_DOM,
    PROMO_ID ID_DOM,
    COD VARCHAR(20),
    NOME NOME_INTERM_DOM,
    ATIVO BOOLEAN,
    INICIA_EM TIMESTAMP,
    TERMINA_EM TIMESTAMP
  )
  AS
  BEGIN
    -- PROMO_PA.LISTA_GET COD
    FOR
      SELECT
        PROMO.LOJA_ID,
        PROMO.PROMO_ID,
        '' COD,
        PROMO.NOME,
        PROMO.ATIVO,
        PROMO.INICIA_EM,
        PROMO.TERMINA_EM
      FROM
        AMBIENTE_SIS
      JOIN PROMO ON
        AMBIENTE_SIS.LOJA_ID = PROMO.LOJA_ID
--      WHERE
--        LOJA_ID = :LOJA_ID
--        OR :LOJA_ID = 0

      INTO
        :LOJA_ID,
        :PROMO_ID,
        :COD,
        :NOME,
        :ATIVO,
        :INICIA_EM,
        :TERMINA_EM
    DO
      SUSPEND;    
  END


  PROCEDURE PROMO_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL

    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
  )
  RETURNS
  (
    PROMO_ID_RET ID_DOM
  )
  AS
    DECLARE VARIABLE TERMINAL_ID ID_SHORT_DOM = 0;
    DECLARE VARIABLE LOG_ID_RET BIGINT;
    DECLARE VARIABLE MODULO_SIS_ID ID_CHAR_DOM = '"'; -- RETAGUARDA
    DECLARE VARIABLE FEATURE_SIS_ID ID_SHORT_DOM = 20; -- PROMO
  BEGIN
    :PROMO_ID_RET = COALESCE(:PROMO_ID, 0);
    IF (:PROMO_ID_RET = 0) THEN
    BEGIN
      :PROMO_ID_RET = NEXT VALUE FOR PROMO_SEQ;
    END

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

    EXECUTE PROCEDURE LOG_PA.LOG_ENVOLVE_ID_INS
    (
      :LOJA_ID,
      :TERMINAL_ID,
      :LOG_ID_RET,
      0, -- LOG_ORDEM

      :LOJA_ID, -- LOJA_ID_ENVOLVIDO SMALLINT,
      :TERMINAL_ID, -- TERMINAL_ID_ENVOLVIDO SMALLINT,
      :PROMO_ID_RET, -- ID_ENVOLVIDO INTEGER,
      0 -- ORDEM_ENVOLVIDO SMALLINT
    );

    INSERT INTO PROMO_HIST
    (
      LOJA_ID,
      PROMO_ID,
      NOME,
      ATIVO,
      INICIA_EM,
      TERMINA_EM,
      TERMINAL_ID,
      LOG_ID
    ) VALUES
    (
      :LOJA_ID,
      :PROMO_ID_RET,
      :NOME,
      :ATIVO,
      :INICIA_EM,
      :TERMINA_EM,
      :TERMINAL_ID,
      :LOG_ID_RET
    );

    UPDATE OR INSERT INTO PROMO
    (
      LOJA_ID,
      PROMO_ID,
      NOME,
      ATIVO,
      INICIA_EM,
      TERMINA_EM,
      TERMINAL_ID,
      LOG_ID
    ) VALUES
    (
      :LOJA_ID,
      :PROMO_ID_RET,
      :NOME,
      :ATIVO,
      :INICIA_EM,
      :TERMINA_EM,
      :TERMINAL_ID,
      :LOG_ID_RET
    )
    MATCHING 
    (
      LOJA_ID,
      PROMO_ID
    );
    
    SUSPEND;
  END


  PROCEDURE PROMO_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , PROMO_ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL
    , GRAVA_CABEC BOOLEAN NOT NULL
    , PROD_ID ID_DOM NOT NULL
    , PRECO_PROMO PRECO_DOM NOT NULL

    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
  )
  RETURNS
  (
    PROMO_ID_RET ID_DOM
  )
  AS
    DECLARE VARIABLE TERMINAL_ID ID_SHORT_DOM = 0;
    DECLARE VARIABLE LOG_ID_RET BIGINT;
    DECLARE VARIABLE MODULO_SIS_ID ID_CHAR_DOM = '"'; -- RETAGUARDA
    DECLARE VARIABLE FEATURE_SIS_ID ID_SHORT_DOM = 21; -- PROMO_ITEM
  BEGIN
    IF (GRAVA_CABEC) THEN
    BEGIN
      SELECT PROMO_ID_RET FROM PROMO_INS
      (
        :LOJA_ID,
        :PROMO_ID,
        :NOME,
        :PROMO_ATIVO,
        :INICIA_EM,
        :TERMINA_EM,

        :ACAO_SIS_ID,
        :LOG_PESSOA_ID,
        :MACHINE_ID
      ) INTO :PROMO_ID_RET;
    END

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

    EXECUTE PROCEDURE LOG_PA.LOG_ENVOLVE_ID_INS
    (
      :LOJA_ID,
      :TERMINAL_ID,
      :LOG_ID_RET,
      0, -- LOG_ORDEM

      :LOJA_ID, -- LOJA_ID_ENVOLVIDO SMALLINT,
      :TERMINAL_ID, -- TERMINAL_ID_ENVOLVIDO SMALLINT,
      :PROMO_ID_RET, -- ID_ENVOLVIDO BIGINT,
      0, -- ORDEM_ENVOLVIDO SMALLINT
      :PROD_ID -- ID_ENVOLVIDO2 BIGINT
    );

    INSERT INTO PROMO_ITEM_HIST
    (
      LOJA_ID,
      TERMINAL_ID,
      PROMO_ID,
      LOG_ID,
      PROD_ID,
      PRECO_PROMO
    ) 
    VALUES
    (
      :LOJA_ID,
      :TERMINAL_ID,
      :PROMO_ID_RET,
      :LOG_ID_RET,
      :PROD_ID,
      :PRECO_PROMO
    );

    UPDATE OR INSERT INTO PROMO_ITEM
    (
      PROD_ID,
      LOJA_ID,
      PROMO_ID,
      PRECO_PROMO,
      TERMINAL_ID,
      LOG_ID
    ) VALUES
    (
      :PROD_ID,
      :LOJA_ID,
      :PROMO_ID_RET,
      :PRECO_PROMO,
      :TERMINAL_ID,
      :LOG_ID_RET
    )
    MATCHING 
    (
      PROD_ID,
      LOJA_ID,
      PROMO_ID
    );
    
    SUSPEND;
  END

  PROCEDURE ALTERAR_DO
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , PROMO_ID ID_DOM
    , NOME NOME_INTERM_DOM NOT NULL
    , ATIVO BOOLEAN NOT NULL
    , INICIA_EM TIMESTAMP NOT NULL
    , TERMINA_EM TIMESTAMP NOT NULL

    , ACAO_SIS_ID ID_CHAR_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM NOT NULL
  )
  AS
    DECLARE VARIABLE PROMO_ID_RET ID_DOM;
    DECLARE VARIABLE TERMINAL_ID ID_SHORT_DOM = 0;  
  BEGIN
    SELECT PROMO_ID_RET FROM PROMO_INS
    (
      :LOJA_ID,
      :PROMO_ID,
      :NOME,
      :ATIVO,
      :INICIA_EM,
      :TERMINA_EM,

      :ACAO_SIS_ID,
      :LOG_PESSOA_ID,
      :MACHINE_ID
    ) INTO :PROMO_ID_RET;
  END
END^
SET TERM ;^
