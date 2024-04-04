unit App.Retag.Aju.Factory;

interface

uses Data.DB, Sis.DB.DBTypes, Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, System.Classes, App.UI.Form.Bas.Ed_u, Sis.Usuario,
  Sis.UI.Controls.ComboBoxManager, App.AppInfo, Sis.Config.SisConfig,
  App.UI.FormCreator.TabSheet_u, Sis.UI.FormCreator
  //
    ;

{$REGION 'aju'}

//function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
//function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;
//
//function RetagEstProdFabrEntCreate(pState: TDataSetState = dsBrowse;
//  pId: integer = 0; pDescr: string = 'NAO INDICADO'): IProdFabrEnt;
//
//function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
//  pProdFabrEnt: IEntEd): IEntDBI;
//
//function ProdFabrEdFormCreate(AOwner: TComponent; pProdFabr: IEntEd;
//  pProdFabrDBI: IEntDBI): TEdBasForm;
//
//function ProdFabrPerg(AOwner: TComponent; pProdFabrEnt: IEntEd;
//  pProdFabrDBI: IEntDBI): boolean;
//
//function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
//
function AjuBemVindoSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): IFormCreator;

{$ENDREGION}

implementation

{$REGION 'prod fabr impl'}

uses App.UI.Form.TabSheet.Retag.Aju.BemVindo_u;

//function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
//begin
//  Result := TProdFabrEnt(pEntEd);
//end;
//
//function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;
//begin
//  Result := TProdFabrDBI(pEntDBI);
//end;
//
//function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer;
//  pDescr: string): IProdFabrEnt;
//begin
//  Result := TProdFabrEnt.Create(pState, pId, pDescr);
//end;
//
//function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
//  pProdFabrEnt: IEntEd): IEntDBI;
//begin
//  Result := TProdFabrDBI.Create(pDBConnection, TProdFabrEnt(pProdFabrEnt));
//end;
//
//function ProdFabrEdFormCreate(AOwner: TComponent; pProdFabr: IEntEd;
//  pProdFabrDBI: IEntDBI): TEdBasForm;
//begin
//  Result := TProdFabrEdForm.Create(AOwner, pProdFabr, pProdFabrDBI);
//end;
//
//function ProdFabrPerg(AOwner: TComponent; pProdFabrEnt: IEntEd;
//  pProdFabrDBI: IEntDBI): boolean;
//var
//  F: TEdBasForm;
//begin
//  F := ProdFabrEdFormCreate(AOwner, pProdFabrEnt, pProdFabrDBI);
//  Result := F.Perg;
//end;

function AjuBemVindoSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pAppInfo: IAppInfo; pSisConfig: ISisConfig; pUsuario: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput): IFormCreator;
begin
  Result := TTabSheetFormCreator.Create(TRetagAjuBemVindoForm,
    pFormClassNamesSL, pAppInfo, pSisConfig, pUsuario, pDBMS, pOutput, pProcessLog,
    pOutputNotify);
end;

{$ENDREGION}

end.
