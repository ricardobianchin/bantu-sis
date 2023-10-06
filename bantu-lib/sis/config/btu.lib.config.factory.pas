unit btu.lib.config.factory;

interface

uses btu.lib.config.machineid, btu.lib.config, btu.lib.db.types;

function MachineIdCreate: IMachineId;
function SisConfigCreate(pVersion: TDBVersion = 0; pDatabaseType: TDBMSType = dbmstUnknown): ISisConfig;

implementation

uses btu.lib.config.machineid_u, btu.lib.config_u, btu.lib.win.factory, btu.lib.win.VersionInfo,
  btu.lib.db.factory;

function MachineIdCreate: IMachineId;
begin
  result := TMachineId.Create;
end;

function SisConfigCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType): ISisConfig;
var
  vLocalMachineId, vServerMachineId: IMachineId;
  vWinVersionInfo: IWinVersionInfo;
  vDBMSInfo: IDBMSInfo;
begin
  vLocalMachineId := MachineIdCreate;
  vServerMachineId := MachineIdCreate;
  vWinVersionInfo := WinVersionCreate;
  vDBMSInfo := DBMSInfoCreate(pVersion, pDatabaseType);

  result := TISisConfig.Create(vLocalMachineId, vServerMachineId, vWinVersionInfo, vDBMSInfo);
end;

end.
