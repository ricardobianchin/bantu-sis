unit App.UI.TabSheetForm.Factory;

interface

uses App.UI.Form.Bas.TabSheet_u, System.Classes, App.AppInfo,
  Sis.Config.SisConfig, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.DB.DBTypes, App.Ent.Ed, Data.DB
  //ents
  , App.Retag.Est.Prod.Fabr.Ent//fabr ent
  , App.Retag.Est.Prod.Natu.Ent//fabr ent
  ;
// Aju
{$REGION 'Aju'}
function RetagAjuBemVindoFormGetClassName: string;
function RetagAjuBemVindoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}
// Est
{$REGION 'Est'}
{$REGION 'Est Prod'}
{$REGION 'Est Prod Fabr'}
// Est Prod
function RetagEstProdFabrFormGetClassName: string;
function RetagEstProdFabrFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}//fim est prod fabr
{$REGION 'Est Prod Tipo'}
// Est Prod
function RetagEstProdTipoFormGetClassName: string;
function RetagEstProdTipoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}//fim est prod tipo
{$REGION 'Est Prod Unid'}
// Est Prod unid
function RetagEstProdUnidFormGetClassName: string;
function RetagEstProdUnidFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}//fim est prod unid
{$REGION 'Est Prod ICMS'}
// Est Prod ICMS
function RetagEstProdICMSFormGetClassName: string;
function RetagEstProdICMSFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}//fim est prod ICMS
{$REGION 'Est Prod prod'}
// Est Prod prod
function RetagEstProdFormGetClassName: string;
function RetagEstProdFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
{$ENDREGION}//fim est prod prod
{$ENDREGION}//fim est prod
{$ENDREGION}//fim est

implementation

uses
  App.Retag.Est.Factory

  //ajuda
  // ajuda bem-vindo
  , App.UI.Form.TabSheet.Retag.Aju.BemVindo_u

  //est
  //est prod
  , App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u
  , App.UI.Form.DataSet.Retag.Est.Prod.Tipo_u
  , App.UI.Form.DataSet.Retag.Est.Prod.Unid_u
  , App.UI.Form.DataSet.Retag.Est.Prod.ICMS_u
  , App.UI.Form.DataSet.Retag.Est.Prod_u
  ;

{$REGION 'Aju Impl'}

function RetagAjuBemVindoFormGetClassName: string;
begin
  Result := TRetagAjuBemVindoForm.ClassName;
end;

function RetagAjuBemVindoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
begin
  Result := TRetagAjuBemVindoForm.Create(AOwner, pFormClassNamesSL, pAppInfo,
    pSisConfig, pDBMS, pOutput, pProcessLog, pOutputNotify);
end;
{$ENDREGION}


{$REGION 'Est impl'}

{$REGION 'Est Prod impl'}

{$REGION 'Est Prod fabr impl'}
function RetagEstProdFabrFormGetClassName: string;
begin
  Result := TRetagEstProdFabrDataSetForm.ClassName;
end;

function RetagEstProdFabrFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
var
  oEntEd: IEntEd;
begin
//  oEntEd := RetagEstProdFabrEntCreate(dsBrowse);
//  Result := TRetagEstProdFabrDataSetForm.Create(AOwner,
//    pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS, pOutput, pProcessLog,
//    pOutputNotify, oEntEd);
end;
{$ENDREGION}//fim est prod fabr

{$REGION 'Est Prod tipo impl'}
function RetagEstProdTipoFormGetClassName: string;
begin
  Result := TRetagEstProdTipoDataSetForm.ClassName;
end;

function RetagEstProdTipoFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
var
  oEntEd: IEntEd;
begin
//  oEntEd := RetagEstProdTipoEntCreate(dsBrowse);
//  Result := TRetagEstProdTipoDataSetForm.Create(AOwner,
//    pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS, pOutput, pProcessLog,
//    pOutputNotify, oEntEd);
end;
{$ENDREGION}//fim est prod tipo
{$REGION 'Est Prod unid impl'}
function RetagEstProdUnidFormGetClassName: string;
begin
  Result := TRetagEstProdUnidDataSetForm.ClassName;
end;

function RetagEstProdUnidFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
var
  oEntEd: IEntEd;
begin
//  oEntEd := RetagEstProdUnidEntCreate(dsBrowse);
//  Result := TRetagEstProdUnidDataSetForm.Create(AOwner,
//    pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS, pOutput, pProcessLog,
//    pOutputNotify, oEntEd);
end;
{$ENDREGION}//fim est prod unid
{$REGION 'Est Prod ICMS impl'}
function RetagEstProdICMSFormGetClassName: string;
begin
  Result := TRetagEstProdICMSDataSetForm.ClassName;
end;

function RetagEstProdICMSFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
var
  oEntEd: IEntEd;
begin
//  oEntEd := RetagEstProdICMSEntCreate(dsBrowse);
//  Result := TRetagEstProdICMSDataSetForm.Create(AOwner,
//    pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS, pOutput, pProcessLog,
//    pOutputNotify, oEntEd);
end;
{$ENDREGION}//fim est prod ICMS
{$REGION 'Est Prod prod impl'}
function RetagEstProdFormGetClassName: string;
begin
  Result := TRetagEstProdDataSetForm.ClassName;
end;

function RetagEstProdFormCreate(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput): TTabSheetAppBasForm;
var
  oProdFabrEnt: IProdFabrEnt;
  oProdNatuEnt: IProdNatuEnt;
  oEntEd: IEntEd;
begin
//  oProdFabrEnt := RetagEstProdFabrEntCreate(dsBrowse);
//  oProdNatuEnt := RetagEstProdNatuEntCreate('P', 'PRODUTO');
//
//  oEntEd := RetagEstProdEntCreate(dsBrowse, oProdFabrEnt, oProdNatuEnt);
//
//  Result := TRetagEstProdDataSetForm.Create(AOwner,
//    pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS, pOutput, pProcessLog,
//    pOutputNotify, oEntEd);
end;
{$ENDREGION}//fim est prod prod
{$ENDREGION}//fim est prod
{$ENDREGION}//fim est

end.
