unit App.Acesso.Fornecedor.UI.Factory_u;

interface

uses App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Fornecedor_u, App.Pess.Fornecedor.Ent,
  App.Pess.Fornecedor.DBI, App.Pess.Fornecedor.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function FornecedorEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pFornecedor: IEntEd; pFornecedorDBI: IEntDBI): TEdBasForm;

function FornecedorPerg(AOwner: TComponent; pFornecedorEnt: IEntEd;
  pFornecedorDBI: IEntDBI; pAppObj: IAppObj): boolean;

function FornecedorDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj): IFormCreator;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pFornecedorNome: string;
  pDBMS: IDBMS; pAppObj: IAppObj): boolean;

implementation

uses App.DB.Utils, Sis.DB.Factory, Sis.UI.ImgDM, System.SysUtils,
  App.UI.Form.Bas.Ed.Pess.Fornecedor_u,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.PerfilUso_u, Sis.Sis.Constants;

function FornecedorEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pFornecedor: IEntEd; pFornecedorDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessFornecedorEdForm.Create(AOwner, pAppObj, pFornecedor, pFornecedorDBI);
end;

function FornecedorPerg(AOwner: TComponent; pFornecedorEnt: IEntEd;
  pFornecedorDBI: IEntDBI; pAppObj: IAppObj): boolean;
var
  F: TEdBasForm;
begin
  F := FornecedorEdFormCreate(AOwner, pAppObj, pFornecedorEnt, pFornecedorDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function FornecedorDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj): IFormCreator;
var
  oEnt: IPessFornecedorEnt;
  oDBI: IPessFornecedorDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, pAppObj);

  oDBConnection := DBConnectionCreate('Retag.Acesso.Fornecedor.DataSet.Conn',
    pAppObj.SisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessFornecedorEntCreate(pAppObj.Loja.Id, pUsuarioLog.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId);
  oDBI := PessFornecedorDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessFornecedorDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

function OpcaoSisPerfilUsoPerg(pPerfiDeUsoId: integer; pFornecedorNome: string;
  pDBMS: IDBMS; pAppObj: IAppObj): boolean;
var
  oForm: TOpcaoSisPerfilUsoTreeViewForm;
begin
  oForm := TOpcaoSisPerfilUsoTreeViewForm.Create(Application, pPerfiDeUsoId,
    pFornecedorNome, pAppObj, pDBMS);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
