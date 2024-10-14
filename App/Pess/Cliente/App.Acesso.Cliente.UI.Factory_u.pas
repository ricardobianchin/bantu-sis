unit App.Acesso.Cliente.UI.Factory_u;

interface

uses App.AppInfo, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Config.SisConfig, Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Cliente_u, App.Pess.Cliente.Ent,
  App.Pess.Cliente.DBI, App.Pess.Cliente.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function ClienteEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pCliente: IEntEd; pClienteDBI: IEntDBI): TEdBasForm;

function ClientePerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pClienteEnt: IEntEd; pClienteDBI: IEntDBI): boolean;

function ClienteDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput): IFormCreator;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pClienteNome: string;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS): boolean;

implementation

uses App.DB.Utils, Sis.DB.Factory, Sis.UI.ImgDM, System.SysUtils,
  App.UI.Form.Bas.Ed.Pess.Cliente_u,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.PerfilUso_u, Sis.Sis.Constants;

function ClienteEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pCliente: IEntEd; pClienteDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessClienteEdForm.Create(AOwner, pAppInfo, pCliente, pClienteDBI);
end;

function ClientePerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pClienteEnt: IEntEd; pClienteDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ClienteEdFormCreate(AOwner, pAppInfo, pClienteEnt, pClienteDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function ClienteDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput): IFormCreator;
var
  oEnt: IPessClienteEnt;
  oDBI: IPessClienteDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams(TERMINAL_ID_RETAGUARDA,
    pAppObj.AppInfo, pSisConfig);

  oDBConnection := DBConnectionCreate('Retag.Acesso.Cliente.DataSet.Conn',
    pSisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessClienteEntCreate(pAppObj.Loja.Id, pUsuario.Id,
    pSisConfig.ServerMachineId.IdentId);
  oDBI := PessClienteDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessClienteDataSetForm,
    pFormClassNamesSL, pAppObj.AppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pClienteNome: string;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pDBMS: IDBMS): boolean;
var
  oForm: TOpcaoSisPerfilUsoTreeViewForm;
begin
  oForm := TOpcaoSisPerfilUsoTreeViewForm.Create(Application, pPerfiDeUsoId,
    pClienteNome, pAppInfo, pSisConfig, pDBMS);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
