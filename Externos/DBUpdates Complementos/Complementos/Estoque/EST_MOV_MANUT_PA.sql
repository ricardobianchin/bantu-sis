SET TERM ^;
CREATE OR ALTER PACKAGE EST_MOV_MANUT_PA
AS
BEGIN
  PROCEDURE EST_MOV_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL 
    , EST_MOV_TIPO_ID ID_CHAR_DOM NOT NULL
    , DTH_DOC TIMESTAMP NOT NULL
    , EST_MOV_CRIADO_EM TIMESTAMP NOT NULL
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
  );
  
  PROCEDURE ORDEM_PROXIMO_GET
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
  )
  RETURNS
  (
    ORDEM_RET SMALLINT
  );  
  
  PROCEDURE EST_MOV_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM Not Null
    , TERMINAL_ID ID_SHORT_DOM Not Null
    , EST_MOV_ID BIGINT NOT NULL
    , EST_MOV_TIPO_ID ID_CHAR_DOM Not Null
    , DTH_DOC TIMESTAMP NOT NULL
    , EST_MOV_CRIADO_EM TIMESTAMP NOT NULL
    , PROD_ID ID_DOM Not Null
    , QTD QTD_DOM Not Null
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , EST_MOV_ITEM_CRIADO_EM_RET TIMESTAMP
    , ORDEM_RET SMALLINT
  );  

  PROCEDURE FINALIZE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
  )
  RETURNS
  (
    FINALIZADO_EM_RET TIMESTAMP
  );
  PROCEDURE CANCELE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL,
    TERMINAL_ID ID_SHORT_DOM NOT NULL,
    EST_MOV_ID BIGINT
  )
  RETURNS
  (
    CANCELADO_EM TIMESTAMP
  );
END^

RECREATE PACKAGE BODY EST_MOV_MANUT_PA
AS
BEGIN
  PROCEDURE EST_MOV_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , EST_MOV_TIPO_ID ID_CHAR_DOM NOT NULL
    , DTH_DOC TIMESTAMP NOT NULL
    , EST_MOV_CRIADO_EM TIMESTAMP NOT NULL
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
  )
  AS
  BEGIN
    :EST_MOV_ID_RET = COALESCE(EST_MOV_ID, 0);
    :EST_MOV_CRIADO_EM_RET = :EST_MOV_CRIADO_EM;
    :DTH_DOC_RET = :DTH_DOC;

    IF (:EST_MOV_ID_RET = 0) THEN
    BEGIN
      :EST_MOV_ID_RET = NEXT VALUE FOR EST_MOV_SEQ;
      :EST_MOV_CRIADO_EM_RET = CURRENT_TIMESTAMP;
      :DTH_DOC_RET = :EST_MOV_CRIADO_EM_RET;

      INSERT INTO EST_MOV (
        LOJA_ID
        , TERMINAL_ID
        , EST_MOV_ID
        , EST_MOV_TIPO_ID
        , DTH_DOC
        , CRIADO_EM
      ) VALUES (
        :LOJA_ID
        , :TERMINAL_ID
        , :EST_MOV_ID_RET
        , :EST_MOV_TIPO_ID
        , :DTH_DOC_RET
        , :EST_MOV_CRIADO_EM_RET
      );
    END

    SUSPEND;
  END
  
  PROCEDURE ORDEM_PROXIMO_GET
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
  )
  RETURNS
  (
    ORDEM_RET SMALLINT
  )
  AS
  BEGIN
    SELECT COALESCE(MAX(ORDEM), -1) + 1 
    FROM EST_MOV_ITEM
    WHERE LOJA_ID = :LOJA_ID
    AND TERMINAL_ID = :TERMINAL_ID
    AND EST_MOV_ID = :EST_MOV_ID
    INTO :ORDEM_RET;

    SUSPEND;
  END  
  
  PROCEDURE EST_MOV_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM Not Null
    , TERMINAL_ID ID_SHORT_DOM Not Null
    , EST_MOV_ID BIGINT NOT NULL
    , EST_MOV_TIPO_ID ID_CHAR_DOM Not Null
    , DTH_DOC TIMESTAMP NOT NULL
    , EST_MOV_CRIADO_EM TIMESTAMP NOT NULL
    , PROD_ID ID_DOM Not Null
    , QTD QTD_DOM Not Null
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , EST_MOV_ITEM_CRIADO_EM_RET TIMESTAMP
    , ORDEM_RET SMALLINT
  )
  AS
  BEGIN
    :EST_MOV_ID_RET = COALESCE(EST_MOV_ID, 0);
    IF (:EST_MOV_ID_RET = 0) THEN
    BEGIN
      SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET FROM EST_MOV_INS
      (
        :LOJA_ID
        , :TERMINAL_ID
        , :EST_MOV_ID_RET
        , :EST_MOV_TIPO_ID
        , :DTH_DOC
        , :EST_MOV_CRIADO_EM
      )
      INTO :EST_MOV_ID_RET, :DTH_DOC_RET, :EST_MOV_CRIADO_EM_RET;
    END  
  
--    :ORDEM_RET = COALESCE(:ORDEM, 0);
    --IF (:ORDEM_RET = 0) THEN
    --BEGIN
    --END

    SELECT ORDEM_RET
    FROM ORDEM_PROXIMO_GET
    (:LOJA_ID, :TERMINAL_ID, :EST_MOV_ID_RET)
    INTO :ORDEM_RET;
    
    :EST_MOV_ITEM_CRIADO_EM_RET = CURRENT_TIMESTAMP;

    INSERT INTO EST_MOV_ITEM
    (
      LOJA_ID 
      , TERMINAL_ID 
      , EST_MOV_ID 
      , ORDEM 
      , PROD_ID 
      , QTD 
      , CRIADO_EM 
    )
    VALUES
    (
      :LOJA_ID 
      , :TERMINAL_ID 
      , :EST_MOV_ID_RET
      , :ORDEM_RET 
      , :PROD_ID 
      , :QTD 
      , :EST_MOV_ITEM_CRIADO_EM_RET
    );
    SUSPEND;    
  END

  PROCEDURE FINALIZE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
  )
  RETURNS
  (
    FINALIZADO_EM_RET TIMESTAMP
  )
  AS
  BEGIN
    FINALIZADO_EM_RET = CURRENT_TIMESTAMP;

    UPDATE EST_MOV SET
      FINALIZADO = TRUE
      , ALTERADO_EM = :FINALIZADO_EM_RET
      , FINALIZADO_EM = :FINALIZADO_EM_RET
    WHERE LOJA_ID = :LOJA_ID
      AND TERMINAL_ID = :TERMINAL_ID
      AND EST_MOV_ID = :EST_MOV_ID;

    SUSPEND;
  END
  PROCEDURE CANCELE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL,
    TERMINAL_ID ID_SHORT_DOM NOT NULL,
    EST_MOV_ID BIGINT
  )
  RETURNS
  (
    CANCELADO_EM TIMESTAMP
  )
  AS
  BEGIN
    CANCELADO_EM = CURRENT_TIMESTAMP;

    UPDATE EST_MOV SET
      CANCELADO = TRUE,
      ALTERADO_EM = :CANCELADO_EM,
      CANCELADO_EM = :CANCELADO_EM
    WHERE LOJA_ID = :LOJA_ID
      AND TERMINAL_ID = :TERMINAL_ID
      AND EST_MOV_ID = :EST_MOV_ID;

    SUSPEND;
  END
END^
SET TERM ;^
