unit App.Pess.UI.Factory_u;

interface

uses App.AppInfo, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Config.SisConfig, Sis.Usuario, Sis.UI.FormCreator,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Loja_u;

{$REGION 'loja'}
//function PessLojaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
//  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;
//
//function PessLojaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
//  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;
//
function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput
  ): IFormCreator;

{$ENDREGION}

implementation

uses App.Pess.Loja.Ent, Sis.Loja.DBI, App.Pess.Ent.Factory_u,
  App.Pess.Loja.DBI, App.DB.Utils, Sis.DB.Factory;

{$REGION 'loja impl'}

//function PessLojaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
//  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;
//begin
//  Result := nil; // TPessLojaEdForm.Create(AOwner, pAppInfo, pPessLoja, pPessLojaDBI);
//end;
//
//function PessLojaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
//  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;
//var
//  F: TEdBasForm;
//begin
//  F := PessLojaEdFormCreate(AOwner, pAppInfo, pPessLojaEnt, pPessLojaDBI);
//  Result := F.Perg;
//end;
//
function AmbiLojaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput
  ): IFormCreator;
var
  oEnt: IPessLojaEnt;
  oDBI: IPessLojaDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    pAppInfo, pSisConfig);

  oDBConnection := DBConnectionCreate('Config.Ami.Loja.DataSet.Conn', pSisConfig, pDBMS,
    oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessLojaEntCreate;
  oDBI := PessLojaDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessLojaDataSetForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI);
end;

{$ENDREGION}

end.
