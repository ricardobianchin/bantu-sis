unit App.Acesso.Cliente.UI.Factory_u;

interface

uses App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Cliente_u, App.Pess.Cliente.Ent,
  App.Pess.Cliente.DBI, App.Pess.Cliente.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function ClienteEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pCliente: IEntEd; pClienteDBI: IEntDBI): TEdBasForm;

function ClientePerg(AOwner: TComponent; pClienteEnt: IEntEd;
  pClienteDBI: IEntDBI; pAppObj: IAppObj): boolean;

function ClienteDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj): IFormCreator;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pClienteNome: string;
  pDBMS: IDBMS; pAppObj: IAppObj): boolean;

implementation

uses App.DB.Utils, Sis.DB.Factory, Sis.UI.ImgDM, System.SysUtils,
  App.UI.Form.Bas.Ed.Pess.Cliente_u,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.PerfilUso_u, Sis.Sis.Constants;

function ClienteEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pCliente: IEntEd; pClienteDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessClienteEdForm.Create(AOwner, pAppObj, pCliente, pClienteDBI);
end;

function ClientePerg(AOwner: TComponent; pClienteEnt: IEntEd;
  pClienteDBI: IEntDBI; pAppObj: IAppObj): boolean;
var
  F: TEdBasForm;
begin
  F := ClienteEdFormCreate(AOwner, pAppObj, pClienteEnt, pClienteDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function ClienteDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj): IFormCreator;
var
  oEnt: IPessClienteEnt;
  oDBI: IPessClienteDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, pAppObj);

  oDBConnection := DBConnectionCreate('Retag.Acesso.Cliente.DataSet.Conn',
    pAppObj.SisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessClienteEntCreate(pAppObj.Loja.Id, pUsuarioLog.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId);
  oDBI := PessClienteDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessClienteDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pClienteNome: string;
  pDBMS: IDBMS; pAppObj: IAppObj): boolean;
var
  oForm: TOpcaoSisPerfilUsoTreeViewForm;
begin
  oForm := TOpcaoSisPerfilUsoTreeViewForm.Create(Application, pPerfiDeUsoId,
    pClienteNome, pAppObj, pDBMS);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
