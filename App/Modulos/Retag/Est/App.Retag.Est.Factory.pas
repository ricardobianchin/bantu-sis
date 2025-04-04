unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes, Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, System.Classes, Sis.Entidade, Sis.Loja, Sis.Usuario,
  App.UI.Form.Bas.Ed_u, Sis.UI.Controls.ComboBoxManager, App.AppObj,
  Sis.UI.FormCreator,
  Sis.DB.UltimoId

  // os dbi que seguem o padrao, retornam iented
    , App.Ent.Ed, App.Ent.DBI

  // os dbi que nao seguem o padrao, deves ser citados aqui
    , App.Retag.Est.Prod.ICMS.Ent // icms ent

    , App.Retag.Est.Prod.Ent // prod ent

    , App.Retag.Est.Prod.Fabr.Ent // fabr ent

  // prod tipo
    , App.Retag.Est.Prod.Tipo.Ent

  // prod unid
    , App.Retag.Est.Prod.Unid.Ent

  // prod barras
    , App.Retag.Est.Prod.Barras.Ent //
    , App.Retag.Est.Prod.Barras.Ent.List //
    , App.Est.Prod.Barras.DBI //

  // prod balanca
    , App.Retag.Est.Prod.Balanca.Ent, App.Retag.Est.Prod.Ed.DBI

    ;

{$REGION 'prod fabr'}
function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdFabrEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = 'NAO INDICADO'): IProdFabrEnt;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;

function ProdFabrEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabr: IEntEd; pProdFabrDBI: IEntDBI): TEdBasForm;

function ProdFabrPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabrEnt: IEntEd; pProdFabrDBI: IEntDBI): boolean;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

{$ENDREGION}
{$REGION 'prod tipo'}
function EntEdCastToProdTipoEnt(pEntEd: IEntEd): IProdTipoEnt;
function EntDBICastToProdTipoDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdTipoEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdTipoEnt;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;

function ProdTipoEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipo: IEntEd; pProdTipoDBI: IEntDBI): TEdBasForm;

function ProdTipoPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipoEnt: IEntEd; pProdTipoDBI: IEntDBI): boolean;

// function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;

function ProdTipoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

{$ENDREGION}
{$REGION 'prod unid'}
function EntEdCastToProdUnidEnt(pEntEd: IEntEd): IProdUnidEnt;
function EntDBICastToProdUnidDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdUnidEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdUnidEnt;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;

function ProdUnidEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnid: IEntEd; pProdUnidDBI: IEntDBI): TEdBasForm;

function ProdUnidPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnidEnt: IEntEd; pProdUnidDBI: IEntDBI): boolean;

// function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;

function ProdUnidDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
{$ENDREGION}
{$REGION 'prod ICMS'}
function EntEdCastToProdICMSEnt(pEntEd: IEntEd): IProdICMSEnt;
function EntDBICastToProdICMSDBI(pEntDBI: IEntDBI): IEntDBI;

function RetagEstProdICMSEntCreate(pState: TDataSetState = dsBrowse;
  pId: integer = 0; pDescr: string = ''): IProdICMSEnt;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IEntEd): IEntDBI;

function ProdICMSEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMS: IEntEd; pProdICMSDBI: IEntDBI): TEdBasForm;

function ProdICMSPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMSEnt: IEntEd; pProdICMSDBI: IEntDBI): boolean;

// function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;

function ProdICMSDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

{$ENDREGION}
{$REGION 'prod'}
function RetagEstProdEdDBICreate(pDBConnection: IDBConnection)
  : IRetagEstProdEdDBI;

function RetagEstProdEntCreate(pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint; //
  //
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdTipoEnt: IProdTipoEnt; // fabr
  pProdUnidEnt: IProdUnidEnt; // fabr
  pProdICMSEnt: IProdICMSEnt; // fabr
  pProdBarrasList: IProdBarrasList; // prod barras list
  pProdBalancaEnt: IProdBalancaEnt; //
  //
  pState: TDataSetState = dsBrowse;
  // campos
  pId: integer = 0; pDescr: string = ''; pDescrRed: string = ''): IProdEnt;

