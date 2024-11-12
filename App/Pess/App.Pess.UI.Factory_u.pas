unit App.Pess.UI.Factory_u;

interface

uses App.AppObj, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Loja_u;

{$REGION 'loja'}
function PessLojaEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;

function PessLojaPerg(AOwner: TComponent; pAppObj: IAppObj;
  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;

function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;

{$ENDREGION}

implementation

uses App.Pess.Loja.Ent, Sis.Loja.DBI, App.Pess.Loja.Ent.Factory_u,
  App.Pess.Loja.DBI, App.DB.Utils, Sis.DB.Factory,
  App.UI.Form.Bas.Ed.Pess.Loja_u, Sis.Sis.Constants;

{$REGION 'loja impl'}

function PessLojaEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessLojaEdForm.Create(AOwner, pAppObj, pPessLoja, pPessLojaDBI);
end;

function PessLojaPerg(AOwner: TComponent; pAppObj: IAppObj;
  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := PessLojaEdFormCreate(AOwner, pAppObj, pPessLojaEnt, pPessLojaDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;
var
  oEnt: IPessLojaEnt;
  oDBI: IPessLojaDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, pAppObj);

  oDBConnection := DBConnectionCreate( 'Config.Ami.Loja.DataSet.Conn',
    pAppObj.SisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessLojaEntCreate(pAppObj.Loja.Id, pAppObj.Loja.Id, pUsuarioLog.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId);
  oDBI := PessLojaDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessLojaDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

{$ENDREGION}

end.
