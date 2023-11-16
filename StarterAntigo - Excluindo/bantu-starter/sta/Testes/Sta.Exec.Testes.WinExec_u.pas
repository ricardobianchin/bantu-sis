unit Sta.Exec.Testes.WinExec_u;

interface

procedure ExecuteWinExecTeste;

implementation

uses sis.win.factory, sis.win.execute, Sis.UI.IO.Output, Sis.UI.IO.Factory;

procedure ExecuteWinExecTeste;
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
  I: Integer;
  FOutput: IOutput;
begin
  exit;

  sStartIn := 'C:\Windows\system32';
  sExecFile := 'C:\Windows\system32\notepad.exe';
  sParam := '';
  FOutput := OutputMudoCreate;
  bExecuteAoCriar := True;

  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  WExec.EspereExecucao(FOutput);

end;

end.