function RetagEstProdDBICreate(pDBConnection: IDBConnection;
  pProdEnt: IEntEd): IEntDBI;

function ProdEdFormCreate(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): TEdBasForm;

function ProdPerg(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;
  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;
  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): boolean;

// function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;

function ProdDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;

function ProdDataSetUltimoIdCreate(pQ: TDataSet): IUltimoId;
{$ENDREGION}
{$REGION 'prod barras'}
function ProdBarrasCreate(pOrdem: smallint = 0; pBarras: string = '')
  : IProdBarras;
function ProdBarrasListCreate: IProdBarrasList;
{$ENDREGION}
{$REGION 'prod balanca'}
function ProdBalancaEntCreate: IProdBalancaEnt;
{$ENDREGION}
{$REGION 'xxx'}
{$ENDREGION}

implementation

uses Vcl.Controls, App.UI.FormCreator.DataSet_u

{$REGION 'uses fabr'}
  // fabr
    , App.Retag.Est.Prod.Fabr.Ent_u // fabr ent
    , App.Retag.Est.Prod.Fabr.DBI_u // fabr dbi
    , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u
{$ENDREGION}
{$REGION 'uses tipo'}
  // tipo
    , App.Retag.Est.Prod.Tipo.Ent_u // tipo ent
    , App.Retag.Est.Prod.Tipo.DBI_u // tipo dbi
    , App.UI.Form.Ed.Prod.Tipo_u // tipo ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Tipo_u //
{$ENDREGION}
{$REGION 'uses unid'}
  // unid
    , App.Retag.Est.Prod.Unid.Ent_u // ent
    , App.Retag.Est.Prod.Unid.DBI_u // unid dbi
    , App.UI.Form.Ed.Prod.Unid_u // Unid ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.Unid_u //
{$ENDREGION}
{$REGION 'uses icms'}
  // icms
    , App.Retag.Est.Prod.ICMS.Ent_u // icms ent
    , App.Retag.Est.Prod.ICMS.DBI_u // icms dbi
    , App.UI.Form.Ed.Prod.ICMS_u // icms ed form
    , App.UI.Form.DataSet.Retag.Est.Prod.ICMS_u //
{$ENDREGION}
{$REGION 'uses prod'}
  // prod
    , App.Retag.Est.Prod.Ent_u // prod ent
    , App.Retag.Est.Prod.DBI_u // prod dbi
    , App.UI.Form.Ed.Prod_u // prod ed form
    , App.UI.Form.DataSet.Retag.Est.Prod_u //
    , App.Retag.Est.Prod.UltimoId_u //
{$ENDREGION}
  // prod barras
    , App.Retag.Est.Prod.Barras.Ent_u, App.Retag.Est.Prod.Barras.Ent.List_u

  // prod balanca
    , App.Retag.Est.Prod.Balanca.Ent_u

  //
    , App.Retag.Est.Prod.Ed.DBI_u;

{$REGION 'prod fabr impl'}

function EntEdCastToProdFabrEnt(pEntEd: IEntEd): IProdFabrEnt;
begin
  Result := TProdFabrEnt(pEntEd);
end;

function EntDBICastToProdFabrDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdFabrDBI(pEntDBI);
end;

function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdFabrEnt;
begin
  Result := TProdFabrEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;
begin
  Result := TProdFabrDBI.Create(pDBConnection, TProdFabrEnt(pProdFabrEnt));
end;

function ProdFabrEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabr: IEntEd; pProdFabrDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdFabrEdForm.Create(AOwner, pAppObj, pProdFabr, pProdFabrDBI);
end;

function ProdFabrPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdFabrEnt: IEntEd; pProdFabrDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pAppObj, pProdFabrEnt, pProdFabrDBI);
  Result := F.Perg;
end;

// function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclFabr.Create(pProdFabr);
// end;

function FabrDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdFabrDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify,
    pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod tipo impl'}

function EntEdCastToProdTipoEnt(pEntEd: IEntEd): IProdTipoEnt;
begin
  Result := TProdTipoEnt(pEntEd);
end;

function EntDBICastToProdTipoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdTipoDBI(pEntDBI);
end;

function RetagEstProdTipoEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdTipoEnt;
begin
  Result := TProdTipoEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;
begin
  Result := TProdTipoDBI.Create(pDBConnection, TProdTipoEnt(pProdTipoEnt));
end;

function ProdTipoEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipo: IEntEd; pProdTipoDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdTipoEdForm.Create(AOwner, pAppObj, pProdTipo, pProdTipoDBI);
end;

function ProdTipoPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdTipoEnt: IEntEd; pProdTipoDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdTipoEdFormCreate(AOwner, pAppObj, pProdTipoEnt, pProdTipoDBI);
  Result := F.Perg;
end;

// function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclTipo.Create(pProdTipo);
// end;

function ProdTipoDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdTipoDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod Unid impl'}

function EntEdCastToProdUnidEnt(pEntEd: IEntEd): IProdUnidEnt;
begin
  Result := TProdUnidEnt(pEntEd);
end;

function EntDBICastToProdUnidDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdUnidDBI(pEntDBI);
end;

function RetagEstProdUnidEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdUnidEnt;
begin
  Result := TProdUnidEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;
begin
  Result := TProdUnidDBI.Create(pDBConnection, TProdUnidEnt(pProdUnidEnt));
end;

function ProdUnidEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnid: IEntEd; pProdUnidDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdUnidEdForm.Create(AOwner, pAppObj, pProdUnid, pProdUnidDBI);
end;

function ProdUnidPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdUnidEnt: IEntEd; pProdUnidDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdUnidEdFormCreate(AOwner, pAppObj, pProdUnidEnt, pProdUnidDBI);
  Result := F.Perg;
end;

// function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclUnid.Create(pProdUnid);
// end;

function ProdUnidDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdUnidDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod ICMS impl'}

function EntEdCastToProdICMSEnt(pEntEd: IEntEd): IProdICMSEnt;
begin
  Result := TProdICMSEnt(pEntEd);

end;

function EntDBICastToProdICMSDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TProdICMSDBI(pEntDBI);
end;

function RetagEstProdICMSEntCreate(pState: TDataSetState; pId: integer;
  pDescr: string): IProdICMSEnt;
begin
  Result := TProdICMSEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IEntEd): IEntDBI;
begin
  Result := TProdICMSDBI.Create(pDBConnection, pProdICMSEnt);
  // Result := TProdICMSDBI.Create(pDBConnection, TProdICMSEnt(pProdICMSEnt));
end;

