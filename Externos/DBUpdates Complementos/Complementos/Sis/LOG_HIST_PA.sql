SET TERM ^;
CREATE OR ALTER PACKAGE LOG_HIST_PA
AS
BEGIN
  FUNCTION ULTIMO_LOG_ID_GET
  RETURNS BIGINT;

  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
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
    , ATIVO BOOLEAN
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  );  
  
  PROCEDURE TEVE_TERMINAL
  (
    TERMINAL_ID_ALVO ID_SHORT_DOM
    , LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    TERMINAL_ID ID_SHORT_DOM
    , APELIDO NOME_REDU_DOM
    , NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
    , NF_SERIE SMALLINT
    , LETRA_DO_DRIVE CHAR(1)
    , GAVETA_TEM BOOLEAN
    , BALANCA_MODO_ID ID_SHORT_DOM
    , BALANCA_ID ID_SHORT_DOM
    , BARRAS_COD_INI SMALLINT
    , BARRAS_COD_TAM SMALLINT
    , CUPOM_NLINS_FINAL SMALLINT
    , SEMPRE_OFFLINE BOOLEAN
  );  
  
  PROCEDURE TEVE_PAGAMENTO_FORMA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID          ID_SHORT_DOM
    , PAGAMENTO_FORMA_TIPO_ID     ID_CHAR_DOM
    , DESCR                       NOME_INTERM_DOM
    , DESCR_RED                   CHAR(8)
    , ATIVO                       BOOLEAN
    , PARA_VENDA                  BOOLEAN
    , DE_SISTEMA                  BOOLEAN
    , PROMOCAO_PERMITE            BOOLEAN
    , COMISSAO_PERMITE            BOOLEAN
    , TAXA_ADM_PERC               PERC_DOM
    , VALOR_MINIMO                PRECO_DOM
    , COMISSAO_ABATER_PERC        PERC_DOM
    , REEMBOLSO_DIAS              SMALLINT
    , TEF_USA                     BOOLEAN
    , AUTORIZACAO_EXIGE           BOOLEAN
    , PESSOA_EXIGE                BOOLEAN
    , A_VISTA                     BOOLEAN
  );
  
  PROCEDURE TEVE_FUNCIONARIO_USUARIO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , NOME NOME_DOM 
    , NOME_FANTASIA NOME_DOM
    , APELIDO NOME_REDU_DOM
    , GENERO_ID CHAR 
    , ESTADO_CIVIL_ID CHAR 
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO ATIVO_DOM
    , CRIADO_EM TIMESTAMP
    , ALTERADO_EM TIMESTAMP
    , ORDEM SMALLINT
    , LOGRADOURO VARCHAR(70)
    , NUMERO NOME_DOM
    , COMPLEMENTO NOME_DOM
    , BAIRRO NOME_DOM
    , UF_SIGLA CHAR
    , CEP CHAR(8)
    , MUNICIPIO_IBGE_ID CHAR
    , DDD CHAR(2)
    , FONE1 NOME_CURTO_DOM
    , FONE2 NOME_CURTO_DOM
    , FONE3 NOME_CURTO_DOM
    , CONTATO NOME_DOM
    , REFERENCIA OBS1_DOM
    , NOME_DE_USUARIO NOME_REDU_DOM
    , SENHA SENHA_DOM 
    , CRY_VER ID_SHORT_DOM
    , DE_SISTEMA BOOLEAN
  );
  
  PROCEDURE TEVE_USUARIO_PODE_OPCAO_SIS
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , OPCAO_SIS_ID ID_DOM
  );
END^

------ BODY

