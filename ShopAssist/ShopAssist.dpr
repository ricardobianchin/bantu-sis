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
  EnvParaTerm_u_PegarFaixa in 'EnvParaTerm\EnvParaTerm_u_PegarFaixa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
  Exec_u.Execute;
end.
