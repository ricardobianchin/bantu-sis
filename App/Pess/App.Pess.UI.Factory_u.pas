unit App.Pess.UI.Factory_u;

interface

uses App.AppObj, App.AppInfo, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Config.SisConfig, Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Loja_u;

{$REGION 'loja'}
function PessLojaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;

function PessLojaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;

function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput
  ): IFormCreator;

{$ENDREGION}

implementation

uses App.Pess.Loja.Ent, Sis.Loja.DBI, App.Pess.Loja.Ent.Factory_u,
  App.Pess.Loja.DBI, App.DB.Utils, Sis.DB.Factory,
  App.UI.Form.Bas.Ed.Pess.Loja_u, Sis.Sis.Constants;

{$REGION 'loja impl'}

function PessLojaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessLojaEdForm.Create(AOwner, pAppInfo, pPessLoja, pPessLojaDBI);
end;

function PessLojaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := PessLojaEdFormCreate(AOwner, pAppInfo, pPessLojaEnt, pPessLojaDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput
  ): IFormCreator;
var
  oEnt: IPessLojaEnt;
  oDBI: IPessLojaDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    pAppObj.AppInfo, pSisConfig);

  oDBConnection := DBConnectionCreate('Config.Ami.Loja.DataSet.Conn', pSisConfig,
    oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessLojaEntCreate(pAppObj.Loja.Id, pUsuario.Id,  pSisConfig.ServerMachineId.IdentId);
  oDBI := PessLojaDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessLojaDataSetForm,
    pFormClassNamesSL, pAppObj.AppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

{$ENDREGION}

end.