RECREATE PACKAGE BODY LOG_HIST_PA
AS
BEGIN
  FUNCTION ULTIMO_LOG_ID_GET
  RETURNS BIGINT
  AS
    DECLARE VARIABLE LOG_ID_RET BIGINT;
  BEGIN
    SELECT MAX(LOG.LOG_ID)
    FROM LOG
    JOIN AMBIENTE_SIS ON AMBIENTE_SIS.LOJA_ID = LOG.LOJA_ID
    WHERE LOG.TERMINAL_ID = 0
    INTO :LOG_ID_RET;

    RETURN :LOG_ID_RET;
  END 

  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
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
    , ATIVO BOOLEAN
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    SELECT FIRST(1)
      LOJA.LOJA_ID
      , P.TERMINAL_ID
      , P.PESSOA_ID
      
      , LOJA.APELIDO

      , P.NOME
      , P.NOME_FANTASIA
      
      , P.C
      , P.I
      , P.M
      , P.M_UF
      , P.EMAIL
      , P.DT_NASC
      , P.ATIVO
      
      , P.CRIADO_EM
      , P.ALTERADO_EM
      
      , E.LOGRADOURO
      , E.NUMERO
      , E.COMPLEMENTO
      , E.BAIRRO
      , E.UF_SIGLA
      , E.CEP
      , E.MUNICIPIO_IBGE_ID
      , E.DDD
      , E.FONE1
      , E.FONE2
      , E.FONE3
      , E.CONTATO
      , E.REFERENCIA
      
      , LOJA.SELECIONADO
      
    FROM AMBIENTE_SIS AMBI

    JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID = 1 -- FEATURE LOJA
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN
      
    JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID
      AND LOG_EN.LOJA_ID_ENVOLVIDO = AMBI.LOJA_ID  
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO IS NULL
      AND LOG_EN.ID_ENVOLVIDO IS NULL

    JOIN LOJA ON
      AMBI.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN LOJA_EH_PESSOA LEP ON
      LEP.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN PESSOA P ON
      LEP.LOJA_ID = P.LOJA_ID 
      AND LEP.TERMINAL_ID = P.TERMINAL_ID 
      AND LEP.PESSOA_ID = P.PESSOA_ID 

    LEFT JOIN ENDERECO E ON
      P.LOJA_ID = E.LOJA_ID
      AND P.TERMINAL_ID = E.TERMINAL_ID
      AND P.PESSOA_ID = E.PESSOA_ID
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

      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP

      , :MUNICIPIO_IBGE_ID

      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3

      , :CONTATO
      , :REFERENCIA
      , :SELECIONADO
      ;
    SUSPEND;
  END
  
  PROCEDURE TEVE_TERMINAL
  (
    TERMINAL_ID_ALVO ID_SHORT_DOM
    , LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    TERMINAL_ID ID_SHORT_DOM
    , APELIDO NOME_REDU_DOM
    , NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
    , NF_SERIE SMALLINT
    , LETRA_DO_DRIVE CHAR(1)
    , GAVETA_TEM BOOLEAN
    , BALANCA_MODO_ID ID_SHORT_DOM
    , BALANCA_ID ID_SHORT_DOM
    , BARRAS_COD_INI SMALLINT
    , BARRAS_COD_TAM SMALLINT
    , CUPOM_NLINS_FINAL SMALLINT
    , SEMPRE_OFFLINE BOOLEAN
  )
  AS
  BEGIN
    SELECT   
      T.TERMINAL_ID
      , T.APELIDO
      , T.NOME_NA_REDE
      , T.IP
      , T.NF_SERIE
      , T.LETRA_DO_DRIVE
      , T.GAVETA_TEM
      , T.BALANCA_MODO_ID
      , T.BALANCA_ID
      , T.BARRAS_COD_INI
      , T.BARRAS_COD_TAM
      , T.CUPOM_NLINS_FINAL
      , T.SEMPRE_OFFLINE
      
    FROM AMBIENTE_SIS AMBI

    JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID = 2 -- FEATURE TERMINAL
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN
      
    JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO = :TERMINAL_ID_ALVO

    JOIN TERMINAL t ON
      T.TERMINAL_ID = :TERMINAL_ID_ALVO
    INTO
      :TERMINAL_ID
      , :APELIDO
      , :NOME_NA_REDE
      , :IP
      , :NF_SERIE
      , :LETRA_DO_DRIVE
      , :GAVETA_TEM
      , :BALANCA_MODO_ID
      , :BALANCA_ID
      , :BARRAS_COD_INI
      , :BARRAS_COD_TAM
      , :CUPOM_NLINS_FINAL
      , :SEMPRE_OFFLINE
      ;
    SUSPEND;
  END
  
  PROCEDURE TEVE_PAGAMENTO_FORMA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID          ID_SHORT_DOM
    , PAGAMENTO_FORMA_TIPO_ID     ID_CHAR_DOM
    , DESCR                       NOME_INTERM_DOM
    , DESCR_RED                   CHAR(8)
    , ATIVO                       BOOLEAN
    , PARA_VENDA                  BOOLEAN
    , DE_SISTEMA                  BOOLEAN
    , PROMOCAO_PERMITE            BOOLEAN
    , COMISSAO_PERMITE            BOOLEAN
    , TAXA_ADM_PERC               PERC_DOM
    , VALOR_MINIMO                PRECO_DOM
    , COMISSAO_ABATER_PERC        PERC_DOM
    , REEMBOLSO_DIAS              SMALLINT
    , TEF_USA                     BOOLEAN
    , AUTORIZACAO_EXIGE           BOOLEAN
    , PESSOA_EXIGE                BOOLEAN
    , A_VISTA                     BOOLEAN
  )
  AS
  BEGIN
    FOR SELECT DISTINCT  
      P.PAGAMENTO_FORMA_ID
      , P.PAGAMENTO_FORMA_TIPO_ID
      , P.DESCR
      , P.DESCR_RED
      , P.ATIVO
      , P.PARA_VENDA
      , P.DE_SISTEMA
      , P.PROMOCAO_PERMITE
      , P.COMISSAO_PERMITE
      , P.TAXA_ADM_PERC
      , P.VALOR_MINIMO
      , P.COMISSAO_ABATER_PERC
      , P.REEMBOLSO_DIAS
      , P.TEF_USA
      , P.AUTORIZACAO_EXIGE
      , P.PESSOA_EXIGE
      , P.A_VISTA
        
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
        AMBI.LOJA_ID = LOG.LOJA_ID
        AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
        AND FEATURE_SIS_ID = 11 -- FEATURE PAGAMENTO_FORMA
        AND LOG_ID >= :LOG_ID_INI
        AND LOG_ID <= :LOG_ID_FIN
        
      JOIN LOG_ENVOLVE_ID LOG_EN ON
        LOG_EN.LOJA_ID = LOG.LOJA_ID
        AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
        AND LOG_EN.LOG_ID = LOG.LOG_ID

      JOIN PAGAMENTO_FORMA P ON
        P.PAGAMENTO_FORMA_ID = LOG_EN.ID_ENVOLVIDO
    INTO
      :PAGAMENTO_FORMA_ID
      , :PAGAMENTO_FORMA_TIPO_ID
      , :DESCR
      , :DESCR_RED
      , :ATIVO
      , :PARA_VENDA
      , :DE_SISTEMA
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
      DO
    SUSPEND;
  END

  PROCEDURE TEVE_FUNCIONARIO_USUARIO
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , NOME NOME_DOM 
    , NOME_FANTASIA NOME_DOM
    , APELIDO NOME_REDU_DOM
    , GENERO_ID CHAR 
    , ESTADO_CIVIL_ID CHAR 
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)
    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO ATIVO_DOM
    , CRIADO_EM TIMESTAMP
    , ALTERADO_EM TIMESTAMP
    , ORDEM SMALLINT
    , LOGRADOURO VARCHAR(70)
    , NUMERO NOME_DOM
    , COMPLEMENTO NOME_DOM
    , BAIRRO NOME_DOM
    , UF_SIGLA CHAR
    , CEP CHAR(8)
    , MUNICIPIO_IBGE_ID CHAR
    , DDD CHAR(2)
    , FONE1 NOME_CURTO_DOM
    , FONE2 NOME_CURTO_DOM
    , FONE3 NOME_CURTO_DOM
    , CONTATO NOME_DOM
    , REFERENCIA OBS1_DOM
    , NOME_DE_USUARIO NOME_REDU_DOM
    , SENHA SENHA_DOM 
    , CRY_VER ID_SHORT_DOM
    , DE_SISTEMA BOOLEAN
  )
  AS
  BEGIN
    FOR
      SELECT
        DISTINCT
        P.LOJA_ID
        , P.TERMINAL_ID
        , P.PESSOA_ID
        , P.NOME
        , P.NOME_FANTASIA
        , P.APELIDO
        , P.GENERO_ID
        , P.ESTADO_CIVIL_ID
        , P.C
        , P.I
        , P.M
        , P.M_UF
        , P.EMAIL
        , P.DT_NASC
        , P.ATIVO
        , P.CRIADO_EM
        , P.ALTERADO_EM
        , E.ORDEM
        , E.LOGRADOURO
        , E.NUMERO
        , E.COMPLEMENTO
        , E.BAIRRO
        , E.UF_SIGLA
        , E.CEP
        , E.MUNICIPIO_IBGE_ID
        , E.DDD
        , E.FONE1
        , E.FONE2
        , E.FONE3
        , E.CONTATO
        , E.REFERENCIA
        , U.NOME_DE_USUARIO
        , U.SENHA
        , U.CRY_VER
        , U.DE_SISTEMA
      
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID IN (3, 4, 5, 6) -- FEATURE FUNC, USU, USU PODE, USU SENHA
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN

      JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID

      JOIN PESSOA P ON
      LOG_EN.LOJA_ID_ENVOLVIDO = P.LOJA_ID
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO = P.TERMINAL_ID
      AND LOG_EN.ID_ENVOLVIDO = P.PESSOA_ID 

      LEFT JOIN ENDERECO E ON
      P.LOJA_ID = E.LOJA_ID
      AND P.TERMINAL_ID = E.TERMINAL_ID
      AND P.PESSOA_ID = E.PESSOA_ID

      LEFT JOIN USUARIO U ON
      P.LOJA_ID = U.LOJA_ID
      AND P.TERMINAL_ID = U.TERMINAL_ID
      AND P.PESSOA_ID  = U.PESSOA_ID 

      ORDER BY P.LOJA_ID, P.TERMINAL_ID, P.PESSOA_ID
    INTO
      :LOJA_ID
      , :TERMINAL_ID
      , :PESSOA_ID
      , :NOME
      , :NOME_FANTASIA
      , :APELIDO
      , :GENERO_ID
      , :ESTADO_CIVIL_ID
      , :C
      , :I
      , :M
      , :M_UF
      , :EMAIL
      , :DT_NASC
      , :ATIVO
      , :CRIADO_EM
      , :ALTERADO_EM
      , :ORDEM
      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP
      , :MUNICIPIO_IBGE_ID
      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3
      , :CONTATO
      , :REFERENCIA
      , :NOME_DE_USUARIO
      , :SENHA
      , :CRY_VER
      , :DE_SISTEMA
    DO
    SUSPEND;
  END  


  /*
SELECT * FROM USUARIO_PODE_OPCAO_SIS;

SHOW TABLE USUARIO_PODE_OPCAO_SIS;

  */
  
  PROCEDURE TEVE_USUARIO_PODE_OPCAO_SIS
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    , OPCAO_SIS_ID ID_DOM
  )
  AS
  BEGIN
    FOR SELECT DISTINCT
      UPODE.LOJA_ID
      , UPODE.TERMINAL_ID
      , UPODE.PESSOA_ID
      , UPODE.OPCAO_SIS_ID
      
    FROM AMBIENTE_SIS AMBI

    JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID = 5 -- FEATURE PAGAMENTO_FORMA
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN
      
    JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID

    JOIN USUARIO_PODE_OPCAO_SIS UPODE ON
      LOG_EN.LOJA_ID_ENVOLVIDO = UPODE.LOJA_ID
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO = UPODE.TERMINAL_ID
      AND LOG_EN.ID_ENVOLVIDO = UPODE.PESSOA_ID 

    ORDER BY
      UPODE.LOJA_ID
      , UPODE.TERMINAL_ID
      , UPODE.PESSOA_ID
      , UPODE.OPCAO_SIS_ID
    INTO
      :LOJA_ID
      , :TERMINAL_ID
      , :PESSOA_ID
      , :OPCAO_SIS_ID
      DO
    SUSPEND;
  END  
END^
SET TERM ;^