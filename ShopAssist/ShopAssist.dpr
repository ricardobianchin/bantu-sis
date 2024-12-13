program ShopAssist;

uses
  Vcl.Forms,
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
  EnvParaTerm_u_ProdCusto in 'EnvParaTerm\EnvParaTerm_u_ProdCusto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
  Exec_u.Execute;
end.
