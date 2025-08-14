program ShopAssist;

uses
  Vcl.Forms,
  Winapi.Windows,
  Exec_u in 'Exec\Exec_u.pas',
  Configs_u in 'Sis\Configs_u.pas',
  DBServDM_u in 'DB\DBServDM_u.pas' {DBServDM: TDataModule},
  DBTermDM_u in 'DB\DBTermDM_u.pas' {DBTermDM: TDataModule},
  Terminais_u in 'DB\Terminais_u.pas',
  Sis_u in 'Sis\Sis_u.pas',
  DB_u in 'DB\DB_u.pas',
  EnvParaTerm_u in 'EnvParaTerm\EnvParaTerm_u.pas',
  EnvParaTerm_u_AtualizeMachine in 'EnvParaTerm\EnvParaTerm_u_AtualizeMachine.pas',
  ExecScript_u in 'DB\ExecScript_u.pas',
  EnvParaTerm_u_PegarFaixa in 'EnvParaTerm\EnvParaTerm_u_PegarFaixa.pas',
  EnvParaTerm_u_Loja in 'EnvParaTerm\EnvParaTerm_u_Loja.pas',
  EnvParaTerm_u_Terminal in 'EnvParaTerm\EnvParaTerm_u_Terminal.pas',
  EnvParaTerm_u_PagamentoForma in 'EnvParaTerm\EnvParaTerm_u_PagamentoForma.pas',
  EnvParaTerm_u_FuncionarioUsuario in 'EnvParaTerm\EnvParaTerm_u_FuncionarioUsuario.pas',
  EnvParaTerm_u_UsuarioPodeOpcaoSis in 'EnvParaTerm\EnvParaTerm_u_UsuarioPodeOpcaoSis.pas',
  EnvParaTerm_u_Prod in 'EnvParaTerm\EnvParaTerm_u_Prod.pas',
  EnvParaTerm_u_ProdCusto in 'EnvParaTerm\EnvParaTerm_u_ProdCusto.pas',
  EnvParaTerm_u_ProdPreco in 'EnvParaTerm\EnvParaTerm_u_ProdPreco.pas',
  EnvParaTerm_u_DespesaTipo in 'EnvParaTerm\EnvParaTerm_u_DespesaTipo.pas',
  TrazerDoTerm_u in 'TrazerDoTerm\TrazerDoTerm_u.pas',
  TrazerDoTerm_u_PegarFaixa in 'TrazerDoTerm\TrazerDoTerm_u_PegarFaixa.pas',
  TrazerDoTerm_u_TrazCxSess in 'TrazerDoTerm\TrazerDoTerm_u_TrazCxSess.pas',
  TrazerDoTerm_u_TrazCxOper in 'TrazerDoTerm\TrazerDoTerm_u_TrazCxOper.pas',
  TrazerDoTerm_u_TrazCxOperDesp in 'TrazerDoTerm\TrazerDoTerm_u_TrazCxOperDesp.pas',
  TrazerDoTerm_u_TrazCxOperValor in 'TrazerDoTerm\TrazerDoTerm_u_TrazCxOperValor.pas',
  TrazerDoTerm_u_TrazLogMovs in 'TrazerDoTerm\TrazerDoTerm_u_TrazLogMovs.pas',
  TrazerDoTerm_u_TrazEstMovVenda in 'TrazerDoTerm\TrazerDoTerm_u_TrazEstMovVenda.pas',
  TrazerDoTerm_u_TrazEstMovItemVendaItem in 'TrazerDoTerm\TrazerDoTerm_u_TrazEstMovItemVendaItem.pas',
  TrazerDoTerm_u_TrazVendaPag in 'TrazerDoTerm\TrazerDoTerm_u_TrazVendaPag.pas',
  EstSaldo_u in 'EstSaldo\EstSaldo_u.pas',
  EstSaldo_u_dbi in 'EstSaldo\EstSaldo_u_dbi.pas',
  EstSaldo_u_HistReconstrua in 'EstSaldo\EstSaldo_u_HistReconstrua.pas',
  EstSaldo_u_ProdSaldoRecord in 'EstSaldo\EstSaldo_u_ProdSaldoRecord.pas',
  EstSaldo_u_ProdSaldoArrayUtils in 'EstSaldo\EstSaldo_u_ProdSaldoArrayUtils.pas',
  EstSaldo_u_ProdSaldoArrayType in 'EstSaldo\EstSaldo_u_ProdSaldoArrayType.pas',
  Loja_dbi_u in 'Loja\Loja_dbi_u.pas',
  Sis.Log in 'Sis\Sis.Log.pas',
  Sis.Log_u in 'Sis\Sis.Log_u.pas',
  Log_u in 'Sis\Log_u.pas';

{$R *.res}

var
  hMutex: THandle;
begin
  hMutex := CreateMutex(nil, True, 'ShopAssistMutex');
  try
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      // Outra instância está em execução
      Exit;
    end;
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Run;
    Exec_u.Execute;
  finally
    // Liberar o mutex ao finalizar
    CloseHandle(hMutex);
  end;
end.





