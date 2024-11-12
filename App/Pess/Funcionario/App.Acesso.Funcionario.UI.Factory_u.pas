unit App.Acesso.Funcionario.UI.Factory_u;

interface

uses App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output, System.Classes,
  Sis.Usuario, Sis.UI.FormCreator, App.UI.Form.Bas.Ed_u,
  App.UI.FormCreator.DataSet_u, Sis.UI.IO.Output.ProcessLog, Sis.DB.DBTypes,
  App.UI.Form.DataSet.Pess.Funcionario_u, App.Pess.Funcionario.Ent,
  App.Pess.Funcionario.DBI, App.Pess.Funcionario.Ent.Factory_u, Sis.Types,
  VCL.Controls, VCL.Forms, App.AppObj;

function FuncionarioEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pFuncionario: IEntEd; pFuncionarioDBI: IEntDBI): TEdBasForm;

function FuncionarioPerg(AOwner: TComponent; pAppObj: IAppObj;
  pFuncionarioEnt: IEntEd; pFuncionarioDBI: IEntDBI): boolean;

function FuncionarioDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;

function OpcaoSisFuncionarioPerg(pLojaId: smallint; pLogUsuarioId: integer;
  pUsuarioIdEnvolvido: integer; pUsuarioNomeEnvolvido: string; pAppObj: IAppObj;
  pDBMS: IDBMS): boolean;

function PerfilDeUsoFuncionarioPerg(pFuncionarioEnt: IPessFuncionarioEnt;
  pFuncionarioDBI: IPessFuncionarioDBI): boolean;

implementation

uses App.UI.Form.Bas.Ed.Pess.Funcionario_u, App.DB.Utils, Sis.DB.Factory,
  App.UI.Form.TreeView.Retag.Acesso.OpcaoSis.Usuario_u, System.SysUtils,
  App.UI.Form.Diag.Pess.Funcionario.PerfilDeUso_u, Sis.Sis.Constants;

function FuncionarioEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pFuncionario: IEntEd; pFuncionarioDBI: IEntDBI): TEdBasForm;
begin
  Result := TPessFuncionarioEdForm.Create(AOwner, pAppObj, pFuncionario,
    pFuncionarioDBI);
end;

function FuncionarioPerg(AOwner: TComponent; pAppObj: IAppObj;
  pFuncionarioEnt: IEntEd; pFuncionarioDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := FuncionarioEdFormCreate(AOwner, pAppObj, pFuncionarioEnt,
    pFuncionarioDBI);
  try
    Result := F.Perg;
  finally
    F.Free;
  end;
end;

function FuncionarioDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
  : IFormCreator;
var
  oEnt: IPessFuncionarioEnt;
  oDBI: IPessFuncionarioDBI;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, pAppObj);

  oDBConnection := DBConnectionCreate('Retag.Acesso.Funcionario.DataSet.Conn',
    pAppObj.SisConfig, oDBConnectionParams, pProcessLog, pOutput);

  oEnt := PessFuncionarioEntCreate(pAppObj.Loja.Id, pUsuarioLog.Id,
    pAppObj.SisConfig.ServerMachineId.IdentId);
  oDBI := PessFuncionarioDBICreate(oDBConnection, oEnt);

  Result := TDataSetFormCreator.Create(TAppPessFuncionarioDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, oEnt, oDBI, pAppObj);
end;

function OpcaoSisFuncionarioPerg(pLojaId: smallint; pLogUsuarioId: integer;
  pUsuarioIdEnvolvido: integer; pUsuarioNomeEnvolvido: string; pAppObj: IAppObj;
  pDBMS: IDBMS): boolean;
var
  oForm: TOpcaoSisUsuarioTreeViewForm;
begin
  oForm := TOpcaoSisUsuarioTreeViewForm.Create(Application, pLojaId,
    pLogUsuarioId, pUsuarioIdEnvolvido, pUsuarioNomeEnvolvido, pAppObj, pDBMS);
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
