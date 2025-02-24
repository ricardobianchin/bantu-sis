/*
SELECT * FROM CAIXA_SESSAO_PDV_PA.FECH_PAGFORMA_LISTA_GET;
SELECT * FROM CAIXA_SESSAO_PDV_PA.SESS_VENDA_PAG_TOTAL_GET(1,1,1);
SELECT * FROM PAGAMENTO_FORMA_PA.ABREV_LISTA_GET;

*/
SET TERM ^;
CREATE OR ALTER PACKAGE CAIXA_SESSAO_PDV_PA
AS
BEGIN
  PROCEDURE TEM_CAIXA_ABERTO
  RETURNS
  (  
    TEM BOOLEAN
  );
  
  PROCEDURE TEM_VENDA_NAO_FINALIZADA
  RETURNS
  (  
    TEM BOOLEAN
  );
  
  PROCEDURE FECHAR_PODE_GET
  RETURNS
  (
    PODE BOOLEAN
    , MENSAGEM_ID ID_DOM
  );
  
  PROCEDURE FECH_PAGFORMA_LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , DESCR NOME_DOM
  );
  
  PROCEDURE FECH_RELAT_PAGFORMA_LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , DESCR NOME_DOM
  );
  
  PROCEDURE SESS_VENDA_PAG_TOTAL_GET
  (
    SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , TOTAL PRECO_DOM
  );  
  
  PROCEDURE SESS_RELAT_BYID_GET
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    LINHA VARCHAR(80)
  );
END^

---- BODY

RECREATE PACKAGE BODY CAIXA_SESSAO_PDV_PA
AS
BEGIN
/*
SELECT * FROM CAIXA_SESSAO_PDV_PA.TEM_CAIXA_ABERTO;
*/
  PROCEDURE TEM_CAIXA_ABERTO
  RETURNS
  (  
    TEM BOOLEAN
  )
  AS
    DECLARE RESULTADO INTEGER;
  BEGIN
    SELECT 1 FROM RDB$DATABASE WHERE EXISTS (
      SELECT SESS.SESS_ID

      FROM AMBIENTE_SIS AMBI

      JOIN CAIXA_SESSAO SESS ON
      AMBI.LOJA_ID = SESS.LOJA_ID
      AND AMBI.TERMINAL_ID  = SESS.TERMINAL_ID

      WHERE SESS.ABERTO 
    ) INTO :RESULTADO;
    
    :RESULTADO = COALESCE(:RESULTADO, 0);
    
    :TEM = :RESULTADO = 1;
    SUSPEND;
  END
  
/*  
SELECT * FROM CAIXA_SESSAO_PDV_PA.TEM_VENDA_NAO_FINALIZADA;
*/
  PROCEDURE TEM_VENDA_NAO_FINALIZADA
  RETURNS
  (  
    TEM BOOLEAN
  )
  AS
    DECLARE RESULTADO INTEGER;
  BEGIN
    SELECT 1 FROM RDB$DATABASE WHERE EXISTS (
      SELECT SESS.SESS_ID

      FROM AMBIENTE_SIS AMBI

      JOIN CAIXA_SESSAO SESS ON
      AMBI.LOJA_ID = SESS.LOJA_ID
      AND AMBI.TERMINAL_ID  = SESS.TERMINAL_ID

      JOIN VENDA V ON
      V.SESS_LOJA_ID = SESS.LOJA_ID
      AND V.SESS_TERMINAL_ID  = SESS.TERMINAL_ID
      AND V.SESS_ID = SESS.SESS_ID

      JOIN EST_MOV E ON
      V.LOJA_ID = E.LOJA_ID
      AND V.TERMINAL_ID = E.TERMINAL_ID
      AND V.EST_MOV_ID = E.EST_MOV_ID

      WHERE SESS.ABERTO AND (NOT E.FINALIZADO) AND (NOT E.CANCELADO)
      ) INTO :RESULTADO;
    
    :RESULTADO = COALESCE(:RESULTADO, 0);
    
    :TEM = :RESULTADO = 1;
    SUSPEND;
  END
  
/*
SELECT * FROM CAIXA_SESSAO_PDV_PA.FECHAR_PODE_GET;
*/
  PROCEDURE FECHAR_PODE_GET
  RETURNS
  (
    PODE BOOLEAN
    , MENSAGEM_ID ID_DOM
  )
  AS
