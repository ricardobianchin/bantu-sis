/*
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Config\import_prod_pa.sql";

execute procedure IMPORT_PROD_PA.APAGAR_DO;
*/

SET TERM ^;
CREATE OR ALTER PACKAGE IMPORT_PROD_PA
AS
BEGIN
  PROCEDURE INSERIR_DO (
    PROD_ID ID_DOM,

    DESCR PROD_DESCR_DOM,
    DESCR_RED PROD_DESCR_DOM,

    IMPORT_FABR_ID ID_DOM,
    IMPORT_PROD_TIPO_ID ID_DOM,
    IMPORT_UNID_ID ID_DOM,
    IMPORT_ICMS_ID ID_DOM,

    PROD_NATU_ID ID_CHAR_DOM,

    CAPAC_EMB QTD_DOM,
    NCM CHAR(8),

    CUSTO CUSTO_DOM,

    ATIVO BOOLEAN,
    LOCALIZ NOME_CURTO_DOM,
    MARGEM PERC_DOM,

    BAL_USO SMALLINT,
    BAL_DPTO CHAR(3),
    BAL_VALIDADE_DIAS SMALLINT,
    BAL_TEXTO_ETIQ VARCHAR(400)
  )
  RETURNS
  (  
    IMPORT_PROD_ID ID_DOM
  );

  PROCEDURE APAGAR_DO;  
END^

----- body -----

RECREATE PACKAGE BODY IMPORT_PROD_PA
AS
BEGIN
  PROCEDURE INSERIR_DO (
    PROD_ID ID_DOM,
    DESCR PROD_DESCR_DOM,
    DESCR_RED PROD_DESCR_DOM,
    IMPORT_FABR_ID ID_DOM,
    IMPORT_PROD_TIPO_ID ID_DOM,
    IMPORT_UNID_ID ID_DOM,
    IMPORT_ICMS_ID ID_DOM,
    PROD_NATU_ID ID_CHAR_DOM,
    CAPAC_EMB QTD_DOM,
    NCM CHAR(8),
    CUSTO CUSTO_DOM,
    ATIVO BOOLEAN,
    LOCALIZ NOME_CURTO_DOM,
    MARGEM PERC_DOM,
    BAL_USO SMALLINT,
    BAL_DPTO CHAR(3),
    BAL_VALIDADE_DIAS SMALLINT,
    BAL_TEXTO_ETIQ VARCHAR(400)
  )
  RETURNS
  (  
    IMPORT_PROD_ID ID_DOM
  )
  AS
  BEGIN
    IMPORT_PROD_ID = NEXT VALUE FOR IMPORT_PROD_SEQ;

    INSERT INTO IMPORT_PROD (
      IMPORT_PROD_ID,
      PROD_ID,
      DESCR,
      DESCR_RED,
      IMPORT_FABR_ID,
      IMPORT_PROD_TIPO_ID,
      IMPORT_UNID_ID,
      IMPORT_ICMS_ID,
      PROD_NATU_ID,
      CAPAC_EMB,
      NCM,
      CUSTO,
      ATIVO,
      LOCALIZ,
      MARGEM,
      BAL_USO,
      BAL_DPTO,
      BAL_VALIDADE_DIAS,
      BAL_TEXTO_ETIQ)
    VALUES 
    (
      :IMPORT_PROD_ID,
      :PROD_ID,
      :DESCR,
      :DESCR_RED,
      :IMPORT_FABR_ID,
      :IMPORT_PROD_TIPO_ID,
      :IMPORT_UNID_ID,
      :IMPORT_ICMS_ID,
      :PROD_NATU_ID,
      :CAPAC_EMB,
      :NCM,
      :CUSTO,
      :ATIVO,
      :LOCALIZ,
      :MARGEM,
      :BAL_USO,
      :BAL_DPTO,
      :BAL_VALIDADE_DIAS,
      :BAL_TEXTO_ETIQ
    );
  END

  PROCEDURE APAGAR_DO
  AS
  BEGIN
    DELETE FROM PROD_BARRAS;
    DELETE FROM PROD_COMPL;
    DELETE FROM PROD_CUSTO;
    DELETE FROM PROD_CUSTO_HIST;
    DELETE FROM PROD_PRECO;
    DELETE FROM PROD_PRECO_HIST;
    DELETE FROM PROD;
    DELETE FROM LOG_PK;
    DELETE FROM LOG;
    DELETE FROM FABR WHERE FABR_ID > 0;
    DELETE FROM PROD_TIPO WHERE PROD_TIPO_ID > 0;
    DELETE FROM ICMS WHERE ICMS_ID > 3;
    DELETE FROM UNID WHERE UNID_ID > 0;
    DELETE FROM IMPORT_PROD_CONFLITO;
    DELETE FROM IMPORT_PROD_BARRAS;
    DELETE FROM IMPORT_PROD_PRECO;
    DELETE FROM IMPORT_PROD;
    DELETE FROM IMPORT_FABR WHERE IMPORT_FABR_ID > 0;
    DELETE FROM IMPORT_PROD_TIPO WHERE IMPORT_PROD_TIPO_ID > 0;
    DELETE FROM IMPORT_UNID WHERE IMPORT_UNID_ID > 0;
    DELETE FROM IMPORT_ICMS WHERE IMPORT_ICMS_ID > 3;
    EXECUTE STATEMENT('ALTER SEQUENCE PROD_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE FABR_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PROD_TIPO_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE UNID_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE ICMS_SEQ RESTART WITH  4;');
    EXECUTE STATEMENT('ALTER SEQUENCE LOG_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE MACHINE_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PESSOA_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE IMPORT_FABR_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE IMPORT_PROD_TIPO_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE IMPORT_UNID_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE IMPORT_ICMS_SEQ RESTART WITH  4;');
    EXECUTE STATEMENT('ALTER SEQUENCE IMPORT_PROD_SEQ RESTART WITH  1;');
  END
END^
SET TERM ;^
