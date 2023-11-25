unit Sis.Config.Factory;

interface

uses Sis.Config.MachineId, Sis.Config.SisConfig, btu.lib.db.types, btu.lib.config.xmli,
  btu.lib.db.dbms.config;

function MachineIdCreate: IMachineId;
function SisConfigCreate(pVersion: TDBVersion = 0; pDatabaseType: TDBMSType = dbmstUnknown): ISisConfig;
function ConfigXMLICreate(pSisConfig: ISisConfig): IConfigXMLI;

implementation

uses btu.lib.config.machineid_u, btu.lib.config_u, sis.win.factory, sis.win.VersionInfo,
  btu.lib.db.factory, btu.lib.config.xmli_u;

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

function ConfigXMLICreate(pSisConfig: ISisConfig): IConfigXMLI;
begin
  Result := TConfigXMLI.Create(pSisConfig);
end;

end.
