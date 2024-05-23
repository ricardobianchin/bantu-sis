unit App.Retag.Aju.Factory;

interface

uses Data.DB, Sis.DB.DBTypes, Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, System.Classes, App.UI.Form.Bas.Ed_u, Sis.Usuario,
  Sis.UI.Controls.ComboBoxManager, App.AppInfo, Sis.Config.SisConfig,
  App.UI.FormCreator.TabSheet_u, Sis.UI.FormCreator, App.Ent.Ed,
  App.Ent.DBI
  //
  , App.Retag.Aju.VersaoDB.Ent
    ;

{$REGION 'BemVindo'}
function AjuBemVindoSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput)
  : IFormCreator;
{$ENDREGION}


{$REGION 'VersaoDB'}
function EntEdCastToVersaoDBEnt(pEntEd: IEntEd): IVersaoDBEnt;
function EntDBICastToVersaoDBDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstVersaoDBEntCreate(pState: TDataSetState = dsBrowse): IVersaoDBEnt;

function RetagAjuVersaoDBDBICreate(pDBConnection: IDBConnection;
  pVersaoDBEnt: IEntEd): IEntDBI;

// function DecoratorExclVersaoDBCreate(pVersaoDB: IEntEd): IDecoratorExcl;

function AjuVersaoDBDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;
{$ENDREGION}

implementation

uses App.UI.Form.TabSheet.Retag.Aju.BemVindo_u, Vcl.Controls,
  App.UI.FormCreator.DataSet_u

  //
   , App.Ent.Ed.Id_u//
   , App.Retag.Aju.VersaoDB.Ent_u//
   , App.Retag.Aju.VersaoDB.DBI_u // fabr dbi
    , App.UI.Form.DataSet.Retag.Aju.VersaoDB_u
    ;

{$REGION 'BemVindo' impl}
function AjuBemVindoSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): IFormCreator;
begin
  Result := TTabSheetFormCreator.Create(TRetagAjuBemVindoForm, 'Bem-Vindo',
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify);
end;

{$ENDREGION}


{$REGION 'versaodb impl'}

function EntEdCastToVersaoDBEnt(pEntEd: IEntEd): IVersaoDBEnt;
begin
  Result := TVersaoDBEnt(pEntEd);
end;

function EntDBICastToVersaoDBDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TVersaoDBDBI(pEntDBI);
end;

function RetagEstVersaoDBEntCreate(pState: TDataSetState): IVersaoDBEnt;
begin
  Result := TVersaoDBEnt.Create(pState);
end;

function RetagAjuVersaoDBDBICreate(pDBConnection: IDBConnection;
  pVersaoDBEnt: IEntEd): IEntDBI;
begin
  Result := TVersaoDBDBI.Create(pDBConnection, TVersaoDBEnt(pVersaoDBEnt));
end;

function AjuVersaoDBDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagAjuVersaoDBDataSetForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI);
end;

{$ENDREGION}

end.
