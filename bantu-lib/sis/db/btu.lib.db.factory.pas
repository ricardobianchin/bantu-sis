unit btu.lib.db.factory;

interface

uses btu.lib.db.types, btu.lib.db.dbms, btu.lib.config, sis.ui.io.log,
  sis.ui.io.output, btu.lib.db.dbms.config;

function DBMSInfoCreate(pVersion: TDBVersion; pDatabaseType: TDBMSType)
  : IDBMSInfo;

function DBMSConfigCreate(pSisConfig: ISisConfig; pLog: iLog;
  pOutput: IOutput): IDBMSConfig;

function DBMSFirebirdCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pLog: iLog; pOutput: IOutput): IDBMS;

function DBConnectionCreate(pSisConfig: ISisConfig; pDBMS: IDBMS;
  pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput): IDBConnection;

function DBExecCreate(pDBConnection: IDBConnection; pSql: string; pLog: ILog;
      pOutput: IOutput): IDBExec;

function DBQueryCreate(pDBConnection: IDBConnection; pSql: string; pLog: ILog;
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

function DBMSConfigCreate(pSisConfig: ISisConfig; pLog: iLog;
  pOutput: IOutput): IDBMSConfig;
begin
  Result := nil;
  case pSisConfig.DBMSInfo.DatabaseType of
    dbmstUnknown: ;
    dbmstFirebird: Result := TDBMSConfigFirebird.Create(pSisConfig, pLog, pOutput);
    dbmstMySQL: ;
    dbmstPostgreSQL: ;
    dbmstOracle: ;
    dbmstSQLServer: ;
    dbmstSQLite: ;
  end;
end;

function DBMSFirebirdCreate(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
  pLog: iLog; pOutput: IOutput): IDBMS;
begin
  Result := TDBMSFirebird.Create(pSisConfig, pDBMSConfig, pLog, pOutput);
end;

function DBConnectionCreate(pSisConfig: ISisConfig; pDBMS: IDBMS; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput): IDBConnection;
begin
  case pSisConfig.DBMSInfo.DBFramework of
    dbfrFireDAC:
    begin
      Result := TDBConnectionFiredac.Create(pSisConfig.DBMSInfo, pDBMS.LocalDoDBToConnectionParams(pLocalDoDB), pLog, pOutput);
    end;
  end;
end;

function DBExecCreate(pDBConnection: IDBConnection; pSql: string; pLog: ILog;
      pOutput: IOutput): IDBExec;
begin
  Result := TDBExecFireDac.Create(pDBConnection, pSql, pLog, pOutput);
end;

function DBQueryCreate(pDBConnection: IDBConnection; pSql: string; pLog: ILog;
      pOutput: IOutput): IDBQuery;
begin
  Result := TDBQueryFireDac.Create(pDBConnection, pSql, pLog, pOutput);
end;


end.
