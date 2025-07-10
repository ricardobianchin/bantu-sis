unit Sis.DB.Updater.Factory;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output,
  Sis.Config.SisConfig, Sis.DB.Updater, Sis.DB.Updater.Operations,
  Sis.DB.Updater.Comando, Sis.DB.Updater.Campo, Sis.DB.Updater.Campo.List,
  Sis.DB.Updater.Comando.List, Sis.Loja, Sis.Usuario, Sis.Entities.Types,
  Sis.TerminalList;

function DBUpdaterFirebirdCreate(pTerminalId: TTerminalId;
  pDBConnectionParams: TDBConnectionParams; pPastaProduto: string; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput;
  pLoja: ISisLoja; pUsuarioAdmin: IUsuario; pVariaveis: string): IDBUpdater;

function TipoToComando(pTipoStr: string; pVersaoDB: integer;
  pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
  pProcessLog: IProcessLog; pOutput: IOutput): IComando;

function sLinToCampoCreate(pStr: string): ICampo;
function CampoListCreate: ICampoList;
function ComandoListCreate: IComandoList;

function DBUpdaterOperationsCreate(pDBConnection: IDBConnection;
  pProcessLog: IProcessLog; pOutput: IOutput): IDBUpdaterOperations;

implementation

uses Sis.DB.Updater.Firebird_u, Sis.DB.Updater.Constants_u, System.StrUtils,
  Sis.DB.Updater.Comando.FB.CreateDomains_u,
  Sis.DB.Updater.Comando.FB.CreateForeignKey_u,
  Sis.DB.Updater.Comando.FB.CreateUniqueKey_u,
  Sis.DB.Updater.Comando.FB.CreateOrAlterPackage_u,
  Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.DB.Updater.Comando.FB.CreateSequence_u,
  Sis.DB.Updater.Comando.FB.CreateTable_u,
  Sis.DB.Updater.Comando.FB.EnsureRecords_u, Sis.Types.strings_u,
  Sis.DB.Updater.Campo_u, Sis.DB.Updater.Campo.List_u,
  Sis.DB.Updater.Comando.List_u, Sis.DB.Updater.Operations.FB_u,
  Sis.DB.Updater.Comando.FB.CreateIndex_u;

function DBUpdaterFirebirdCreate(pTerminalId: TTerminalId;
  pDBConnectionParams: TDBConnectionParams; pPastaProduto: string; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput;
  pLoja: ISisLoja; pUsuarioAdmin: IUsuario; pVariaveis: string): IDBUpdater;
begin
  result := TDBUpdaterFirebird.Create(pTerminalId, pDBConnectionParams,
    pPastaProduto, pDBMS, pSisConfig, pProcessLog, pOutput, pLoja,
    pUsuarioAdmin, pVariaveis);
end;

function TipoToComando(pTipoStr: string; pVersaoDB: integer;
  pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
  pProcessLog: IProcessLog; pOutput: IOutput): IComando;
begin
  if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_TABLE then
    result := TComandoFBCreateTable.Create(pVersaoDB, pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_OR_ALTER_PROCEDURE then
    result := TComandoFBCreateOrAlterProcedure.Create(pVersaoDB, pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_OR_ALTER_PACKAGE then
    result := TComandoFBCreateOrAlterPackage.Create(pVersaoDB, pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_DOMAINS then
    result := TComandoFBCreateDomains.Create(pVersaoDB, pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_ENSURE_RECORDS then
    result := TComandoFBEnsureRecords.Create(pVersaoDB, pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_SEQUENCE then
    result := TComandoFBCreateSequence.Create(pVersaoDB, pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_FOREIGN_KEY then
    result := TComandoFBCreateForeignKey.Create(pVersaoDB, pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_UNIQUE_KEY then
    result := TComandoFBCreateUniqueKey.Create(pVersaoDB, pDBConnection,
      pUpdaterOperations, pProcessLog, pOutput)

  else if pTipoStr = DBATUALIZ_COMANDO_TIPO_CREATE_INDEX then
    result := TComandoFBCreateIndex.Create(pVersaoDB, pDBConnection, pUpdaterOperations,
      pProcessLog, pOutput)

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
