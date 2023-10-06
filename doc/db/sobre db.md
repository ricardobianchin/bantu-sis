exemplos de stored procedures

C:\Pr\ter\i9\Src\Foco1\Foco\DadosAtualiz\UFocoAtualiz_0299.pas

---
C:\Pr\ter\i9\Src\Foco1\Sys\SysDBI\UFirebirdManut.pas

C:\Pr\ter\i9\Src\Foco1\Sys\SysDBI\DBTypes_i.pas

---
o que pode ser feito para versao
versao atual
DBUPDATE_VERSAO_GET
inserir versao
DBUPDATE_HIST_INS


criar espaços entre comandos

  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);

ajustar a sp
em cada volta do loop vai testar se ja foi prepared




---------------
-- exemplo de como usar o for select
---------------
CREATE PROCEDURE CALCULAR_TOTAL (CODIGO_VENDA INTEGER)
RETURNS (TOTAL NUMERIC(18,2))
AS
BEGIN
  TOTAL = 0;
  FOR SELECT SUB_TOTAL FROM VENDA_ITENS WHERE CODIGO_VENDA = :CODIGO_VENDA
  AS CURSOR C DO
  BEGIN
    TOTAL = TOTAL + TRUNC(C.SUB_TOTAL, 2);
  END
  SUSPEND;
END

----------------
