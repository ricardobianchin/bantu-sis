SET TERM ^;
create or alter procedure lo_get
RETURNS 
(
  LOJA_ID ID_SHORT_DOM
)
as
begin
    FOR
      WITH L AS
      (
        SELECT 
          LOJA_ID, 
          APELIDO, 
          ATIVO
        FROM 
          LOJA
--        WHERE (:P_LOJA_ID = 0) OR (:P_LOJA_ID = LOJA_ID)
        --ORDER BY LOJA_ID
      )
      
      , P AS
      (
        SELECT
          LOJA_ID,
          TERMINAL_ID,
          PESSOA_ID, 
          NOME, 
          NOME_FANTASIA, 
          GENERO_ID, 
          ESTADO_CIVIL_ID, 
          C, 
          I, 
          M, 
          M_UF, 
          EMAIL, 
          DT_NASC, 
          CRIADO_EM PESS_CRIADO_EM,
          ALTERADO_EM PESS_ALTERADO_EM, 
        FROM PESSOA
      )
      
      , LEP AS
      (
        SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID
        FROM LOJA_EH_PESSOA
      )
    select L.LOJA_ID
    FROM L
    LEFT JOIN LEP ON
    LEP.LOJA_ID = LO.LOJA_ID
    INTO 
      :LOJA_ID
    DO 
      SUSPEND; 
end^
SET TERM ;^
/*
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Pess\Teste\Teste Ender\cria.sql";

select * from lo_get;

DELETE FROM LOJA_EH_PESSOA;
COMMIT;

INSERT INTO LOJA_EH_PESSOA (LOJA_ID,TERMINAL_ID,PESSOA_ID) VALUES (1,0,5);
COMMIT;


*/
