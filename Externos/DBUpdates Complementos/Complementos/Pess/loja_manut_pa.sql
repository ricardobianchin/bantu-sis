SET TERM ^;
CREATE OR ALTER PACKAGE LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    P_LOJA_ID ID_SHORT_DOM NOT NULL
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    , GENERO_ID CHAR(1)
    , GENERO_DESCR NOME_CURTO_DOM
    , ESTADO_CIVIL_ID CHAR(1)
    , ESTADO_CIVIL_DESCR NOME_CURTO_DOM
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)
    , MUNICIPIO_NOME    NOME_DOM
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS_GRANDE_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
    , SELECIONADO BOOLEAN
  );
  
  --LISTA_GET FIM

  -- LOJA_MANUT_PA.GARANTIR DEF
  PROCEDURE GARANTIR(
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,
    
    NOME NOME_DOM,
    NOME_FANTASIA NOME_DOM,
    APELIDO NOME_REDU_DOM,
    
    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),
    
    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),
    
    EMAIL VARCHAR(50),
    DT_NASC DATE,
    ATIVO BOOLEAN,
    
    PESSOA_ID INTEGER,

    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,
    
    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(7),
    
    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,
    
    CONTATO           NOME_DOM,
    REFERENCIA        OBS_GRANDE_DOM
    
    , SELECIONADO BOOLEAN

    , LOG_LOJA_ID ID_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM
  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_RET INTEGER
  );
END^

----- body -----

