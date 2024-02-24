unit Sis.DB.Updater.Factory;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output,
  Sis.Config.SisConfig, Sis.DB.Updater, Sis.DB.Updater.Operations,
  Sis.DB.Updater.Comando, Sis.DB.Updater.Campo, Sis.DB.Updater.Campo.List,
  Sis.DB.Updater.Comando.List, Sis.Loja, Sis.Usuario;

function DBUpdaterFirebirdCreate(pDBConnectionParams: TDBConnectionParams;
  pPastaProduto: string; pDBMS: IDBMS; pSisConfig: ISisConfig;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario): IDBUpdater;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput): IComando;

function sLinToCampoCreate(pStr: string): ICampo;
function CampoListCreate: ICampoList;
function ComandoListCreate: IComandoList;

function DBUpdaterOperationsCreate(pDBConnection: IDBConnection;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBUpdaterOperations;

implementation

uses Sis.DB.Updater.Firebird_u, Sis.DB.Updater.Constants_u,System.StrUtils,
  Sis.DB.Updater.Comando.FB.CreateDomains_u,
  Sis.DB.Updater.Comando.FB.CreateForeignKey_u,
  Sis.DB.Updater.Comando.FB.CreateOrAlterPackage_u,
  Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.DB.Updater.Comando.FB.CreateSequence_u,
  Sis.DB.Updater.Comando.FB.CreateTable_u,
  Sis.DB.Updater.Comando.FB.EnsureRecords_u, Sis.Types.strings_u,
  Sis.DB.Updater.Campo_u, Sis.DB.Updater.Campo.List_u,
  Sis.DB.Updater.Comando.List_u, Sis.DB.Updater.Operations.FB_u;

function DBUpdaterFirebirdCreate(pDBConnectionParams: TDBConnectionParams;
  pPastaProduto: string; pDBMS: IDBMS; pSisConfig: ISisConfig;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario): IDBUpdater;
begin
  result := TDBUpdaterFirebird.Create( pDBConnectionParams, pPastaProduto,
    pDBMS, pSisConfig, pProcessLog, pOutput, pLoja, pUsuarioGerente);
end;

function TipoToComando(pTipoStr: string; pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput): IComando;
begin
  if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_TABLE then
    result := TComandoFBCreateTable.Create(pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PROCEDURE then
    result := TComandoFBCreateOrAlterProcedure.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_OR_ALTER_PACKAGE then
    result := TComandoFBCreateOrAlterPackage.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS then
    result := TComandoFBCreateDomains.Create(pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_ENSURE_RECORDS then
    result := TComandoFBEnsureRecords.Create(pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_SEQUENCE then
    result := TComandoFBCreateSequence.Create(pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_TIPO_COMANDO_CREATE_FOREIGN_KEY then
    result := TComandoFBCreateForeignKey.Create(pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

      ;
end;

function sLinToCampoCreate(pStr: string): ICampo;
begin
  result := nil;

  pStr := StrSemCharRepetido(pStr);
  if pStr = '' then
    exit;

  result := TCampo.Create(pStr)
end;

function CampoListCreate: ICampoList;
begin
  result := TCampoList.Create;
end;

function ComandoListCreate: IComandoList;
begin
  result := TComandoList.Create;
end;

function DBUpdaterOperationsCreate(pDBConnection: IDBConnection;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBUpdaterOperations;
begin
  result := TDBUpdaterOperationsFB.Create(pDBConnection, pProcessLog, pOutput);
end;

end.
