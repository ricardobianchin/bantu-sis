SET TERM ^;
CREATE OR ALTER PACKAGE PROD_PA
AS
BEGIN
  PROCEDURE PROD_RECORD_COUNT_GET
  RETURNS
  (
    RECORD_COUNT INTEGER
  );

  PROCEDURE LISTA_GET(P_LOJA_ID ID_SHORT_DOM NOT NULL)
  RETURNS
  (
      PROD_ID INTEGER -- 0

    , DESCR PROD_DESCR_DOM -- 1
    , DESCR_RED PROD_DESCR_RED_DOM -- 2
    
    , FABR_ID SMALLINT -- 3
    , FABR_NOME NOME_REDU_DOM -- 4
	
    , TIPO_ID SMALLINT -- 5
    , TIPO_DESCR NOME_REDU_DOM -- 6
    , UNID_ID SMALLINT -- 7
    , UNID_SIGLA CHAR(6) -- 8
    , ICMS_ID SMALLINT -- 9
    , ICMS_DESCR_PERC NOME_INTERM_DOM -- 10
	
    , COD_BARRAS VARCHAR(14) -- 11
	
    , CUSTO CUSTO_DOM -- 12
    , PRECO PRECO_DOM -- 13
	
    , ATIVO BOOLEAN -- 14
    , LOCALIZ NOME_CURTO_DOM -- 15
    , CAPAC_EMB NUMERIC(8, 3) -- 16
    , MARGEM PERC_DOM -- 17
	
    , BAL_USO SMALLINT -- 18
    , BAL_DPTO CHAR(3) -- 19
    , BAL_VALIDADE_DIAS SMALLINT -- 20
    , BAL_TEXTO_ETIQ VARCHAR(400) -- 21
  );

  PROCEDURE BYID_GET
  (
    PROD_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    DESCR PROD_DESCR_DOM
    , DESCR_RED PROD_DESCR_RED_DOM
    , FABR_ID SMALLINT
    , FABR_NOME NOME_REDU_DOM
  );

  PROCEDURE ID_DISPONIVEL_GET
  RETURNS (ID_DISPONIVEL_RET INTEGER);

  PROCEDURE BY_COD_BARRAS_GET
  (
    COD_BARRAS CHAR(14) NOT NULL
    , PROD_ID_EXCETO INTEGER NOT NULL
  )
  RETURNS
  (
    PROD_ID_RET INTEGER
  );

  PROCEDURE INSERIR_DO
  (
    DESCR           PROD_DESCR_DOM NOT NULL
    , DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    , FABR_ID       ID_SHORT_DOM NOT NULL
    , PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    , UNID_ID       ID_SHORT_DOM NOT NULL
    , ICMS_ID       ID_SHORT_DOM NOT NULL

    , PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    , CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    , LOJA_ID            ID_SHORT_DOM NOT NULL
    , USUARIO_ID         ID_DOM NOT NULL
    , MACHINE_ID         ID_SHORT_DOM
    , CUSTO              CUSTO_DOM

    , PROD_PRECO_TABELA_ID ID_SHORT_DOM
    , PRECO              PRECO_DOM

    , ATIVO              BOOLEAN NOT NULL
    , LOCALIZ            NOME_CURTO_DOM NOT NULL
    , MARGEM             PERC_DOM

    , BAL_USO            SMALLINT NOT NULL
    , BAL_DPTO           CHAR(3)  NOT NULL
    , BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    , BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    , CODIGOS_DE_BARRA VARCHAR(2000)
  )
  RETURNS
  (
    PROD_ID INTEGER
  );

  PROCEDURE BARCODES_GAR
  (
    PROD_ID INTEGER,
    CODIGOS_DE_BARRA VARCHAR(2000)
  );
  
  PROCEDURE ALTERAR_DO
  (
    PROD_ID         ID_DOM NOT NULL

    , DESCR         PROD_DESCR_DOM NOT NULL
    , DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    , FABR_ID       ID_SHORT_DOM NOT NULL
    , PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    , UNID_ID       ID_SHORT_DOM NOT NULL
    , ICMS_ID       ID_SHORT_DOM NOT NULL

    , PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    , CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    , LOJA_ID            ID_SHORT_DOM NOT NULL
    , USUARIO_ID         ID_DOM NOT NULL
    , MACHINE_ID         ID_SHORT_DOM
    , CUSTO              CUSTO_DOM

    , PROD_PRECO_TABELA_ID ID_SHORT_DOM
    , PRECO              PRECO_DOM

    , ATIVO              BOOLEAN NOT NULL
    , LOCALIZ            NOME_CURTO_DOM NOT NULL
    , MARGEM             PERC_DOM

    , BAL_USO            SMALLINT NOT NULL
    , BAL_DPTO           CHAR(3)  NOT NULL
    , BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    , BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    , CODIGOS_DE_BARRA VARCHAR(2000)
  );