/*
  1 = 'Pode fechar o caixa';
  2 = 'N�o h� caixa aberto';
  3 = 'H� uma venda n�o finalizada';
*/  
    DECLARE TEM_CX_ABERTO BOOLEAN;
    DECLARE TEM_VEN_NAO_FIN BOOLEAN;
  BEGIN
    PODE = TRUE;
    MENSAGEM_ID = 1;
    
    SELECT TEM FROM CAIXA_SESSAO_PDV_PA.TEM_CAIXA_ABERTO INTO :TEM_CX_ABERTO;
    
    IF (NOT :TEM_CX_ABERTO) THEN
    BEGIN
      PODE = FALSE;
      MENSAGEM_ID = 2;
      SUSPEND;
      EXIT;
    END

    SELECT TEM FROM CAIXA_SESSAO_PDV_PA.TEM_VENDA_NAO_FINALIZADA INTO :TEM_VEN_NAO_FIN;
    
    IF (:TEM_VEN_NAO_FIN) THEN
    BEGIN
      PODE = FALSE;
      MENSAGEM_ID = 3;
      SUSPEND;
      EXIT;
    END

    SUSPEND;
  END
  
  PROCEDURE FECH_PAGFORMA_LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , DESCR NOME_DOM
  )
  AS
  BEGIN
    FOR
      WITH TIPO AS 
      (
        SELECT PAGAMENTO_FORMA_TIPO_ID ID, DESCR_RED
        FROM PAGAMENTO_FORMA_TIPO
        WHERE ATIVO
      ), FORMA AS
      (
          SELECT PAGAMENTO_FORMA_ID ID, PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR
          FROM PAGAMENTO_FORMA
          WHERE ATIVO AND PARA_VENDA
      )
      SELECT 
        FORMA.ID, 
        CASE
          WHEN TIPO.ID = '!' THEN FORMA.DESCR
          WHEN TIPO.ID = '"' THEN FORMA.DESCR || ' ' || TIPO.DESCR_RED
          WHEN TIPO.ID = '#' THEN FORMA.DESCR || ' ' || TIPO.DESCR_RED
          WHEN TIPO.ID = '$' THEN TIPO.DESCR_RED || ' ' || FORMA.DESCR
        END AS DESCR
      FROM TIPO
      JOIN FORMA ON
      TIPO.ID = FORMA.TIPO_ID
      ORDER BY FORMA.ID
    INTO :FORMA_ID, :DESCR
    DO SUSPEND;
  END
  
  PROCEDURE FECH_RELAT_PAGFORMA_LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , DESCR NOME_DOM
  )
  AS
  BEGIN
    FOR
      WITH TIPO AS 
      (
        SELECT PAGAMENTO_FORMA_TIPO_ID ID, DESCR_RED
        FROM PAGAMENTO_FORMA_TIPO
        WHERE ATIVO
      ), FORMA AS
      (
          SELECT PAGAMENTO_FORMA_ID ID, PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR_RED
          FROM PAGAMENTO_FORMA
          WHERE ATIVO AND PARA_VENDA
      )
      SELECT 
        FORMA.ID, 
        CASE
          WHEN TIPO.ID = '!' THEN FORMA.DESCR_RED
          WHEN TIPO.ID = '"' THEN FORMA.DESCR_RED || ' ' || TIPO.DESCR_RED
          WHEN TIPO.ID = '#' THEN FORMA.DESCR_RED || ' ' || TIPO.DESCR_RED
          WHEN TIPO.ID = '$' THEN FORMA.DESCR
        END AS DESCR
      FROM TIPO
      JOIN FORMA ON
      TIPO.ID = FORMA.TIPO_ID
      ORDER BY FORMA.ID
    INTO :FORMA_ID, :DESCR
    DO SUSPEND;
  END
  
  PROCEDURE SESS_VENDA_PAG_TOTAL_GET
  (
    SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , TOTAL PRECO_DOM
  )
  AS
  BEGIN
    FOR 
      WITH V AS (
        SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID, VENDA_ID
        FROM VENDA
        WHERE 
          SESS_LOJA_ID = :SESS_LOJA_ID
          AND SESS_TERMINAL_ID = :SESS_TERMINAL_ID
          AND SESS_ID = :SESS_ID
      ), 
      PAG AS (
        SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID, PAGAMENTO_FORMA_ID, VALOR_DEVIDO
        FROM VENDA_PAG
        WHERE NOT CANCELADO
      ),
      E AS (
        SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID
        FROM EST_MOV
        WHERE NOT CANCELADO AND FINALIZADO
      )
      SELECT 
        PAG.PAGAMENTO_FORMA_ID, 
        SUM(PAG.VALOR_DEVIDO) AS TOTAL
      FROM V
      JOIN PAG 
        ON V.LOJA_ID = PAG.LOJA_ID 
        AND V.TERMINAL_ID = PAG.TERMINAL_ID 
        AND V.EST_MOV_ID = PAG.EST_MOV_ID
      JOIN E 
        ON V.LOJA_ID = E.LOJA_ID 
        AND V.TERMINAL_ID = E.TERMINAL_ID 
        AND V.EST_MOV_ID = E.EST_MOV_ID
      GROUP BY PAG.PAGAMENTO_FORMA_ID
    INTO :FORMA_ID, :TOTAL
    DO SUSPEND;
  END
  
  PROCEDURE SESS_RELAT_BYID_GET
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    LINHA VARCHAR(80)
  )
  AS
  BEGIN
    FOR 
      SELECT 'FP;' || FORMA_ID || ';' || DESCR
      FROM PAGAMENTO_FORMA_PA.ABREV_LISTA_GET -- (:LOJA_ID, :TERMINAL_ID, :SESS_ID)
    INTO LINHA
    DO SUSPEND;
  END
END^
SET TERM ;^
