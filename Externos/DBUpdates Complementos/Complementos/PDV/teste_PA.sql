/*
in "C:\Pr\App\Bantu\bantu-sis\src\Externos\DBUpdates Complementos\Complementos\PDV\TESTE_pa.sql";


SELECT * FROM TESTE_PA.SESS_RELAT_BYID_GET(1, 1, 1);
*/
SET TERM ^;
CREATE OR ALTER PACKAGE TESTE_PA
AS
BEGIN
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

RECREATE PACKAGE BODY TESTE_PA
AS
BEGIN
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
    -- INICIO DO RELATORIO INICIO
    DECLARE OPERADOR_LOJA_ID ID_SHORT_DOM;
    DECLARE OPERADOR_ID ID_DOM;
    DECLARE OPERADOR_APELIDO NOME_REDU_DOM;
    DECLARE CRIADO_EM TIMESTAMP;
    DECLARE FECHADO_EM TIMESTAMP;
    -- INICIO DO RELATORIO FIM

    DECLARE TIPO_ID ID_CHAR_DOM;
    DECLARE TIPO_NAME NOME_INTERM_DOM;
    DECLARE TIPO_SINAL_NUMERICO SMALLINT; 
    DECLARE TOTAL DINH_DOM;

    DECLARE FORMA_ID ID_SHORT_DOM;
    DECLARE DESCR NOME_DOM;
  BEGIN
    -- INICIO DO RELATORIO INICIO
    SELECT
      OPERADOR_LOJA_ID
      , OPERADOR_ID
      , OPERADOR_APELIDO
      , CRIADO_EM
    FROM CAIXA_SESSAO_PDV_PA.SESS_GET
    (
      :LOJA_ID
      , :TERMINAL_ID
      , :SESS_ID
    )
    INTO
      :OPERADOR_LOJA_ID
      , :OPERADOR_ID
      , :OPERADOR_APELIDO
      , :CRIADO_EM;

    LINHA = :OPERADOR_LOJA_ID;
    SUSPEND;
    
    LINHA = :OPERADOR_ID;
    SUSPEND;
    
    LINHA = :OPERADOR_APELIDO;
    SUSPEND;
    
    LINHA = :CRIADO_EM;
    SUSPEND;
    -- INICIO DO RELATORIO FIM

    SELECT L.DTH 

    FROM CAIXA_SESSAO_OPERACAO O

    JOIN LOG L ON
    O.LOJA_ID = L.LOJA_ID
    AND O.TERMINAL_ID = L.TERMINAL_ID
    AND O.OPER_LOG_ID = L.LOG_ID

    WHERE O.LOJA_ID = :LOJA_ID
    AND O.TERMINAL_ID = :TERMINAL_ID 
    AND O.SESS_ID = :SESS_ID
    AND O.OPER_TIPO_ID = '('
    AND NOT O.CANCELADO
    INTO
      :FECHADO_EM;

    :FECHADO_EM = COALESCE(:FECHADO_EM, '1900-01-01 00:00:00.000');  

    LINHA = :FECHADO_EM;
    SUSPEND;
    
    FOR 
      SELECT 
        O.OPER_TIPO_ID
        , T.NAME
        , T.SINAL_NUMERICO
        , SUM(V.VALOR) AS TOTAL

      FROM CAIXA_SESSAO_OPERACAO_TIPO T

      JOIN CAIXA_SESSAO_OPERACAO O ON
      T.OPER_TIPO_ID = O.OPER_TIPO_ID

      JOIN CAIXA_SESSAO_OPERACAO_VALOR V ON
      O.LOJA_ID = V.LOJA_ID
      AND O.TERMINAL_ID = V.TERMINAL_ID
      AND O.SESS_ID = V.SESS_ID
      AND O.OPER_ORDEM = V.OPER_ORDEM

      WHERE NOT O.CANCELADO
      AND O.OPER_TIPO_ID <> '('

      GROUP BY 
        O.OPER_TIPO_ID
        , T.NAME
        , T.SINAL_NUMERICO
      ORDER BY
        O.OPER_TIPO_ID
    INTO
      :TIPO_ID
      , :TIPO_NAME
      , :TIPO_SINAL_NUMERICO
      , :TOTAL
     DO
     BEGIN
        LINHA = '2;' || :TIPO_NAME || ';' || :TIPO_SINAL_NUMERICO || ';' || :TOTAL;
--        LINHA = :TIPO_NAME /*|| ';' || CAST(:TIPO_SINAL_NUMERICO AS VARCHAR(2)) || ';' || :TOTAL*/;
        SUSPEND;
     END
    

    --SELECT F.FORMA_ID, FDESCR 
    --FROM CAIXA_SESSAO_PDV_PA.SESS_RELAT_PAGFORMA_LISTA_GET F;


  END
END^
SET TERM ;^
