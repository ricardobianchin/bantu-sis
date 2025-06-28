/*
C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\PROMO_PA.sql
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\PROMO_PA.sql";

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
        LOJA_ID,
        PROMO_ID,
        '' COD,
        NOME,
        ATIVO,
        INICIA_EM,
        TERMINA_EM
      FROM
        PROMO
      WHERE
        LOJA_ID = :LOJA_ID
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
END^
SET TERM ;^
