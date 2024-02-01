unit Sis.DB.Factory;

interface

uses Sis.DB.DBTypes, Sis.Config.SisConfig, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, Sis.DB.FDDataSetManager;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;

function DBMSConfigCreate(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBMSConfig;

function DBMSCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBMS;

function DBConnectionCreate(pNomeComponente: string; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pDBConnectionParams: TDBConnectionParams;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBConnection;

function DBExecCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBExec;

function DBQueryCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBQuery;

implementation

uses Sis.DB.DBMS.Info_u, Sis.DB.DBMS.DBMSConfig.Firebird_u,
  Sis.DB.DBMS.Firebird_u, Sis.DB.DBConnection.FireDAC_u,
  Sis.DB.DBExec.FireDAC_u, Sis.DB.DBQuery.FireDAC_u, Sis.UI.ImgDM,
  Sis.DB.FDDataSetManager_u;

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
  pDBMS: IDBMS; pDBConnectionParams: TDBConnectionParams;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBConnection;
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
begin
  Result := TDBExecFireDac.Create(pNomeComponente, pDBConnection, pSql,
    pProcessLog, pOutput);
end;

function DBQueryCreate(pNomeComponente: string; pDBConnection: IDBConnection;
  pSql: string; pProcessLog: IProcessLog; pOutput: IOutput): IDBQuery;
begin
  Result := TDBQueryFireDac.Create(pNomeComponente, pDBConnection, pSql,
    pProcessLog, pOutput);
end;

end.
