SET TERM ^;
CREATE OR ALTER PACKAGE PERFIL_DE_USO_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS 
  (
      PERFIL_DE_USO_ID ID_SHORT_DOM,
      NOME NOME_REDU_NOTN_DOM,
      DE_SISTEMA BOOLEAN
  );

END^

RECREATE PACKAGE BODY PERFIL_DE_USO_MANUT_PA
AS
BEGIN

PROCEDURE PERFIL_DE_USO_USUARIOS_GET 
(
  BUSCA_APELIDO NOME_REDU_DOM
)
RETURNS 
(
  LOJA_ID ID_SHORT_DOM,
  TERMINAL_ID ID_SHORT_DOM,
  PESSOA_ID ID_DOM,
  PERFIL_DE_USO_ID ID_SHORT_DOM,
  PERFIL_NOME NOME_REDU_DOM,
  DE_SISTEMA BOOLEAN
  APELIDOS VARCHAR(1024)
)
AS
BEGIN
  FOR
    WITH PESS AS (
      SELECT 
          P.LOJA_ID,
          P.TERMINAL_ID,
          P.PESSOA_ID, MUDAR PARA PESSOA ID
          P.APELIDO
        FROM 
          PESSOA P
        WHERE 
          (:BUSCA_APELIDO IS NULL OR :BUSCA_APELIDO = '') OR (P.APELIDO LIKE '%' || :BUSCA_APELIDO || '%')
    ),
    PERFIS AS (
        SELECT 
          P.PERFIL_DE_USO_ID,
          P.NOME AS PERFIL_NOME,
          P.DE_SISTEMA
        FROM 
          PERFIL_DE_USO P
    ),
    USU_TEM_PERF AS (
        SELECT 
          UT.LOJA_ID,
          UT.TERMINAL_ID,
          UT.PESSOA_ID,
          UT.PERFIL_DE_USO_ID
        FROM 
          USUARIO_TEM_PERFIL_DE_USO UT
    )
    SELECT 
      PESS.LOJA_ID,
      PESS.TERMINAL_ID,
      PESS.PESSOA_ID,
      UP.PERFIL_DE_USO_ID,
      P.PERFIL_NOME,
      P.DE_SISTEMA,
      LIST(DISTINCT U.NOME_DE_USUARIO, '; ') AS USUARIO_NOMES
    FROM 
        USUARIO_PERFIS UP
        JOIN USUARIOS U ON UP.LOJA_ID = U.LOJA_ID AND UP.TERMINAL_ID = U.TERMINAL_ID AND UP.PESSOA_ID = U.PESSOA_ID
        JOIN PERFIS P ON UP.PERFIL_DE_USO_ID = P.PERFIL_DE_USO_ID
    GROUP BY 
        UP.LOJA_ID, UP.TERMINAL_ID, UP.PESSOA_ID, UP.PERFIL_DE_USO_ID, P.PERFIL_NOME
    INTO 
        :LOJA_ID, :TERMINAL_ID, :PESSOA_ID, :PERFIL_DE_USO_ID, :PERFIL_NOME, :USUARIO_NOMES
  DO
  BEGIN
      IF (CHAR_LENGTH(:USUARIO_NOMES) > 1024) THEN
          :USUARIO_NOMES = SUBSTRING(:USUARIO_NOMES FROM 1 FOR 1024);
      SUSPEND;
  END
END^
SET TERM ;^
