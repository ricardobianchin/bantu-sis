unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes,
  App.UI.Decorator.Form.Excl, App.UI.Form.Bas.Ed_u

  // os dbi que seguem o padrao, retornam iented
    , App.Ent.Ed, App.Ent.DBI

  // os dbi que nao seguem o padrao, deves ser citados aqui
    , App.Retag.Est.Prod.ICMS.Ent // icms ent
    , App.Retag.Est.Prod.ICMS.DBI // icms dbi

    , App.Retag.Est.Prod.Ent // prod ent
    , App.Retag.Est.Prod.DBI // prod dbi

    , App.Retag.Est.Prod.Fabr.Ent // fabr ent

    , App.Retag.Est.Prod.Natu.Ent // ProdNatu ent

    ;

{$REGION 'prod fabr'}
function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = 'NAO INDICADO'): IProdFabrEnt;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;

function ProdFabrEdFormCreate(AOwner: TComponent; pProdFabr: IEntEd;
  pProdFabrDBI: IEntDBI): TEdBasForm;

function ProdFabrPerg(AOwner: TComponent; pProdFabrEnt: IEntEd;
  pProdFabrDBI: IEntDBI): boolean;

function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

{$ENDREGION}
{$REGION 'prod tipo'}
function RetagEstProdTipoEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;

function ProdTipoEdFormCreate(AOwner: TComponent; pProdTipo: IEntEd;
  pProdTipoDBI: IEntDBI): TEdBasForm;

function ProdTipoPerg(AOwner: TComponent; pProdTipoEnt: IEntEd;
  pProdTipoDBI: IEntDBI): boolean;

function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;
{$ENDREGION}
{$REGION 'prod unid'}
function RetagEstProdUnidEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;

function ProdUnidEdFormCreate(AOwner: TComponent; pProdUnid: IEntEd;
  pProdUnidDBI: IEntDBI): TEdBasForm;

function ProdUnidPerg(AOwner: TComponent; pProdUnidEnt: IEntEd;
  pProdUnidDBI: IEntDBI): boolean;

function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;
{$ENDREGION}
{$REGION 'prod ICMS'}
function RetagEstProdICMSEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IProdICMSEnt): IProdICMSDBI;

function ProdICMSEdFormCreate(AOwner: TComponent; pProdICMS: IEntEd;
  pProdICMSDBI: IEntDBI): TEdBasForm;

function ProdICMSPerg(AOwner: TComponent; pProdICMSEnt: IEntEd;
  pProdICMSDBI: IEntDBI): boolean;

function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;
{$ENDREGION}
{$REGION 'prod'}
function RetagEstProdEntCreate(pState: TDataSetState;
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdNatuEnt: IProdNatuEnt; // est_item_natu
  // campos
  pId: integer = 0; pDescr: string = ''; pDescrRed: string = ''): IEntEd;

function RetagEstProdDBICreate(pDBConnection: IDBConnection; pProdEnt: IProdEnt)
  : IProdDBI;

function ProdEdFormCreate(AOwner: TComponent; pProd: IEntEd; pProdDBI: IEntDBI)
  : TEdBasForm;

function ProdPerg(AOwner: TComponent; pProdEnt: IEntEd;
  pProdDBI: IEntDBI): boolean;

function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;
{$ENDREGION}
{$REGION 'prod Natu'}
function RetagEstProdNatuEntCreate(pId: char = #0;
  pDescr: string = 'NAO INDICADO'): IProdNatuEnt;

{$ENDREGION}

implementation

uses Vcl.Controls

  // fabr
    , App.Retag.Est.Prod.Fabr.Ent_u // fabr ent
    , App.Retag.Est.Prod.Fabr.DBI_u // fabr dbi
    , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form

  // tipo
    , App.Retag.Est.Prod.Tipo.Ent_u // tipo ent
    , App.Retag.Est.Prod.Tipo.DBI_u // tipo dbi
    , App.UI.Form.Ed.Prod.Tipo_u // tipo ed form

  // unid
    , App.Retag.Est.Prod.Unid.Ent_u // ent
    , App.Retag.Est.Prod.Unid.DBI_u // unid dbi
    , App.UI.Form.Ed.Prod.Unid_u // Unid ed form

  // icms
    , App.Retag.Est.Prod.ICMS.Ent_u // icms ent
    , App.Retag.Est.Prod.ICMS.DBI_u // icms dbi
    , App.UI.Form.Ed.Prod.ICMS_u // icms ed form

  // prod
    , App.Retag.Est.Prod.Ent_u // prod ent
    , App.Retag.Est.Prod.DBI_u // prod dbi
    , App.UI.Form.Ed.Prod_u // prod ed form

  // natu
    , App.Retag.Est.Prod.Natu.Ent_u // natu ent
    ;

{$REGION 'prod fabr impl'}

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

function ProdFabrEdFormCreate(AOwner: TComponent; pProdFabr: IEntEd;
  pProdFabrDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdFabrEdForm.Create(AOwner, pProdFabr, pProdFabrDBI);
end;

function ProdFabrPerg(AOwner: TComponent; pProdFabrEnt: IEntEd;
  pProdFabrDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pProdFabrEnt, pProdFabrDBI);
  Result := F.Perg;
end;

function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;
begin
  // Result := TDecoratorExclFabr.Create(pProdFabr);
end;
{$ENDREGION}
{$REGION 'prod tipo impl'}

function RetagEstProdTipoEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;
begin
  Result := TProdTipoEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipoEnt: IEntEd): IEntDBI;
