unit EnvParaTerm_u;

interface

uses DBTermDM_u;

procedure EnvParaTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses Sis_u, EnvParaTerm_u_AtualizeMachine, EnvParaTerm_u_PegarFaixa, DBServDM_u,
  System.Math, ExecScript_u, System.SysUtils, EnvParaTerm_u_Loja,
  EnvParaTerm_u_Terminal, EnvParaTerm_u_PagamentoForma,
  EnvParaTerm_u_FuncionarioUsuario, EnvParaTerm_u_UsuarioPodeOpcaoSis,
  EnvParaTerm_u_Prod, EnvParaTerm_u_ProdCusto;

procedure EnvParaTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  FLogIdIni, FLogIdFin: Int64;
  iAtualIni, iAtualFIn: Int64;
  oExecScript: TExecScript;
  sComando: string;
begin
  if pPrecisaTerminar then
    exit;

  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  // machine
  AtualizeMachine(pTermDM, pPrecisaTerminar);
  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  DBServDM.Connection.Open;
  pTermDM.Connection.Open;
  oExecScript := TExecScript.Create(pTermDM.Connection);
  try
    PegarFaixa(pTermDM, FLogIdIni, FLogIdFin);

    if FLogIdIni = FLogIdFin then
      exit;

    iAtualIni := FLogIdIni;

    while iAtualIni <= FLogIdFin do
    begin
      iAtualFIn := Min(FLogIdFin, iAtualIni + TERMINAL_SYNC_PASSO - 1);

      EnvLoja(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvTerminal(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvPagamentoForma(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvFuncionarioUsuario(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvUsuarioPodeOpcaoSis(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvProd(pTermDM, oExecScript, FLogIdIni, FLogIdFin);
      EnvProdCusto(pTermDM, oExecScript, FLogIdIni, FLogIdFin);

      sComando := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.ATUALIZAR(' +
        FLogIdFin.ToString + ');'
        ;

      oExecScript.PegueComando(sComando);

      oExecScript.Execute;

      Inc(iAtualIni, TERMINAL_SYNC_PASSO);
    end;
  finally
    FreeAndNil(oExecScript);
    DBServDM.Connection.Close;
    pTermDM.Connection.Close;
  end;

  pPrecisaTerminar := GetPrecisaTerminar;
end;

end.
