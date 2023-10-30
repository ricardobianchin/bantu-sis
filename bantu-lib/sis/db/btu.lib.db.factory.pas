unit btu.lib.db.factory;

interface

uses btu.lib.db.types, btu.lib.db.dbms, btu.lib.config, sis.ui.io.LogProcess,
  sis.ui.io.output, btu.lib.db.dbms.config;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;

function DBMSConfigCreate(pSisConfig: ISisConfig; pLogProcess: ILogProcess;
  pOutput: IOutput): IDBMSConfig;

function DBMSFirebirdCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pLogProcess: ILogProcess; pOutput: IOutput): IDBMS;

function DBConnectionCreate(pSisConfig: ISisConfig; pDBMS: IDBMS;
  pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput): IDBConnection;

function DBExecCreate(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
      pOutput: IOutput): IDBExec;

function DBQueryCreate(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
      pOutput: IOutput): IDBQuery;

implementation

uses btu.lib.db.dbms.info_u, btu.lib.db.dbms.firebird_u, btu.lib.db.connection.firedac_u,
  btu.lib.db.exec.firedac_u, btu.lib.db.query.firedac_u,
  btu.lib.db.dbms.config.firebird_u;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;
begin
  Result := TDBMSInfo.Create(pVersion, pDatabaseType)
end;

function DBMSConfigCreate(pSisConfig: ISisConfig; pLogProcess: ILogProcess;
  pOutput: IOutput): IDBMSConfig;
begin
  Result := nil;
  case pSisConfig.DBMSInfo.DatabaseType of
    dbmstUnknown: ;
    dbmstFirebird: Result := TDBMSConfigFirebird.Create(pSisConfig, pLogProcess, pOutput);
    dbmstMySQL: ;
    dbmstPostgreSQL: ;
    dbmstOracle: ;
    dbmstSQLServer: ;
    dbmstSQLite: ;
  end;
end;

function DBMSFirebirdCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pLogProcess: ILogProcess; pOutput: IOutput): IDBMS;
begin
  Result := TDBMSFirebird.Create(pSisConfig, pDBMSConfig, pLogProcess, pOutput);
end;

function DBConnectionCreate(pSisConfig: ISisConfig; pDBMS: IDBMS; pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput): IDBConnection;
begin
  case pSisConfig.DBMSInfo.DBFramework of
    dbfrFireDAC:
    begin
      Result := TDBConnectionFiredac.Create(pSisConfig.DBMSInfo, pDBMS.LocalDoDBToConnectionParams(pLocalDoDB), pLogProcess, pOutput);
    end;
  end;
end;

function DBExecCreate(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
      pOutput: IOutput): IDBExec;
begin
  Result := TDBExecFireDac.Create(pDBConnection, pSql, pLogProcess, pOutput);
end;

function DBQueryCreate(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
      pOutput: IOutput): IDBQuery;
begin
  Result := TDBQueryFireDac.Create(pDBConnection, pSql, pLogProcess, pOutput);
end;


end.
