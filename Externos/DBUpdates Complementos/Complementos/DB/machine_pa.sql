/*
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\DB\MACHINE_PA.sql";
*/

SET TERM ^;
CREATE OR ALTER PACKAGE MACHINE_PA
AS
BEGIN
  PROCEDURE BYIDENT_GET
  (
    NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
  )
  RETURNS
  (
    MACHINE_ID_RET ID_SHORT_DOM
  );
END^

-------- BODY

RECREATE PACKAGE BODY MACHINE_PA
AS
BEGIN
  PROCEDURE BYIDENT_GET
  (
    NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
  )
  RETURNS
  (
    MACHINE_ID_RET ID_SHORT_DOM
  )
  AS
  BEGIN
    SELECT FIRST(1) MACHINE_ID
    FROM MACHINE
    WHERE NOME_NA_REDE = :NOME_NA_REDE
      AND IP = :IP
    INTO :MACHINE_ID_RET;
    
    IF (:MACHINE_ID_RET IS NULL) THEN
    BEGIN
      MACHINE_ID_RET = NEXT VALUE FOR MACHINE_SEQ;

      INSERT INTO MACHINE
      (
        MACHINE_ID,
        NOME_NA_REDE,
        IP
      ) VALUES (
        :MACHINE_ID_RET,
        :NOME_NA_REDE,
        :IP
      );
    END
    
    SUSPEND;
  END
END^
SET TERM ;^
