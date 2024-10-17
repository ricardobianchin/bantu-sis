unit App.Acesso.PerfilDeUso.UI.Factory_u;

interface

uses App.AppInfo, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Config.SisConfig, Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Acesso.PerfilDeUso_u, App.Acesso.PerfilDeUso.Ent,
  App.Acesso.PerfilDeUso.DBI, App.Acesso.PerfilDeUso.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function PerfilDeUsoEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPerfilDeUso: IEntEd; pPerfilDeUsoDBI: IEntDBI): TEdBasForm;

function PerfilDeUsoPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPerfilDeUsoEnt: IEntEd; pPerfilDeUsoDBI: IEntDBI): boolean;

function PerfilDeUsoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pPerfilDeUsoNome: string;
  pAppObj: IAppObj; pDBMS: IDBMS): boolean;

implementation

uses App.Pess.Loja.Ent, Sis.Loja.DBI, App.Pess.Loja.DBI, App.DB.Utils,
  Sis.DB.Factory, Sis.UI.ImgDM, System.SysUtils, App.Pess.Loja.Ent.Factory_u,
  App.UI.Form.Ed.Acesso.PerfilDeUso_u,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.PerfilUso_u, Sis.Sis.Constants;

function PerfilDeUsoEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPerfilDeUso: IEntEd; pPerfilDeUsoDBI: IEntDBI): TEdBasForm;
begin
  Result := TPerfilDeUsoEdForm.Create(AOwner, pAppInfo, pPerfilDeUso,
    pPerfilDeUsoDBI);
end;

function PerfilDeUsoPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPerfilDeUsoEnt: IEntEd; pPerfilDeUsoDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := PerfilDeUsoEdFormCreate(AOwner, pAppInfo, pPerfilDeUsoEnt,
    pPerfilDeUsoDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function PerfilDeUsoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;
var
  oEnt: IPerfilDeUsoEnt;
  oDBI: IPerfilDeUsoDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    pAppObj);

  oDBConnection := DBConnectionCreate('Retag.Acesso.PerfilDeUso.DataSet.Conn',
    pSisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PerfilDeUsoEntCreate;
  oDBI := PerfilDeUsoDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TPerfilDeUsoDataSetForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pPerfilDeUsoNome: string;
  pAppObj: IAppObj; pDBMS: IDBMS): boolean;
var
  oForm: TOpcaoSisPerfilUsoTreeViewForm;
begin
  oForm := TOpcaoSisPerfilUsoTreeViewForm.Create(Application, pPerfiDeUsoId,
    pPerfilDeUsoNome, pAppObj, pDBMS);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
