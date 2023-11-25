unit Sis.Win.Factory;

interface

uses sis.win.VersionInfo, sis.ui.io.output, sis.win.execute, WinApi.Windows, sis.ui.io.factory;

function WinVersionCreate: IWinVersionInfo;
function WinExecuteCreate(
      pExecuteFile, pParams, pStartIn: string;
      pExecuteAoCriar: boolean;
      pShowMode: integer = SW_SHOWNORMAL;
      pOutput: IOutput=nil
      ): IWinExecute;

implementation

uses Sis.Win.VersionInfo_u, Sis.UI.IO.Output.Mudo_u, Sis.Win.Execute_u;

function WinVersionCreate: IWinVersionInfo;
begin
  Result := TWinVersionInfo.Create;
end;

function WinExecuteCreate(
      pExecuteFile, pParams, pStartIn: string;
      pExecuteAoCriar: boolean;
      pShowMode: integer;
      pOutput: IOutput
      ): IWinExecute;
begin
  result := TWinExecute.Create(pExecuteFile, pParams, pStartIn, pExecuteAoCriar, pShowMode, pOutput);
end;

end.
