unit Sis.Config.Factory;

interface

uses Sis.Config.MachineId, Sis.DB.DBTypes, Sis.Config.SisConfig,
  Sis.Config.SisConfig.XMLI, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

function MachineIdCreate: IMachineId;
function SisConfigCreate(pVersion: TDBVersion = 0;
  pDatabaseType: TDBMSType = dbmstUnknown): ISisConfig;
function SisConfigXMLICreate(pSisConfig: ISisConfig;
  pProcessLog: IProcessLog = nil; pOutput: IOutput = nil): ISisConfigXMLI;

implementation

uses Sis.Config.MachineId_u, Sis.Win.VersionInfo, Sis.Win.Factory,
  Sis.DB.Factory, Sis.Config.SisConfig_u, Sis.Config.SisConfig.XMLI_u;

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

  result := TSisConfig.Create(vLocalMachineId, vServerMachineId,
    vWinVersionInfo, vDBMSInfo);
end;

function SisConfigXMLICreate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): ISisConfigXMLI;
begin
  result := TSisConfigXMLI.Create(pSisConfig, pProcessLog, pOutput);
end;

end.
