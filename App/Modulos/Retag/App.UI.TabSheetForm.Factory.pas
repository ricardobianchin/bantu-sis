unit App.UI.TabSheetForm.Factory;

interface

uses App.UI.Form.Bas.TabSheet_u, System.Classes, App.AppInfo,
  Sis.Config.SisConfig;
// Aju
{$REGION 'Aju'}
function RetagAjuBemVindoFormGetClassName: string;
function RetagAjuBemVindoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig)
  : TTabSheetAppBasForm;
{$ENDREGION}
// Est
{$REGION 'Est'}
{$REGION 'Est Prod'}
// Est Prod
function RetagEstProdFabrFormGetClassName: string;
function RetagEstProdFabrFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig)
  : TTabSheetAppBasForm;
{$ENDREGION}
{$ENDREGION}

implementation

uses App.UI.Form.TabSheet.Retag.Aju.BemVindo_u,
  App.UI.Form.TabSheet.Retag.Est.Prod.Fabr_u;

{$REGION 'Aju Impl'}

function RetagAjuBemVindoFormGetClassName: string;
begin
  Result := TRetagAjuBemVindoForm.ClassName;
end;

function RetagAjuBemVindoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig)
  : TTabSheetAppBasForm;
begin
  Result := TRetagAjuBemVindoForm.Create(AOwner, pFormClassNamesSL, pAppInfo,
    pSisConfig);
end;
{$ENDREGION}
{$REGION 'Est Prod impl'}

function RetagEstProdFabrFormGetClassName: string;
begin
  Result := TRetagEstProdFabrTabSheetDataSetForm.ClassName;
end;

function RetagEstProdFabrFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig)
  : TTabSheetAppBasForm;
begin
  Result := TRetagEstProdFabrTabSheetDataSetForm.Create(AOwner,
    pFormClassNamesSL, pAppInfo, pSisConfig);
end;
{$ENDREGION}

end.