END^

----- body -----

RECREATE PACKAGE BODY PROD_PA
AS
BEGIN
  PROCEDURE PROD_RECORD_COUNT_GET
  RETURNS
  (
    RECORD_COUNT INTEGER
  )
  AS
  BEGIN
    SELECT COUNT(PROD_ID) FROM PROD INTO RECORD_COUNT;
    SUSPEND;
  END

  PROCEDURE LISTA_GET(P_LOJA_ID ID_SHORT_DOM NOT NULL)
  RETURNS
  (
    PROD_ID INTEGER -- 0

    , DESCR PROD_DESCR_DOM -- 1
    , DESCR_RED PROD_DESCR_RED_DOM -- 2
    
    , FABR_ID SMALLINT -- 3
    , FABR_NOME NOME_REDU_DOM -- 4
	
    , TIPO_ID SMALLINT -- 5
    , TIPO_DESCR NOME_REDU_DOM -- 6
    , UNID_ID SMALLINT -- 7
    , UNID_SIGLA CHAR(6) -- 8
    , ICMS_ID SMALLINT -- 9
    , ICMS_DESCR_PERC NOME_INTERM_DOM -- 10
	
    , COD_BARRAS VARCHAR(14) -- 11
	
    , CUSTO CUSTO_DOM -- 12
    , PRECO PRECO_DOM -- 13
	
    , ATIVO BOOLEAN -- 14
    , LOCALIZ NOME_CURTO_DOM -- 15
    , CAPAC_EMB NUMERIC(8, 3) -- 16
    , MARGEM PERC_DOM -- 17
	
    , BAL_USO SMALLINT -- 18
    , BAL_DPTO CHAR(3) -- 19
    , BAL_VALIDADE_DIAS SMALLINT -- 20
    , BAL_TEXTO_ETIQ VARCHAR(400) -- 21
  )
  AS 
  BEGIN 
    FOR
      WITH
      B AS (--BARRAS
        SELECT PROD_ID, COD_BARRAS, ORDEM
        FROM PROD_BARRAS
      ),
      P AS (--PROD
        SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, PROD_TIPO_ID, 
        UNID_ID, ICMS_ID, PROD_NATU_ID, CAPAC_EMB
        FROM PROD
      ),
      CO AS (--PROD_COMPL
        SELECT PROD_ID, ATIVO, LOCALIZ, MARGEM, BAL_USO,
        BAL_DPTO, BAL_VALIDADE_DIAS, BAL_TEXTO_ETIQ
        FROM PROD_COMPL
        WHERE LOJA_ID = :P_LOJA_ID
      ),
      CU AS (
        SELECT PROD_ID, CUSTO
        FROM PROD_CUSTO
        WHERE LOJA_ID = :P_LOJA_ID
      ),
      PR AS (
        SELECT PROD_ID, PRECO
        FROM PROD_PRECO
        WHERE LOJA_ID = :P_LOJA_ID
      ),
      F AS (--FABR
        SELECT ID_RET, DESCR_RET 
        FROM FABR_PA.LISTA_SELECT_GET
      ),
      T AS (--TIPO
        SELECT ID_RET, DESCR_RET 
        FROM PROD_TIPO_PA.LISTA_SELECT_GET
      )
      ,
      U AS (--UNID
        SELECT ID_RET, DESCR_RET 
        FROM UNID_PA.LISTA_SELECT_GET
      ),
      I AS (--ICMS
        SELECT ID_RET, DESCR_RET 
        FROM ICMS_PA.LISTA_SELECT_GET
      )
      SELECT
      P.PROD_ID, P.DESCR, P.DESCR_RED
      , F.ID_RET FABR_ID, F.DESCR_RET FABR_NOME
      , T.ID_RET PROD_TIPO_ID, T.DESCR_RET AS PROD_TIPO_DESCR
      , U.ID_RET UNID_ID, U.DESCR_RET AS UNID_DESCR
      , I.ID_RET ICMS_ID, I.DESCR_RET AS ICMS_DESCR

      , B.COD_BARRAS

      , CU.CUSTO

      , PR.PRECO

      , CO.ATIVO
      , CO.LOCALIZ
      , P.CAPAC_EMB
      , CO.MARGEM

      , CO.BAL_USO
      , CO.BAL_DPTO
      , CO.BAL_VALIDADE_DIAS
      , CO.BAL_TEXTO_ETIQ

      FROM P
      JOIN CO ON P.PROD_ID = CO.PROD_ID--CO=COMPL PROD_COMPL
      LEFT JOIN B ON P.PROD_ID = B.PROD_ID--B=BARRAS
      JOIN F ON F.ID_RET = P.FABR_ID--F=FABR
      JOIN T ON T.ID_RET = P.PROD_TIPO_ID--T=TIPO PROD_TIPO
      JOIN U ON U.ID_RET = P.UNID_ID--U=UNID
      JOIN I ON I.ID_RET = P.ICMS_ID--I=COMS
	    JOIN CU ON P.PROD_ID = CU.PROD_ID--CU=CUSTO
	    JOIN PR ON P.PROD_ID = PR.PROD_ID--PR=PRECO
      
      ORDER BY P.PROD_ID, B.ORDEM
    INTO
      :PROD_ID 
      , :DESCR 
      , :DESCR_RED 
      
      , :FABR_ID 
      , :FABR_NOME 
      
      , :TIPO_ID 
      , :TIPO_DESCR 
      
      , :UNID_ID 
      , :UNID_SIGLA
      
      , :ICMS_ID 
      , :ICMS_DESCR_PERC 
      
      , :COD_BARRAS
      
      , :CUSTO 

      , :PRECO
      
      , :ATIVO 
      , :LOCALIZ 
      , :CAPAC_EMB
      , :MARGEM 
      
      , :BAL_USO 
      , :BAL_DPTO 
      , :BAL_VALIDADE_DIAS 
      , :BAL_TEXTO_ETIQ

      DO SUSPEND; 
  END

  PROCEDURE BYID_GET
  (
    PROD_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    DESCR PROD_DESCR_DOM
    , DESCR_RED PROD_DESCR_RED_DOM
    , FABR_ID SMALLINT
    , FABR_NOME NOME_REDU_DOM
  )
  AS  
  BEGIN  
    SELECT FIRST(1) P.PROD_ID, P.DESCR, P.DESCR_RED,
      F.FABR_ID, F.NOME FABR_NOME
      FROM PROD P
      JOIN FABR F ON
      P.FABR_ID = F.FABR_ID
      ORDER BY P.PROD_ID
      INTO :PROD_ID, :DESCR, :DESCR_RED, FABR_ID, 
      FABR_NOME;
    SUSPEND;
  END
  
  PROCEDURE ID_DISPONIVEL_GET
  RETURNS (ID_DISPONIVEL_RET INTEGER)
  AS
    DECLARE VARIABLE MAX_PROD_ID INTEGER;
    DECLARE VARIABLE MIN_PROD_ID INTEGER;
    DECLARE VARIABLE CUR_PROD_ID INTEGER;
    DECLARE VARIABLE NEXT_PROD_ID INTEGER;
    DECLARE VARIABLE FOUND_GAP BOOLEAN;
  BEGIN
    MAX_PROD_ID = 0;
    MIN_PROD_ID = 1;
    FOUND_GAP = FALSE;

    SELECT MAX(PROD_ID) FROM PROD INTO :MAX_PROD_ID;

    IF (MAX_PROD_ID IS NULL) THEN
	  BEGIN
      ID_DISPONIVEL_RET = 1;
	  END
    ELSE
    BEGIN
      FOR SELECT PROD_ID FROM PROD ORDER BY PROD_ID INTO :CUR_PROD_ID DO
      BEGIN
        IF (CUR_PROD_ID > MIN_PROD_ID) THEN
        BEGIN
          NEXT_PROD_ID = CUR_PROD_ID - 1;
          FOUND_GAP = TRUE;
          LEAVE;
        END
        MIN_PROD_ID = CUR_PROD_ID + 1;
      END
      IF (FOUND_GAP) THEN
        ID_DISPONIVEL_RET = NEXT_PROD_ID;
      ELSE
        ID_DISPONIVEL_RET = MAX_PROD_ID + 1;
    END
  END

  PROCEDURE BY_COD_BARRAS_GET
  (
    COD_BARRAS CHAR(14) NOT NULL
    , PROD_ID_EXCETO INTEGER NOT NULL
  )
  RETURNS
  (
    PROD_ID_RET INTEGER
  )
  AS
  BEGIN
    SELECT FIRST(1) PROD_ID
    FROM PROD_BARRAS
    WHERE COD_BARRAS = :COD_BARRAS
    AND PROD_ID <> :PROD_ID_EXCETO
    INTO :PROD_ID_RET;

    SUSPEND;
  END

  PROCEDURE INSERIR_DO
  (
    DESCR           PROD_DESCR_DOM NOT NULL
    , DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    , FABR_ID       ID_SHORT_DOM NOT NULL
    , PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    , UNID_ID       ID_SHORT_DOM NOT NULL
    , ICMS_ID       ID_SHORT_DOM NOT NULL

    , PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    , CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    , LOJA_ID            ID_SHORT_DOM NOT NULL
    , USUARIO_ID         ID_DOM NOT NULL
    , MACHINE_ID         ID_SHORT_DOM
    , CUSTO              CUSTO_DOM

    , PROD_PRECO_TABELA_ID ID_SHORT_DOM
    , PRECO              PRECO_DOM

    , ATIVO              BOOLEAN NOT NULL
    , LOCALIZ            NOME_CURTO_DOM NOT NULL
    , MARGEM             PERC_DOM

    , BAL_USO            SMALLINT NOT NULL
    , BAL_DPTO           CHAR(3)  NOT NULL
    , BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    , BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    , CODIGOS_DE_BARRA VARCHAR(2000)
  )
  RETURNS (
    PROD_ID INTEGER)
  AS
    DECLARE VARIABLE LOG_ID_RET BIGINT;
  BEGIN
    PROD_ID = NEXT VALUE FOR PROD_SEQ;

    INSERT INTO prod (PROD_ID, DESCR, DESCR_RED, FABR_ID, PROD_TIPO_ID, UNID_ID, ICMS_ID, PROD_NATU_ID, CAPAC_EMB)
    VALUES (:PROD_ID, :DESCR, :DESCR_RED, :FABR_ID, :PROD_TIPO_ID, :UNID_ID, :ICMS_ID, :PROD_NATU_ID, :CAPAC_EMB);

    INSERT INTO PROD_COMPL (
      PROD_ID, LOJA_ID, ATIVO, LOCALIZ, MARGEM, BAL_USO, BAL_DPTO, BAL_VALIDADE_DIAS,
      BAL_TEXTO_ETIQ)
    VALUES (:PROD_ID, :LOJA_ID, :ATIVO, :LOCALIZ, :MARGEM, :BAL_USO, :BAL_DPTO,
      :BAL_VALIDADE_DIAS, :BAL_TEXTO_ETIQ);

    EXECUTE PROCEDURE BARCODES_GAR(PROD_ID, CODIGOS_DE_BARRA);

    EXECUTE PROCEDURE PROD_CUSTO_PA.PROD_CUSTO_HIST_INS(
      :PROD_ID, :LOJA_ID, :USUARIO_ID, :MACHINE_ID, :CUSTO, 0, 0, 0
      ) RETURNING_VALUES :LOG_ID_RET;

    EXECUTE PROCEDURE PROD_PRECO_PA.PROD_PRECO_HIST_INS(
      :PROD_ID, :PROD_PRECO_TABELA_ID, :LOJA_ID, :USUARIO_ID, :MACHINE_ID, 
      :PRECO
      ) RETURNING_VALUES :LOG_ID_RET;

    SUSPEND;
  END

  PROCEDURE BARCODES_GAR
  (
    PROD_ID INTEGER,
    CODIGOS_DE_BARRA VARCHAR(2000)
  )
  AS
    DECLARE VARIABLE ORDEM SMALLINT;
    DECLARE VARIABLE COD_BARRAS CHAR(14);
    DECLARE VARIABLE POSICAO INTEGER;
  BEGIN
    DELETE FROM PROD_BARRAS WHERE PROD_ID = :PROD_ID;

    ORDEM = 0;

    WHILE (CODIGOS_DE_BARRA <> '') DO
    BEGIN
      ORDEM = ORDEM + 1;

      POSICAO = POSITION(';' IN CODIGOS_DE_BARRA);
      IF (POSICAO = 0) THEN
      BEGIN
        COD_BARRAS = TRIM(CODIGOS_DE_BARRA);
        CODIGOS_DE_BARRA = '';
      END
      ELSE
      BEGIN
        COD_BARRAS = TRIM(SUBSTRING(CODIGOS_DE_BARRA FROM 1 FOR POSICAO - 1));
        CODIGOS_DE_BARRA = SUBSTRING(CODIGOS_DE_BARRA FROM POSICAO + 1);
      END

      INSERT INTO PROD_BARRAS (PROD_ID, ORDEM, COD_BARRAS)
      VALUES (:PROD_ID, :ORDEM, :COD_BARRAS);
    END
  END
  
  PROCEDURE ALTERAR_DO
  (
    PROD_ID         ID_DOM NOT NULL

    , DESCR         PROD_DESCR_DOM NOT NULL
    , DESCR_RED     PROD_DESCR_RED_DOM NOT NULL

    , FABR_ID       ID_SHORT_DOM NOT NULL
    , PROD_TIPO_ID  ID_SHORT_DOM NOT NULL
    , UNID_ID       ID_SHORT_DOM NOT NULL
    , ICMS_ID       ID_SHORT_DOM NOT NULL

    , PROD_NATU_ID  ID_CHAR_DOM NOT NULL

    , CAPAC_EMB     NUMERIC(8, 3) NOT NULL

    , LOJA_ID            ID_SHORT_DOM NOT NULL
    , USUARIO_ID         ID_DOM NOT NULL
    , MACHINE_ID         ID_SHORT_DOM
    , CUSTO              CUSTO_DOM

    , PROD_PRECO_TABELA_ID ID_SHORT_DOM
    , PRECO              PRECO_DOM

    , ATIVO              BOOLEAN NOT NULL
    , LOCALIZ            NOME_CURTO_DOM NOT NULL
    , MARGEM             PERC_DOM

    , BAL_USO            SMALLINT NOT NULL
    , BAL_DPTO           CHAR(3)  NOT NULL
    , BAL_VALIDADE_DIAS  SMALLINT  NOT NULL
    , BAL_TEXTO_ETIQ     VARCHAR(400)  NOT NULL

    , CODIGOS_DE_BARRA VARCHAR(2000)
  )
  AS
    DECLARE VARIABLE LOG_ID_RET BIGINT;
  BEGIN
    UPDATE prod SET
      DESCR = :DESCR,
      DESCR_RED = :DESCR_RED,
      FABR_ID = :FABR_ID,
      PROD_TIPO_ID = :PROD_TIPO_ID,
      UNID_ID = :UNID_ID,
      ICMS_ID = :ICMS_ID,
      PROD_NATU_ID = :PROD_NATU_ID,
      CAPAC_EMB = :CAPAC_EMB
    WHERE PROD_ID = :PROD_ID;

    UPDATE PROD_COMPL SET
      ATIVO = :ATIVO,
      LOCALIZ = :LOCALIZ,
      MARGEM = :MARGEM,
      BAL_USO = :BAL_USO,
      BAL_DPTO = :BAL_DPTO,
      BAL_VALIDADE_DIAS = :BAL_VALIDADE_DIAS,
      BAL_TEXTO_ETIQ = :BAL_TEXTO_ETIQ
    WHERE PROD_ID = :PROD_ID AND LOJA_ID = :LOJA_ID;

    EXECUTE PROCEDURE BARCODES_GAR(PROD_ID, CODIGOS_DE_BARRA);

    EXECUTE PROCEDURE PROD_CUSTO_PA.PROD_CUSTO_HIST_INS(
      :PROD_ID, :LOJA_ID, :USUARIO_ID, :MACHINE_ID, :CUSTO, 0, 0, 0
      ) RETURNING_VALUES :LOG_ID_RET;

    EXECUTE PROCEDURE PROD_PRECO_PA.PROD_PRECO_HIST_INS(
      :PROD_ID, :PROD_PRECO_TABELA_ID, :LOJA_ID, :USUARIO_ID, :MACHINE_ID, 
      :PRECO
      ) RETURNING_VALUES :LOG_ID_RET;
  END
END^
SET TERM ;^
