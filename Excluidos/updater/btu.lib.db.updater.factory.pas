unit btu.lib.db.updater.factory;

interface

uses
  btu.lib.db.updater.firebird_u, btu.lib.config, sis.ui.io.ProcessLog,
  sis.ui.io.output, btu.lib.db.types, btu.lib.db.updater,
  btu.lib.db.dbms, btu.lib.db.updater.comando, btu.lib.db.updater.campo,
  btu.lib.db.updater.campo.list, btu.lib.db.updater.comando.list,
  btu.lib.db.updater.operations;

function DBUpdaterFirebirdCreate(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput): IDBUpdater;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput)
  : IComando;

function sLinToCampoCreate(pStr: string): ICampo;
function CampoListCreate: ICampoList;
function ComandoListCreate: IComandoList;

function GetDBUpdaterOperations(pDBConnection: IDBConnection; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBUpdaterOperations;

implementation

uses
  btu.lib.db.updater_u, btu.lib.db.updater.comando.fb.createtable_u,
  btu.lib.db.updater.constants_u, btu.lib.db.updater.campo_u,
  btu.lib.db.updater.campo.list_u, btu.lib.db.updater.comando.list_u,
  btu.lib.db.updater.comando.fb.createoralterprocedure_u,
  btu.lib.db.updater.operations.fb_u,
  btu.lib.db.updater.comando.fb.createdomains_u,
  btu.lib.db.updater.comando.fb.createoralterpackage_u, sis.types.strings,
  btu.lib.db.updater.comando.fb.ensurerecords_u,
  btu.lib.db.updater.comando.fb.createsequence_u,
  btu.lib.db.updater.comando.fb.createforeignkey_u;

function DBUpdaterFirebirdCreate(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput): IDBUpdater;
begin
  pProcessLog.Exibir('DBUpdaterFirebirdCreate, inicio, vai TDBUpdaterFirebird.Create');
  result := TDBUpdaterFirebird.Create(pLocalDoDB, pDBMS, pSisConfig,
    pProcessLog, pOutput);
  pProcessLog.Exibir('DBUpdaterFirebirdCreate, fim');
end;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog; pOutput: IOutput): IComando;
begin
  if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_TABLE then
    result := TComandoFBCreateTable.Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PROCEDURE then
    result := TComandoFBCreateOrAlterProcedure.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PACKAGE then
    result := TComandoFBCreateOrAlterPackage.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS then
    result := TComandoFBCreateDomains.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_ENSURE_RECORDS then
    result := TComandoFBEnsureRecords.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_SEQUENCE then
    result := TComandoFBCreateSequence.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_FOREIGN_KEY then
    result := TComandoFBCreateForeignKey.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

      ;
end;

function sLinToCampoCreate(pStr: string): ICampo;
begin
  Result := nil;

  pStr := StrSemCharRepetido(pStr);
  if pStr='' then
    exit;

  Result := TCampo.Create(pStr)
end;

function CampoListCreate: ICampoList;
begin
  Result := TCampoList.Create;
end;

function ComandoListCreate: IComandoList;
begin
  Result := TComandoList.Create;
end;

function GetDBUpdaterOperations(pDBConnection: IDBConnection; pProcessLog: IProcessLog;
  pOutput: IOutput): IDBUpdaterOperations;
begin
  Result := TDBUpdaterOperationsFB.Create(pDBConnection, pProcessLog, pOutput);
end;

end.
