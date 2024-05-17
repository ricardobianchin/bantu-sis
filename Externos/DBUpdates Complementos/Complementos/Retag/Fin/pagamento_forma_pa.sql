SET TERM ^;
CREATE OR ALTER PACKAGE PAGAMENTO_FORMA_PA
AS
BEGIN
  PROCEDURE BYID_GET
  (
    FORMA_ID ID_SHORT_DOM
  )
  RETURNS
  (
    TIPO_ID          ID_CHAR_DOM
    , TIPO_DESCR     NOME_INTERM_DOM
    , TIPO_DESCR_RED CHAR(6)
    , TIPO_ATIVO     BOOLEAN

    , DESCR                  NOME_INTERM_DOM
    , DESCR_RED              CHAR(8)
    , ATIVO                  BOOLEAN
    , PARA_VENDA             BOOLEAN
    , SIS                    BOOLEAN
    , PROMOCAO_PERMITE       BOOLEAN
    , COMISSAO_PERMITE       BOOLEAN
    , TAXA_ADM_PERC          PERC_DOM
    , VALOR_MINIMO           PRECO_DOM
    , COMISSAO_ABATER_PERC   PERC_DOM
    , REEMBOLSO_DIAS         SMALLINT
    , TEF_USA                BOOLEAN
    , AUTORIZACAO_EXIGE      BOOLEAN
    , PESSOA_EXIGE           BOOLEAN
    , A_VISTA                BOOLEAN
  );

  PROCEDURE LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , FORMA_TIPO_DESCR NOME_INTERM_DOM
    , DESCR NOME_INTERM_DOM
    , DESCR_RED CHAR(8)
    , PARA_VENDA BOOLEAN
    , ATIVO BOOLEAN
  );

  PROCEDURE INSERIR_DO
  (
    PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID ID_SHORT_DOM
  );

  PROCEDURE ALTERAR_DO
  (
    PAGAMENTO_FORMA_ID       ID_SHORT_DOM Not Null
    , PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  );
END^


