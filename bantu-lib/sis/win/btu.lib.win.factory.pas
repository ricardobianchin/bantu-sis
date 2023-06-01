unit btu.lib.win.factory;

interface

uses btu.lib.win.VersionInfo;

function WinVersionCreate: IWinVersionInfo;

implementation

uses btu.lib.win.VersionInfo_u;

function WinVersionCreate: IWinVersionInfo;
begin
  result := TWinVersionInfo.Create;
end;

end.
