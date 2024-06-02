unit App.Pess.Factory_u;

interface

uses App.Generos, Sis.DB.DBTypes, App.Pess.Ent, Data.DB, Sis.DB.DBTypes,
  Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes,
  Sis.Entidade, Sis.Loja, Sis.Usuario, App.UI.Form.Bas.Ed_u,
  Sis.UI.Controls.ComboBoxManager, App.AppInfo, Sis.Config.SisConfig,
  Sis.UI.FormCreator;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;

{$REGION 'loja'}
function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstPessLojaEntCreate: IPessLojaEnt;

function RetagEstPessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IEntEd): IEntDBI;

function PessLojaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLoja: IEntEd; pPessLojaDBI: IEntDBI): TEdBasForm;

function PessLojaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPessLojaEnt: IEntEd; pPessLojaDBI: IEntDBI): boolean;

// function DecoratorExclPessLojaCreate(pPessLoja: IEntEd): IDecoratorExcl;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;

{$ENDREGION}

implementation

uses App.Generos_u, App.Pess.Ent_u;

, Vcl.Controls, App.UI.FormCreator.DataSet_u

{$REGION 'uses loja'}
  , App.Retag.Est.Prod.Fabr.Ent_u // fabr ent
  , App.Retag.Est.Prod.Fabr.DBI_u // fabr dbi
  , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form
  , App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u
{$ENDREGION}
  ;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;
var
  s: string;
begin
  Result := TGeneros.Create;
end;

{$REGION 'loja impl'}

function EntEdCastToPessLojaEnt(pEntEd: IEntEd): IPessLojaEnt;
begin
  Result := TPessLojaEnt(pEntEd);
end;

function EntDBICastToPessLojaDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TPessLojaDBI(pEntDBI);
end;

function RetagEstPessLojaEntCreate: IPessLojaEnt;
begin
  Result := TPessLojaEnt.Create(pState, pId, pDescr);
end;

function RetagEstPessLojaDBICreate(pDBConnection: IDBConnection;
  pPessLojaEnt: IEntEd): IEntDBI;
begin
  Result := TPessLojaDBI.Create(pDBConnection, TPessLojaEnt(pPessLojaEnt));
end;

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
  Result := F.Perg;
end;

// function DecoratorExclPessLojaCreate(pPessLoja: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pPessLoja);
// end;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstPessLojaDataSetForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI);
end;

{$ENDREGION}

end.
