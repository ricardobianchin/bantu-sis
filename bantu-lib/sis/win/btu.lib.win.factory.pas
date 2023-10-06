unit btu.lib.win.factory;

interface

uses btu.lib.win.VersionInfo, btu.sis.ui.io.output, btu.lib.win.execute, WinApi.Windows, btu.sis.ui.io.factory;

function WinVersionCreate: IWinVersionInfo;
function WinExecuteCreate(
      pExecuteFile, pParams, pStartIn: string;
      pExecuteAoCriar: boolean;
      pShowMode: integer = SW_SHOWNORMAL;
      pOutput: IOutput=nil
      ): IWinExecute;

implementation

uses btu.lib.win.VersionInfo_u, btu.sis.ui.io.output.mudo_u, btu.lib.win.execute_u;

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
