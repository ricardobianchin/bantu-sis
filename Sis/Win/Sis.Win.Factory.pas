unit Sis.Win.Factory;

interface

uses Sis.Win.VersionInfo, Sis.ui.io.output, Sis.Win.execute, WinApi.Windows,
  Sis.ui.io.Factory;

function WinVersionCreate: IWinVersionInfo;
function WinExecuteCreate(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer = SW_SHOWMINNOACTIVE;
  pOutput: IOutput = nil): IWinExecute;
procedure WinExecuteComando(pExecuteFile, pParams: string; pStartIn: string = '';
  pOutput: IOutput = nil);

implementation

uses Sis.Win.VersionInfo_u, Sis.ui.io.output.Mudo_u, Sis.Win.Execute_u,
  Sis.ui.io.Files.Factory;

function WinVersionCreate: IWinVersionInfo;
begin
  Result := TWinVersionInfo.Create;
end;

function WinExecuteCreate(pExecuteFile, pParams, pStartIn: string;
  pExecuteAoCriar: boolean; pShowMode: integer; pOutput: IOutput): IWinExecute;
begin
  Result := TWinExecute.Create(pExecuteFile, pParams, pStartIn, pExecuteAoCriar,
    pShowMode, pOutput);
end;

procedure WinExecuteComando(pExecuteFile, pParams: string; pStartIn: string;
  pOutput: IOutput);
var
  we: IWinExecute;
begin
  we := WinExecuteCreate(pExecuteFile, pParams, pStartIn, true);
  we.EspereExecucao(pOutput);
end;

end.