begin
  Result := TProdTipoDBI.Create(pDBConnection, TProdTipoEnt(pProdTipoEnt));
end;

function ProdTipoEdFormCreate(AOwner: TComponent; pProdTipo: IEntEd;
  pProdTipoDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdTipoEdForm.Create(AOwner, pProdTipo, pProdTipoDBI);
end;

function ProdTipoPerg(AOwner: TComponent; pProdTipoEnt: IEntEd;
  pProdTipoDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdTipoEdFormCreate(AOwner, pProdTipoEnt, pProdTipoDBI);
  Result := F.Perg;
end;

function DecoratorExclProdTipoCreate(pProdTipo: IEntEd): IDecoratorExcl;
begin
  // Result := TDecoratorExclTipo.Create(pProdTipo);
end;
{$ENDREGION}
{$REGION 'prod Unid impl'}

function RetagEstProdUnidEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;
begin
  Result := TProdUnidEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdUnidDBICreate(pDBConnection: IDBConnection;
  pProdUnidEnt: IEntEd): IEntDBI;
begin
  Result := TProdUnidDBI.Create(pDBConnection, TProdUnidEnt(pProdUnidEnt));
end;

function ProdUnidEdFormCreate(AOwner: TComponent; pProdUnid: IEntEd;
  pProdUnidDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdUnidEdForm.Create(AOwner, pProdUnid, pProdUnidDBI);
end;

function ProdUnidPerg(AOwner: TComponent; pProdUnidEnt: IEntEd;
  pProdUnidDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdUnidEdFormCreate(AOwner, pProdUnidEnt, pProdUnidDBI);
  Result := F.Perg;
end;

function DecoratorExclProdUnidCreate(pProdUnid: IEntEd): IDecoratorExcl;
begin
  // Result := TDecoratorExclUnid.Create(pProdUnid);
end;
{$ENDREGION}
{$REGION 'prod ICMS impl'}

function RetagEstProdICMSEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;
begin
  Result := TProdICMSEnt.Create(pState, pId, pDescr);
end;

function RetagEstProdICMSDBICreate(pDBConnection: IDBConnection;
  pProdICMSEnt: IProdICMSEnt): IProdICMSDBI;
begin
  Result := TProdICMSDBI.Create(pDBConnection, pProdICMSEnt);
  // Result := TProdICMSDBI.Create(pDBConnection, TProdICMSEnt(pProdICMSEnt));
end;

function ProdICMSEdFormCreate(AOwner: TComponent; pProdICMS: IEntEd;
  pProdICMSDBI: IEntDBI): TEdBasForm;
begin
  Result := TProdICMSEdForm.Create(AOwner, pProdICMS, pProdICMSDBI);
end;

function ProdICMSPerg(AOwner: TComponent; pProdICMSEnt: IEntEd;
  pProdICMSDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdICMSEdFormCreate(AOwner, pProdICMSEnt, pProdICMSDBI);
  Result := F.Perg;
end;

function DecoratorExclProdICMSCreate(pProdICMS: IEntEd): IDecoratorExcl;
begin
  // Result := TDecoratorExclICMS.Create(pProdICMS);
end;
{$ENDREGION}
{$REGION 'prod impl'}

function RetagEstProdEntCreate(pState: TDataSetState;
  // entidades
  pProdFabrEnt: IProdFabrEnt; // fabr
  pProdNatuEnt: IProdNatuEnt; // est_item_natu
  // campos
  pId: integer; pDescr: string; pDescrRed: string): IEntEd;
begin
  Result := TProdEnt.Create(pState, pProdFabrEnt, pProdNatuEnt, pId, pDescr,
    pDescrRed);
end;

function RetagEstProdDBICreate(pDBConnection: IDBConnection; pProdEnt: IProdEnt)
  : IProdDBI;
begin
  Result := TProdDBI.Create(pDBConnection, pProdEnt);
end;

function ProdEdFormCreate(AOwner: TComponent; pProd: IEntEd; pProdDBI: IEntDBI)
  : TEdBasForm;
begin
  Result := TProdEdForm.Create(AOwner, pProd, pProdDBI);
end;

function ProdPerg(AOwner: TComponent; pProdEnt: IEntEd;
  pProdDBI: IEntDBI): boolean;
var
  F: TEdBasForm;
begin
  F := ProdEdFormCreate(AOwner, pProdEnt, pProdDBI);
  Result := F.Perg;
end;

function DecoratorExclProdCreate(pProd: IEntEd): IDecoratorExcl;
begin
  // Result := TDecoratorExcl.Create(pProd);
end;

function EntEdCastToProdEnt(pEntEd: IEntEd): IProdEnt;
begin
  Result := TProdEnt(pEntEd);
end;
{$ENDREGION}
{$REGION 'prod Natu impl'}

function RetagEstProdNatuEntCreate(pId: char; pDescr: string): IProdNatuEnt;
begin
  Result := TProdNatuEnt.Create(pId, pDescr);
end;

{$ENDREGION}

end.
