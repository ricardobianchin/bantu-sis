unit Sis.DB.Factory;

interface

uses Sis.DB.DBTypes, Sis.Config.SisConfig, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, Sis.DB.FDDataSetManager, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBGrids;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;

function DBMSConfigCreate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBMSConfig;

function DBMSCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBMS;

function DBConnectionCreate(pNomeComponente: string; pSisConfig: ISisConfig;
  pDBConnectionParams: TDBConnectionParams; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBConnection;

function DBExecCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBExec;

function DBQueryCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBQuery;

function DBExecScriptCreate(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBExecScript;

function FDDataSetManagerCreate(pFDMemTable: TFDMemTable; pDBGrid: TDBGrid)
  : IFDDataSetManager;

implementation

uses Sis.DB.DBMS.Info_u, Sis.DB.DBMS.DBMSConfig.Firebird_u,
  Sis.DB.DBMS.Firebird_u, Sis.DB.DBConnection.FireDAC_u, Sis.UI.ImgDM,
  Sis.DB.FDDataSetManager_u, Sis.UI.IO.Factory,
  Sis.UI.IO.Output.ProcessLog.Factory//

  , Sis.DB.DBQuery.FireDAC_u //
  , Sis.DB.DBExec.FireDAC_u //
  , Sis.DB.DBExecScript.FireDAC_u //
  ;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;
begin
  Result := TDBMSInfo.Create(pVersion, pDatabaseType)
end;

function DBMSConfigCreate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBMSConfig;
begin
  Result := nil;
  case pSisConfig.DBMSInfo.DatabaseType of
    dbmstUnknown:
      ;
    dbmstFirebird:
      Result := TDBMSConfigFirebird.Create(pSisConfig, pProcessLog, pOutput);
    dbmstMySQL:
      ;
    dbmstPostgreSQL:
      ;
    dbmstOracle:
      ;
    dbmstSQLServer:
      ;
    dbmstSQLite:
      ;
  end;
end;

function DBMSCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBMS;
begin
  Result := nil;
  case pSisConfig.DBMSInfo.DatabaseType of
    dbmstUnknown:
      ;
    dbmstFirebird:
      Result := TDBMSFirebird.Create(pSisConfig, pDBMSConfig,
        pProcessLog, pOutput);
    dbmstMySQL:
      ;
    dbmstPostgreSQL:
      ;
    dbmstOracle:
      ;
    dbmstSQLServer:
      ;
    dbmstSQLite:
      ;
  end;
  SisImgDataModule.PegueVendor(Result.VendorHome, Result.VendorLib);

end;

function DBConnectionCreate(pNomeComponente: string; pSisConfig: ISisConfig;
  pDBConnectionParams: TDBConnectionParams; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBConnection;
var
  oDBMSInfo: IDBMSInfo;
begin
  oDBMSInfo := pSisConfig.DBMSInfo;
  case pSisConfig.DBMSInfo.DBFramework of
    dbfrFireDAC:
      begin
        Result := TDBConnectionFiredac.Create(pNomeComponente, oDBMSInfo,
          pDBConnectionParams, pProcessLog, pOutput);
      end;
  end;
end;

function DBExecCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBExec;
var
  oProcessLog: IProcessLog;
  oOutput: IOutput;
begin
  if Assigned(pProcessLog) then
    oProcessLog := pProcessLog
  else
    oProcessLog := MudoProcessLogCreate;

  if Assigned(pOutput) then
    oOutput := pOutput
  else
    oOutput := MudoOutputCreate;

  Result := TDBExecFireDac.Create(pNomeComponente, pDBConnection, pSql,
    oProcessLog, oOutput);
end;

function DBQueryCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBQuery;
var
  oProcessLog: IProcessLog;
  oOutput: IOutput;
begin
  if Assigned(pProcessLog) then
    oProcessLog := pProcessLog
  else
    oProcessLog := MudoProcessLogCreate;

  if Assigned(pOutput) then
    oOutput := pOutput
  else
    oOutput := MudoOutputCreate;

  Result := TDBQueryFireDac.Create(pNomeComponente, pDBConnection, pSql,
    oProcessLog, oOutput);
end;

function DBExecScriptCreate(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBExecScript;
var
  oProcessLog: IProcessLog;
  oOutput: IOutput;
begin
  if Assigned(pProcessLog) then
    oProcessLog := pProcessLog
  else
    oProcessLog := MudoProcessLogCreate;

  if Assigned(pOutput) then
    oOutput := pOutput
  else
    oOutput := MudoOutputCreate;

  Result := TDBExecScriptFireDac.Create(pNomeComponente, pDBConnection,
    oProcessLog, oOutput);
end;

function FDDataSetManagerCreate(pFDMemTable: TFDMemTable; pDBGrid: TDBGrid)
  : IFDDataSetManager;
begin
  Result := TFDDataSetManager.Create(pFDMemTable, pDBGrid);
end;

end.