RECREATE PACKAGE BODY PAGAMENTO_FORMA_PA
AS
BEGIN
  PROCEDURE BYID_GET
  (
    FORMA_ID ID_SHORT_DOM
  )
  RETURNS
  (
    TIPO_ID          ID_CHAR_DOM
    , TIPO_DESCR     NOME_INTERM_DOM
    , TIPO_DESCR_RED CHAR(6)
    , TIPO_ATIVO     BOOLEAN

    , DESCR                  NOME_INTERM_DOM
    , DESCR_RED              CHAR(8)
    , ATIVO                  BOOLEAN
    , PARA_VENDA             BOOLEAN
    , SIS                    BOOLEAN
    , PROMOCAO_PERMITE       BOOLEAN
    , COMISSAO_PERMITE       BOOLEAN
    , TAXA_ADM_PERC          PERC_DOM
    , VALOR_MINIMO           PRECO_DOM
    , COMISSAO_ABATER_PERC   PERC_DOM
    , REEMBOLSO_DIAS         SMALLINT
    , TEF_USA                BOOLEAN
    , AUTORIZACAO_EXIGE      BOOLEAN
    , PESSOA_EXIGE           BOOLEAN
    , A_VISTA                BOOLEAN
  )
  AS
  BEGIN
    FOR
    WITH F AS (
      SELECT PAGAMENTO_FORMA_ID ID, PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR,
      DESCR_RED, ATIVO, PARA_VENDA, SIS, PROMOCAO_PERMITE, COMISSAO_PERMITE,
      TAXA_ADM_PERC, VALOR_MINIMO, COMISSAO_ABATER_PERC, REEMBOLSO_DIAS,
      TEF_USA, AUTORIZACAO_EXIGE, PESSOA_EXIGE, A_VISTA

      FROM PAGAMENTO_FORMA  
      WHERE PAGAMENTO_FORMA_ID = :FORMA_ID
    ),
    FT AS (
      SELECT PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR TIPO_DESCR, DESCR_RED TIPO_DESCR_RED, ATIVO TIPO_ATIVO
      FROM PAGAMENTO_FORMA_TIPO
    )
    SELECT FIRST(1)
      FT.TIPO_ID, FT.TIPO_DESCR, FT.TIPO_DESCR_RED, FT.TIPO_ATIVO,
      F.DESCR, F.DESCR_RED, F.ATIVO, F.PARA_VENDA, F.SIS, F.PROMOCAO_PERMITE,
      F.COMISSAO_PERMITE, F.TAXA_ADM_PERC, F.VALOR_MINIMO, F.COMISSAO_ABATER_PERC,
      F.REEMBOLSO_DIAS, F.TEF_USA, F.AUTORIZACAO_EXIGE, F.PESSOA_EXIGE, F.A_VISTA    
    
    FROM F
    JOIN FT ON F.TIPO_ID = FT.TIPO_ID
    INTO 
      :TIPO_ID
      , :TIPO_DESCR
      , :TIPO_DESCR_RED
      , :TIPO_ATIVO

      , :DESCR
      , :DESCR_RED
      , :ATIVO
      , :PARA_VENDA
      , :SIS
      , :PROMOCAO_PERMITE
      , :COMISSAO_PERMITE
      , :TAXA_ADM_PERC
      , :VALOR_MINIMO
      , :COMISSAO_ABATER_PERC
      , :REEMBOLSO_DIAS
      , :TEF_USA
      , :AUTORIZACAO_EXIGE
      , :PESSOA_EXIGE
      , :A_VISTA

    DO SUSPEND; 
  END

  PROCEDURE LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , FORMA_TIPO_DESCR NOME_INTERM_DOM
    , DESCR NOME_INTERM_DOM
    , DESCR_RED CHAR(8)
    , PARA_VENDA BOOLEAN
    , ATIVO BOOLEAN
  )
  AS
  BEGIN
    FOR
    WITH F AS (
      SELECT PAGAMENTO_FORMA_ID ID, PAGAMENTO_FORMA_TIPO_ID TIPO_ID,
        DESCR, DESCR_RED, PARA_VENDA, ATIVO
      FROM PAGAMENTO_FORMA  
    ),
    FT AS (
      SELECT PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR
      FROM PAGAMENTO_FORMA_TIPO
    )
    SELECT F.ID, FT.DESCR,
      F.DESCR, F.DESCR_RED, F.PARA_VENDA, F.ATIVO
    FROM F
    JOIN FT ON F.TIPO_ID = FT.TIPO_ID
    ORDER BY F.TIPO_ID, F.ID
    INTO :FORMA_ID, :FORMA_TIPO_DESCR, :DESCR, :DESCR_RED,
      :PARA_VENDA, :ATIVO
    DO SUSPEND; 
  END

  PROCEDURE INSERIR_DO
  (
    PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID ID_SHORT_DOM
  )
  AS
  BEGIN
    PAGAMENTO_FORMA_ID = NEXT VALUE FOR PAGAMENTO_FORMA_SEQ;

    INSERT INTO PAGAMENTO_FORMA (PAGAMENTO_FORMA_ID, PAGAMENTO_FORMA_TIPO_ID, 
      DESCR, DESCR_RED, ATIVO, PARA_VENDA, SIS, PROMOCAO_PERMITE,
      COMISSAO_PERMITE, TAXA_ADM_PERC, VALOR_MINIMO, COMISSAO_ABATER_PERC,
      REEMBOLSO_DIAS, TEF_USA, AUTORIZACAO_EXIGE, PESSOA_EXIGE, A_VISTA
    )VALUES(
      :PAGAMENTO_FORMA_ID, :PAGAMENTO_FORMA_TIPO_ID, :DESCR, :DESCR_RED,
      :ATIVO, :PARA_VENDA, :SIS, :PROMOCAO_PERMITE, :COMISSAO_PERMITE,
      :TAXA_ADM_PERC, :VALOR_MINIMO, :COMISSAO_ABATER_PERC, :REEMBOLSO_DIAS,
      :TEF_USA, :AUTORIZACAO_EXIGE, :PESSOA_EXIGE, :A_VISTA);    

    SUSPEND;
  END

  PROCEDURE ALTERAR_DO
  (
    PAGAMENTO_FORMA_ID       ID_SHORT_DOM Not Null
    , PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  )
  AS
  BEGIN
    UPDATE PAGAMENTO_FORMA SET 
      PAGAMENTO_FORMA_TIPO_ID = :PAGAMENTO_FORMA_TIPO_ID,
      DESCR = :DESCR,
      DESCR_RED = :DESCR_RED,
      ATIVO = :ATIVO,
      PARA_VENDA = :PARA_VENDA,
      SIS = :SIS,
      PROMOCAO_PERMITE = :PROMOCAO_PERMITE,
      COMISSAO_PERMITE = :COMISSAO_PERMITE,
      TAXA_ADM_PERC = :TAXA_ADM_PERC,
      VALOR_MINIMO = :VALOR_MINIMO,
      COMISSAO_ABATER_PERC = :COMISSAO_ABATER_PERC,
      REEMBOLSO_DIAS = :REEMBOLSO_DIAS,
      TEF_USA = :TEF_USA,
      AUTORIZACAO_EXIGE = :AUTORIZACAO_EXIGE,
      PESSOA_EXIGE = :PESSOA_EXIGE,
      A_VISTA = :A_VISTA
    WHERE PAGAMENTO_FORMA_ID = :PAGAMENTO_FORMA_ID;
  END
END^
SET TERM ;^