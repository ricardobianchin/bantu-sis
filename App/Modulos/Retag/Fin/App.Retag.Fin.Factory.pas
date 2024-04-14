unit App.Retag.Fin.Factory;

interface

uses App.Fin.PagFormaTipo, App.Ent.Ed, App.Ent.DBI, App.Retag.Fin.PagForma.Ent,
  Data.DB, Sis.DB.DBTypes, App.UI.Form.Bas.Ed_u, Vcl.StdCtrls, System.Classes,
  Sis.Config.SisConfig, Sis.Loja, Sis.Usuario, Sis.UI.IO.Output.ProcessLog,
  App.AppInfo, Sis.UI.IO.Output, Sis.UI.FormCreator,
  App.Retag.Fin.PagForma.Ed.DBI;

function PagFormaTipoCreate: IPagFormaTipo;

{$REGION 'fin pag forma'}
function EntEdCastToPagFormaEnt(pEntEd: IEntEd): IPagFormaEnt;
function EntDBICastToFormaTipoDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagFinPagFormaEntCreate(pLojaId: smallint; pUsuarioId: integer;
  pMachineIdentId: smallint; pPagFormaTipo: IPagFormaTipo): IPagFormaEnt;

function RetagFinPagFormaDBICreate(pDBConnection: IDBConnection;
  pPagFormaEnt: IEntEd): IEntDBI;

function PagFormaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPagFormaEnt: IEntEd; pPagFormaDBI: IEntDBI): TEdBasForm;

function PagFormaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPagFormaEnt: IEntEd; pPagFormaDBI: IEntDBI): boolean;

// function DecoratorExclPagFormaCreate(pPagForma: IEntEd): IDecoratorExcl;

function PagFormaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;

function PagFormaEdDBICreate(pDBConnection: IDBConnection): IPagFormaEdDBI;

{$ENDREGION}

implementation

uses App.Fin.PagFormaTipo_u, App.Retag.Fin.PagForma.DBI_u,
  App.Retag.Fin.PagForma.Ent_u, App.UI.Form.DataSet.Retag.Fin.PagForma_u,
  App.UI.Form.Ed.Fin.PagForma_u, App.UI.FormCreator.DataSet_u,
  App.Retag.Fin.PagForma.Ed.DBI_u;

function PagFormaTipoCreate: IPagFormaTipo;
begin
  Result := TPagFormaTipo.Create();
end;

{$REGION 'fin pag forma impl'}

function EntEdCastToPagFormaEnt(pEntEd: IEntEd): IPagFormaEnt;
begin
  Result := TPagFormaEnt(pEntEd);
end;

function EntDBICastToFormaTipoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TPagFormaDBI(pEntDBI);
end;

function RetagFinPagFormaEntCreate(pLojaId: smallint; pUsuarioId: integer;
  pMachineIdentId: smallint; pPagFormaTipo: IPagFormaTipo): IPagFormaEnt;
begin
  Result := TPagFormaEnt.Create(pLojaId, pUsuarioId, pMachineIdentId,
    pPagFormaTipo);
end;

function RetagFinPagFormaDBICreate(pDBConnection: IDBConnection;
  pPagFormaEnt: IEntEd): IEntDBI;
begin
  Result := TPagFormaDBI.Create(pDBConnection, TPagFormaEnt(pPagFormaEnt));
end;

function PagFormaEdFormCreate(AOwner: TComponent; pAppInfo: IAppInfo;
  pPagFormaEnt: IEntEd; pPagFormaDBI: IEntDBI): TEdBasForm;
begin
  Result := TPagFormaEdForm.Create(AOwner, pAppInfo, pPagFormaEnt,
    pPagFormaDBI);
end;

function PagFormaPerg(AOwner: TComponent; pAppInfo: IAppInfo;
  pPagFormaEnt: IEntEd; pPagFormaDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := PagFormaEdFormCreate(AOwner, pAppInfo, pPagFormaEnt, pPagFormaDBI);
  Result := F.Perg;
end;

// function DecoratorExclPagFormaCreate(pPagForma: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclPagForma.Create(pPagForma);
// end;

function PagFormaDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagFinPagFormaDataSetForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI);
end;

function PagFormaEdDBICreate(pDBConnection: IDBConnection): IPagFormaEdDBI;
begin
  Result := TPagFormaEdDBI.Create(pDBConnection);
end;

{$ENDREGION}

end.
