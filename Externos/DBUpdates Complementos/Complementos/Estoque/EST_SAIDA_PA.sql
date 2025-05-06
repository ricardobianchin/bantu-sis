/*

C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque
C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\EST_SAIDA_PA.sql

"C:\Program Files\Notepad++\notepad++.exe" "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\EST_SAIDA_PA.sql"

DROP PACKAGE EST_SAIDA_PA;
DELETE FROM DBUPDATE_HIST WHERE NUM>=111;
COMMIT;

in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\EST_SAIDA_PA.sql";


*/

SET TERM ^;
CREATE OR ALTER PACKAGE EST_SAIDA_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    CRIADO_EM_INICIAL TIMESTAMP NOT NULL,
    CRIADO_EM_FINAL TIMESTAMP NOT NULL
  )
  RETURNS
  (
    LOJA_ID                         ID_SHORT_DOM,
    TERMINAL_ID                     ID_SHORT_DOM,
    EST_MOV_ID                      BIGINT,
    EST_SAIDA_ID                    ID_DOM,
    COD                             VARCHAR(20),
    --DTH_DOC                         TIMESTAMP,
    CRIADO_EM                       TIMESTAMP,
    EST_SAIDA_MOTIVO_ID             ID_SHORT_DOM,
    EST_SAIDA_NOME                  NOME_INTERM_DOM,
    FINALIZADO                      BOOLEAN,
    FINALIZADO_EM                   TIMESTAMP,
    CANCELADO                       BOOLEAN,
    --ALTERADO_EM                     TIMESTAMP,
    CANCELADO_EM                    TIMESTAMP,
    CRIADO_POR_ID                   ID_DOM,
    CRIADO_POR_APELIDO              NOME_REDU_DOM,
    CANCELADO_POR_ID                ID_DOM,
    CANCELADO_POR_APELIDO           NOME_REDU_DOM,
    FINALIZADO_POR_ID               ID_DOM,
    FINALIZADO_POR_APELIDO          NOME_REDU_DOM
  );
END^

RECREATE PACKAGE BODY EST_SAIDA_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    CRIADO_EM_INICIAL TIMESTAMP NOT NULL,
    CRIADO_EM_FINAL TIMESTAMP NOT NULL
  )
  RETURNS
  (
    LOJA_ID                         ID_SHORT_DOM,
    TERMINAL_ID                     ID_SHORT_DOM,
    EST_MOV_ID                      BIGINT,
    EST_SAIDA_ID                    ID_DOM,
    COD                             VARCHAR(20),

    --DTH_DOC                         TIMESTAMP,

    CRIADO_EM                       TIMESTAMP,

    EST_SAIDA_MOTIVO_ID             ID_SHORT_DOM,
    EST_SAIDA_NOME                  NOME_INTERM_DOM,

    FINALIZADO                      BOOLEAN,
    FINALIZADO_EM                   TIMESTAMP,

    CANCELADO                       BOOLEAN,
    --ALTERADO_EM                     TIMESTAMP,
    CANCELADO_EM                    TIMESTAMP,

    CRIADO_POR_ID                   ID_DOM,
    CRIADO_POR_APELIDO              NOME_REDU_DOM,

    CANCELADO_POR_ID                ID_DOM,
    CANCELADO_POR_APELIDO           NOME_REDU_DOM,

    FINALIZADO_POR_ID               ID_DOM,
    FINALIZADO_POR_APELIDO          NOME_REDU_DOM
  )
  AS
  BEGIN
    FOR SELECT
      EM.LOJA_ID,
      EM.TERMINAL_ID,
      EM.EST_MOV_ID,
      ES.EST_SAIDA_ID,
      '' COD,
      
      --EM.DTH_DOC,
      
      EM.CRIADO_EM,
      
      ESM.EST_SAIDA_MOTIVO_ID,
      ESM.NOME,

      EM.FINALIZADO,
      EM.FINALIZADO_EM,

      EM.CANCELADO,
      --EM.ALTERADO_EM,
      EM.CANCELADO_EM,
      
      0 CRIADO_POR_ID,
      '' CRIADO_POR_APELIDO,

      0 CANCELADO_POR_ID,
      '' CANCELADO_POR_APELIDO,

      0 FINALIZADO_POR_ID,
      '' FINALIZADO_POR_APELIDO
      
    FROM EST_MOV EM
    INNER JOIN EST_SAIDA ES
      ON ES.LOJA_ID = EM.LOJA_ID
      AND ES.TERMINAL_ID = EM.TERMINAL_ID
      AND ES.EST_MOV_ID = EM.EST_MOV_ID
    INNER JOIN EST_SAIDA_MOTIVO ESM
      ON ESM.EST_SAIDA_MOTIVO_ID = ES.EST_SAIDA_MOTIVO_ID
    WHERE
      (
        :CRIADO_EM_INICIAL = '01.01.1900' OR
        EM.CRIADO_EM >= :CRIADO_EM_INICIAL
      )
      AND
      (
        :CRIADO_EM_FINAL = '01.01.1900' OR
        EM.CRIADO_EM <= :CRIADO_EM_FINAL
      )
    INTO
      :LOJA_ID,
      :TERMINAL_ID,
      :EST_MOV_ID,
      :EST_SAIDA_ID,
      :COD,

      --:DTH_DOC,

      :CRIADO_EM,

      :EST_SAIDA_MOTIVO_ID,
      :EST_SAIDA_NOME,

      :FINALIZADO,
      :FINALIZADO_EM,

      :CANCELADO,
      --:ALTERADO_EM,
      :CANCELADO_EM,

      :CRIADO_POR_ID,
      :CRIADO_POR_APELIDO,

      :CANCELADO_POR_ID,
      :CANCELADO_POR_APELIDO,

      :FINALIZADO_POR_ID,
      :FINALIZADO_POR_APELIDO
    DO
      SUSPEND;
  END
END^

SET TERM ;^