function ProdICMSEdFormCreate(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMS: IEntEd; pProdICMSDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdICMSEdForm.Create(AOwner, pAppObj, pProdICMS, pProdICMSDBI);
end;

function ProdICMSPerg(AOwner: TComponent; pAppObj: IAppObj;
  pProdICMSEnt: IEntEd; pProdICMSDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdICMSEdFormCreate(AOwner, pAppObj, pProdICMSEnt, pProdICMSDBI);
  Result := F.Perg;
end;

// function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExclICMS.Create(pProdICMS);
// end;

function ProdICMSDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdICMSDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pAppObj);
end;

{$ENDREGION}
{$REGION 'prod impl'}

function RetagEstProdEdDBICreate(pDBConnection: IDBConnection)
  : IRetagEstProdEdDBI;
begin
  Result := TRetagEstProdEdDBI.Create(pDBConnection);
end;

function RetagEstProdEntCreate( //
  pLojaId: smallint; //
  pUsuarioId: integer; //
  pMachineIdentId: smallint; //
  //
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdTipoEnt: IProdTipoEnt; // fabr
  pProdUnidEnt: IProdUnidEnt; // fabr
  pProdICMSEnt: IProdICMSEnt; // fabr
  pProdBarrasList: IProdBarrasList; // prod barras list
  pProdBalancaEnt: IProdBalancaEnt; //
  // campos
  pState: TDataSetState; pId: integer; pDescr: string; pDescrRed: string)
  : IProdEnt;
begin

  Result := TProdEnt.Create(pLojaId, pUsuarioId, pMachineIdentId, pProdFabrEnt,
    pProdTipoEnt, pProdUnidEnt, pProdICMSEnt, pProdBarrasList, pProdBalancaEnt,
    pState, pId, pDescr, pDescrRed);
end;

function RetagEstProdDBICreate(pDBConnection: IDBConnection;
  pProdEnt: IEntEd): IEntDBI;
begin
  Result := TProdDBI.Create(pDBConnection, pProdEnt);
end;

function ProdEdFormCreate(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): TEdBasForm;
begin
  Result := TProdEdForm.Create(AOwner, pProdEnt, pProdDBI, pProdFabrDBI,
    pProdTipoDBI, pProdUnidDBI, pProdICMSDBI, pBarrasDBI,
    pFabrDataSetFormCreator, pProdTipoDataSetFormCreator,
    pProdUnidDataSetFormCreator, pProdICMSDataSetFormCreator, pAppObj,
    pRetagEstProdEdDBI, pUsuarioLog);
end;

function ProdPerg(AOwner: TComponent;
  //
  pProdEnt: IEntEd; pProdDBI: IEntDBI;

  //
  pProdFabrDBI: IEntDBI; //
  pProdTipoDBI: IEntDBI; //
  pProdUnidDBI: IEntDBI; //
  pProdICMSDBI: IEntDBI; //
  pBarrasDBI: IBarrasDBI; //

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;
  //
  pAppObj: IAppObj; //
  pRetagEstProdEdDBI: IRetagEstProdEdDBI; //
  pUsuarioLog: IUsuario): boolean;
var
  F: TEdBasForm;
begin
  F := ProdEdFormCreate(AOwner, pProdEnt, pProdDBI, pProdFabrDBI, pProdTipoDBI,
    pProdUnidDBI, pProdICMSDBI, pBarrasDBI, pFabrDataSetFormCreator,
    pProdTipoDataSetFormCreator, pProdUnidDataSetFormCreator,
    pProdICMSDataSetFormCreator, pAppObj, pRetagEstProdEdDBI, pUsuarioLog);
  Result := F.Perg;
end;

// function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;
// begin
// // Result := TDecoratorExcl.Create(pProd);
// end;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;
begin
  Result := TProdEnt(pEntEd);
end;

function ProdDataSetFormCreatorCreate(pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj): IFormCreator;
begin
  Result := TDataSetFormCreator.Create(TRetagEstProdDataSetForm,
    pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pAppObj);
end;

function ProdDataSetUltimoIdCreate(pQ: TDataSet): IUltimoId;
begin
  Result := TProdEdUltimoId.Create(pQ);
end;

{$ENDREGION}
{$REGION 'prod barras impl'}

function ProdBarrasCreate(pOrdem: smallint; pBarras: string): IProdBarras;
begin
  Result := TProdBarras.Create(pOrdem, pBarras);
end;

function ProdBarrasListCreate: IProdBarrasList;
begin
  Result := TProdBarrasList.Create;
end;

{$ENDREGION}
{$REGION 'prod balanca impl'}

function ProdBalancaEntCreate: IProdBalancaEnt;
begin
  Result := TProdBalancaEnt.Create;
end;
{$ENDREGION}
{$REGION 'xxx impl'}
{$ENDREGION}

end.
