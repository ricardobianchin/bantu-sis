SET TERM ^;
CREATE OR ALTER PACKAGE LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    ATIVO BOOLEAN
    , LOJA_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM
    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    
    , EDITADO_EM TIMESTAMP
    , CRIADO_EM TIMESTAMP
  );
END^

RECREATE PACKAGE BODY LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    ATIVO BOOLEAN
    , LOJA_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM

    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    
    , EDITADO_EM TIMESTAMP
    , CRIADO_EM TIMESTAMP
  )
  AS
  BEGIN
    FOR
      WITH LO AS
      (
        SELECT 
          LOJA_ID, 
          APELIDO, 
          ATIVO
        FROM 
          LOJA
      )
      , PE AS
      (
        SELECT
          P.LOJA_ID,
          P.PESSOA_ID, 
          P.NOME, 
          P.NOME_FANTASIA, 
          P.GENERO_ID, 
          P.ESTADO_CIVIL_ID, 
          P.C, 
          P.I, 
          P.M, 
          P.M_UF, 
          P.EMAIL, 
          P.DT_NASC, 
          P.EDITADO_EM, 
          P.CRIADO_EM
        FROM 
          LOJA_EH_PESSOA LP 
        JOIN 
          PESSOA P ON LP.LOJA_ID = P.LOJA_ID AND LP.TERMINAL_ID = P.TERMINAL_ID AND LP.PESSOA_ID = P.PESSOA_ID
      )
      SELECT 
        LO.ATIVO,
        LO.LOJA_ID,
        PE.PESSOA_ID, 
        LO.APELIDO, 
        
        PE.NOME, 
        PE.NOME_FANTASIA, 
        
        PE.C, 
        PE.I, 
        PE.M, 
        PE.M_UF, 
        
        PE.EMAIL, 
        PE.DT_NASC, 
        
        PE.EDITADO_EM, 
        PE.CRIADO_EM
      FROM LO
      LEFT JOIN PE ON
      LO.LOJA_ID = PE.LOJA_ID

    INTO 
      ATIVO
      , LOJA_ID
      , PESSOA_ID
      , APELIDO

      , NOME
      , NOME_FANTASIA
      
      , C
      , I
      , M
      , M_UF
      
      , EMAIL
      , DT_NASC
      
      , EDITADO_EM
      , CRIADO_EM
    
    DO 
    SUSPEND; 
  END
END^
SET TERM ;^
