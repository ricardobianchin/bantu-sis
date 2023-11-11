unit btu.lib.db.updater.factory;

interface

uses
  btu.lib.db.updater.firebird_u, btu.lib.config, sis.ui.io.LogProcess,
  sis.ui.io.output, btu.lib.db.types, btu.lib.db.updater,
  btu.lib.db.dbms, btu.lib.db.updater.comando, btu.lib.db.updater.campo,
  btu.lib.db.updater.campo.list, btu.lib.db.updater.comando.list,
  btu.lib.db.updater.operations;

function DBUpdaterFirebirdCreate(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput): IDBUpdater;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLogProcess: ILogProcess; pOutput: IOutput)
  : IComando;

function sLinToCampoCreate(pStr: string): ICampo;
function CampoListCreate: ICampoList;
function ComandoListCreate: IComandoList;

function GetDBUpdaterOperations(pDBConnection: IDBConnection; pLogProcess: ILogProcess;
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
  pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput): IDBUpdater;
begin
  pLogProcess.Exibir('DBUpdaterFirebirdCreate, inicio, vai TDBUpdaterFirebird.Create');
  result := TDBUpdaterFirebird.Create(pLocalDoDB, pDBMS, pSisConfig,
    pLogProcess, pOutput);
  pLogProcess.Exibir('DBUpdaterFirebirdCreate, fim');
end;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLogProcess: ILogProcess; pOutput: IOutput): IComando;
begin
  if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_TABLE then
    result := TComandoFBCreateTable.Create(pDBConnection, pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PROCEDURE then
    result := TComandoFBCreateOrAlterProcedure.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PACKAGE then
    result := TComandoFBCreateOrAlterPackage.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS then
    result := TComandoFBCreateDomains.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_ENSURE_RECORDS then
    result := TComandoFBEnsureRecords.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_SEQUENCE then
    result := TComandoFBCreateSequence.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_FOREIGN_KEY then
    result := TComandoFBCreateForeignKey.Create(pDBConnection,
      pUpdaterOperations, pLogProcess, pOutput)

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

function GetDBUpdaterOperations(pDBConnection: IDBConnection; pLogProcess: ILogProcess;
  pOutput: IOutput): IDBUpdaterOperations;
begin
  Result := TDBUpdaterOperationsFB.Create(pDBConnection, pLogProcess, pOutput);
end;

end.
