unit Sis.Config.Factory;

interface

uses Sis.Config.MachineId, Sis.DB.DBTypes, Sis.Config.SisConfig,
  Sis.Config.ConfigXMLI;

function MachineIdCreate: IMachineId;
function SisConfigCreate(pVersion: TDBVersion = 0;
  pDatabaseType: TDBMSType = dbmstUnknown): ISisConfig;
function ConfigXMLICreate(pSisConfig: ISisConfig): IConfigXMLI;

implementation

uses Sis.Config.MachineId_u, Sis.Win.VersionInfo, Sis.Win.Factory,
  Sis.DB.Factory, Sis.Config.SisConfig_u, Sis.Config.ConfigXMLI_u;

function MachineIdCreate: IMachineId;
begin
  result := TMachineId.Create;
end;

function SisConfigCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : ISisConfig;
var
  vLocalMachineId, vServerMachineId: IMachineId;
  vWinVersionInfo: IWinVersionInfo;
  vDBMSInfo: IDBMSInfo;
begin
  vLocalMachineId := MachineIdCreate;
  vServerMachineId := MachineIdCreate;
  vWinVersionInfo := WinVersionCreate;
  vDBMSInfo := DBMSInfoCreate(pVersion, pDatabaseType);

  result := TISisConfig.Create(vLocalMachineId, vServerMachineId,
    vWinVersionInfo, vDBMSInfo);
end;

function ConfigXMLICreate(pSisConfig: ISisConfig): IConfigXMLI;
begin
  result := TConfigXMLI.Create(pSisConfig);
end;

end.
