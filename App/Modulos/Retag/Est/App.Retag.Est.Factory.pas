unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes, App.Ent.DBI,
  App.UI.Decorator.Form.Excl, App.UI.Form.Bas.Ed_u, App.Ent.Ed;

{$REGION 'prod fabr'}
function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabrEnt: IEntEd): IEntDBI;

function ProdFabrEdFormCreate(AOwner: TComponent; pProdFabr: IEntEd;
  pProdFabrDBI: IEntDBI): TEdBasForm;

function ProdFabrPerg(AOwner: TComponent; pProdFabrEnt: IEntEd;
  pProdFabrDBI: IEntDBI): boolean;

function DecoratorExclProdFabrCreate(pProdFabr: IEntEd): IDecoratorExcl;

{$ENDREGION}
{$REGION 'prod tipo'}
// function RetagEstProdTipoCreate(pState: TDataSetState; pId: integer = 0;
// pDescr: string = ''): IEntIdDescr;
//
// function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
// pProdTipo: IEntIdDescr): IEntDBI;
//
// function ProdTipoEdFormCreate(AOwner: TComponent; pTitulo: string;
// pState: TDataSetState; pProdTipo: IEntIdDescr; pProdTipoDBI: IEntDBI)
// : TEdDescrBasForm;
//
// function ProdTipoPerg(AOwner: TComponent; pTitulo: string;
// pState: TDataSetState; pProdTipo: IEntIdDescr;
// pProdTipoDBI: IEntDBI): boolean;
//
// function DecoratorExclProdTipoCreate(pProdTipo: IEntIdDescr): IDecoratorExcl;

{$ENDREGION}

implementation

uses Vcl.Controls

  // fabr

    , App.Retag.Est.Prod.Fabr.Ent_u // fabr ent
    , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form

  // , App.Retag.Est.Prod.Tipo_u

    , App.Retag.Est.Prod.Fabr.DBI_u
  // , App.Retag.Est.Prod.Tipo.DBI_u

    ;

{$REGION 'prod fabr impl'}

function RetagEstProdFabrEntCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntEd;
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
// function RetagEstProdTipoCreate(pState: TDataSetState; pId: integer = 0;
// pDescr: string = ''): IEntIdDescr;
// begin
// Result := TProdTipo.Create(pState, pId, pDescr);
// end;
//
// function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
// pProdTipo: IEntIdDescr): IEntDBI;
// begin
// Result := TProdTipoDBI.Create(pDBConnection, pProdTipo);
// end;
//
// function ProdTipoEdFormCreate(AOwner: TComponent; pTitulo: string;
// pState: TDataSetState; pProdTipo: IEntIdDescr; pProdTipoDBI: IEntDBI)
// : TEdDescrBasForm;
// begin
// Result := TEdDescrBasForm.Create(AOwner, pProdTipo, pProdTipoDBI);
// end;
//
// function ProdTipoPerg(AOwner: TComponent; pTitulo: string;
// pState: TDataSetState; pProdTipo: IEntIdDescr;
// pProdTipoDBI: IEntDBI): boolean;
// var
// F: TEdDescrBasForm;
// begin
// F := ProdTipoEdFormCreate(AOwner, pTitulo, pState, pProdTipo, pProdTipoDBI);
// Result := F.Perg;
// end;
//
// function DecoratorExclProdTIpoCreate(pProdTipo: IEntIdDescr): IDecoratorExcl;
// begin
/// /  Result := TDecoratorExclFabr.Create(pProdTipo);
// end;
{$ENDREGION}

end.