RECREATE PACKAGE BODY LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    P_LOJA_ID ID_SHORT_DOM NOT NULL
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , APELIDO NOME_REDU_DOM    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    , GENERO_ID CHAR(1)
    , GENERO_DESCR NOME_CURTO_DOM
    , ESTADO_CIVIL_ID CHAR(1)
    , ESTADO_CIVIL_DESCR NOME_CURTO_DOM
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)
    , MUNICIPIO_NOME    NOME_DOM
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS_GRANDE_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
    , SELECIONADO BOOLEAN
  )
  AS
  BEGIN
    FOR
      WITH LO AS
      (
        SELECT 
          LOJA_ID, 
          APELIDO, 
          SELECIONADO
        FROM 
          LOJA
        WHERE (:P_LOJA_ID = 0) OR (:P_LOJA_ID = LOJA_ID)
        ORDER BY LOJA_ID
      )
      , PE AS
      (
        SELECT
          P.LOJA_ID,
          P.TERMINAL_ID,
          P.PESSOA_ID, 
          P.NOME, 
          P.NOME_FANTASIA, 
          P.C, 
          P.I, 
          P.M, 
          P.M_UF, 
          P.EMAIL, 
          P.DT_NASC, 
          P.ATIVO,
          P.CRIADO_EM PESS_CRIADO_EM,
          P.ALTERADO_EM PESS_ALTERADO_EM, 
          
          E.ORDEM ENDER_ORDEM,
          E.LOGRADOURO,
          E.NUMERO,
          E.COMPLEMENTO,
          E.BAIRRO,
          E.UF_SIGLA,
          E.CEP,
          E.MUNICIPIO_IBGE_ID,
          MU.NOME MUNICIPIO_NOME,
          E.DDD,
          E.FONE1,
          E.FONE2,
          E.FONE3,
          E.CONTATO,
          E.REFERENCIA,
          E.CRIADO_EM ENDER_CRIADO_EM,
          E.ALTERADO_EM ENDER_ALTERADO_EM
          
        FROM 
          LOJA_EH_PESSOA LP 
        JOIN 
          PESSOA P ON LP.LOJA_ID = P.LOJA_ID AND LP.TERMINAL_ID = P.TERMINAL_ID AND LP.PESSOA_ID = P.PESSOA_ID
        LEFT JOIN 
          ENDERECO E ON P.LOJA_ID = E.LOJA_ID AND P.TERMINAL_ID = E.TERMINAL_ID AND P.PESSOA_ID = E.PESSOA_ID AND E.ORDEM = 0
        LEFT JOIN
          MUNICIPIO MU ON MU.MUNICIPIO_IBGE_ID = E.MUNICIPIO_IBGE_ID
      )
      SELECT 
        LO.LOJA_ID,
        PE.TERMINAL_ID,
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
        PE.ATIVO,
        
        PE.PESS_CRIADO_EM, 
        PE.PESS_ALTERADO_EM, 
        
        PE.ENDER_ORDEM,
        PE.LOGRADOURO,
        PE.NUMERO,
        PE.COMPLEMENTO,
        PE.BAIRRO,
        PE.UF_SIGLA,
        PE.CEP,
        PE.MUNICIPIO_IBGE_ID,
        PE.MUNICIPIO_NOME,
        PE.DDD,
        PE.FONE1,
        PE.FONE2,
        PE.FONE3,
        PE.CONTATO,
        PE.REFERENCIA,
        PE.ENDER_CRIADO_EM,
        PE.ENDER_ALTERADO_EM,
        LO.SELECIONADO
     FROM LO
      LEFT JOIN PE ON
      LO.LOJA_ID = PE.LOJA_ID

    INTO 
      :LOJA_ID
      , :TERMINAL_ID
      , :PESSOA_ID
      , :APELIDO

      , :NOME
      , :NOME_FANTASIA
      
      , :C
      , :I
      , :M
      , :M_UF
      
      , :EMAIL
      , :DT_NASC
      , :ATIVO
      
      , :PESS_CRIADO_EM
      , :PESS_ALTERADO_EM
      
      , :ENDER_ORDEM
      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP
      , :MUNICIPIO_IBGE_ID
      , :MUNICIPIO_NOME
      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3
      , :CONTATO
      , :REFERENCIA

      , :ENDER_CRIADO_EM
      , :ENDER_ALTERADO_EM

      , :SELECIONADO
    
    DO 
      SUSPEND; 
  END


  -- LOJA_MANUT_PA.GARANTIR IMP
  PROCEDURE GARANTIR(
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,

    NOME NOME_DOM,
    NOME_FANTASIA NOME_DOM,
    APELIDO NOME_REDU_DOM,

    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),

    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),

    EMAIL VARCHAR(50),
    DT_NASC DATE,
    ATIVO BOOLEAN,

    PESSOA_ID INTEGER,

    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,

    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(7),

    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,

    CONTATO           NOME_DOM,
    REFERENCIA        OBS_GRANDE_DOM

    , SELECIONADO BOOLEAN

    , LOG_LOJA_ID ID_DOM NOT NULL
    , LOG_PESSOA_ID ID_DOM NOT NULL
    , MACHINE_ID ID_SHORT_DOM

  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_RET INTEGER
  )
  AS
  BEGIN
    -- LOJA_MANUT_PA.GARANTIR COD
    SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET 
	FROM PESSOA_PA.GARANTIR(
      :LOJA_ID,
      :TERMINAL_ID,
	  
      :NOME,
      :NOME_FANTASIA,
      :APELIDO,
	  
      :GENERO_ID,
      :ESTADO_CIVIL_ID,
	  
      :C,
      :I,
      :M,
      :M_UF,
	  
      :EMAIL,
      :DT_NASC,
      :ATIVO,
	  
      :PESSOA_ID,
	  
      :LOGRADOURO,
      :NUMERO,
      :COMPLEMENTO,
      :BAIRRO,
	  
      :UF_SIGLA,
      :CEP,
      :MUNICIPIO_IBGE_ID,
	  
      :DDD,
      :FONE1,
      :FONE2,
      :FONE3,
	  
      :CONTATO,
      :REFERENCIA
    ) INTO LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET;

    EXECUTE PROCEDURE LOJA_INICIAL_PA.GARANTIR(
	  :LOJA_ID, :APELIDO, :SELECIONADO, :LOG_LOJA_ID, :LOG_PESSOA_ID,
	  :MACHINE_ID);

    UPDATE OR INSERT INTO LOJA_EH_PESSOA (LOJA_ID, TERMINAL_ID, PESSOA_ID)
    VALUES (:LOJA_ID_RET, :TERMINAL_ID_RET, :PESSOA_ID_RET)
    MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID);

    SUSPEND;
  END
END^
SET TERM ;^
