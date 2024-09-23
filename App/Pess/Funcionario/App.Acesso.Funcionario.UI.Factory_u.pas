unit App.Acesso.Funcionario.UI.Factory_u;

interface

uses App.AppInfo, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Config.SisConfig, Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Funcionario_u, App.Pess.Funcionario.Ent,
  App.Pess.Funcionario.DBI, App.Pess.Funcionario.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function FuncionarioEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pFuncionario: IEntEd; pFuncionarioDBI: IEntDBI): TEdBasForm;

function FuncionarioPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pFuncionarioEnt: IEntEd; pFuncionarioDBI: IEntDBI): boolean;

function FuncionarioDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput)
  : IFormCreator;

function OpcaoSisFuncionarioPerg(pLojaId: smallint; pPerfiDeUsoId: integer;
  pFuncionarioNome: string; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS): boolean;

function PerfilDeUsoFuncionarioPerg(pFuncionarioEnt: IPessFuncionarioEnt;
  pFuncionarioDBI: IPessFuncionarioDBI): boolean;

implementation

uses App.UI.Form.Bas.Ed.Pess.Funcionario_u, App.DB.Utils, Sis.DB.Factory,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.Usuario_u, System.SysUtils,
  App.UI.Form.Diag.Pess.Funcionario.PerfilDeUso_u;

function FuncionarioEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pFuncionario: IEntEd; pFuncionarioDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessFuncionarioEdForm.Create(AOwner, pAppInfo, pFuncionario,
    pFuncionarioDBI);
end;

function FuncionarioPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pFuncionarioEnt: IEntEd; pFuncionarioDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := FuncionarioEdFormCreate(AOwner, pAppInfo, pFuncionarioEnt,
    pFuncionarioDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function FuncionarioDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppObj: IAppObj; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput)
  : IFormCreator;
var
  oEnt: IPessFuncionarioEnt;
  oDBI: IPessFuncionarioDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    pAppObj.AppInfo, pSisConfig);

  oDBConnection := DBConnectionCreate('Retag.Acesso.Funcionario.DataSet.Conn',
    pSisConfig, pDBMS, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessFuncionarioEntCreate(pAppObj.Loja.Id, pUsuario.Id,
    pSisConfig.ServerMachineId.IdentId);
  oDBI := PessFuncionarioDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessFuncionarioDataSetForm,
    pFormClassNamesSL, pAppObj.AppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI);
end;

function OpcaoSisFuncionarioPerg(pLojaId: smallint; pPerfiDeUsoId: integer;
  pFuncionarioNome: string; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS): boolean;
var
  oForm: TOpcaoSisUsuarioTreeViewForm;
begin
  oForm := TOpcaoSisUsuarioTreeViewForm.Create(Application, pLojaId,
    pPerfiDeUsoId, pFuncionarioNome, pAppInfo, pSisConfig, pDBMS);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

function PerfilDeUsoFuncionarioPerg(pFuncionarioEnt: IPessFuncionarioEnt;
  pFuncionarioDBI: IPessFuncionarioDBI): boolean;
var
  oForm: TFuncionarioPerfilDeUsoDiagForm;
begin

  oForm := TFuncionarioPerfilDeUsoDiagForm.Create(Application, pFuncionarioEnt,
    pFuncionarioDBI);

  try
    Result := oForm.Perg;
  finally
    FreeAndNil(oForm);
  end;
end;

end.
