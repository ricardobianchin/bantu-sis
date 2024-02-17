unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes, App.Ent.DBI,
  App.UI.Decorator.Form.Excl, App.UI.Form.Bas.Ed.Descr_u,
  App.Entidade.Ed.Id.Descr;

{$REGION 'prod fabr'}
  function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
    pDescr: string = ''): IEntIdDescr;

  function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
    pProdFabr: IEntIdDescr): IEntDBI;

  function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
    pState: TDataSetState; pProdFabr: IEntIdDescr; pProdFabrDBI: IEntDBI)
    : TEdDescrBasForm;

  function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
    pState: TDataSetState; pProdFabr: IEntIdDescr;
    pProdFabrDBI: IEntDBI): boolean;

  function DecoratorExclProdFabrCreate(pProdFabr: IEntIdDescr): IDecoratorExcl;

{$ENDREGION}
{$REGION 'prod tipo'}
  function RetagEstProdTipoCreate(pState: TDataSetState; pId: integer = 0;
    pDescr: string = ''): IEntIdDescr;

  function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
    pProdTipo: IEntIdDescr): IEntDBI;

  function ProdTipoEdFormCreate(AOwner: TComponent; pTitulo: string;
    pState: TDataSetState; pProdTipo: IEntIdDescr; pProdTipoDBI: IEntDBI)
    : TEdDescrBasForm;

  function ProdTipoPerg(AOwner: TComponent; pTitulo: string;
    pState: TDataSetState; pProdTipo: IEntIdDescr;
    pProdTipoDBI: IEntDBI): boolean;

  function DecoratorExclProdTipoCreate(pProdTipo: IEntIdDescr): IDecoratorExcl;

{$ENDREGION}

implementation

uses Vcl.Controls,
  App.Entidade.Ed.Id.Descr_u

  , App.Retag.Est.Prod.Fabr_u
  , App.Retag.Est.Prod.Tipo_u

  , App.Retag.Est.Prod.Fabr.DBI_u
  , App.Retag.Est.Prod.Tipo.DBI_u

  ;

{$REGION 'prod fabr impl'}
function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntIdDescr;
begin
  Result := TProdFabr.Create(pState, pId, pDescr);
end;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabr: IEntIdDescr): IEntDBI;
begin
  Result := TProdFabrDBI.Create(pDBConnection, pProdFabr);
end;

function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IEntIdDescr; pProdFabrDBI: IEntDBI)
  : TEdDescrBasForm;
begin
  Result := TEdDescrBasForm.Create(AOwner, pProdFabr, pProdFabrDBI);
end;

function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IEntIdDescr;
  pProdFabrDBI: IEntDBI): boolean;
var
  F: TEdDescrBasForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pTitulo, pState, pProdFabr, pProdFabrDBI);
  Result := F.Perg;
end;

function DecoratorExclProdFabrCreate(pProdFabr: IEntIdDescr): IDecoratorExcl;
begin
//  Result := TDecoratorExclFabr.Create(pProdFabr);
end;
{$ENDREGION}

{$REGION 'prod tipo impl'}
function RetagEstProdTipoCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IEntIdDescr;
begin
  Result := TProdTipo.Create(pState, pId, pDescr);
end;

function RetagEstProdTipoDBICreate(pDBConnection: IDBConnection;
  pProdTipo: IEntIdDescr): IEntDBI;
begin
  Result := TProdTipoDBI.Create(pDBConnection, pProdTipo);
end;

function ProdTipoEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdTipo: IEntIdDescr; pProdTipoDBI: IEntDBI)
  : TEdDescrBasForm;
begin
  Result := TEdDescrBasForm.Create(AOwner, pProdTipo, pProdTipoDBI);
end;

function ProdTipoPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdTipo: IEntIdDescr;
  pProdTipoDBI: IEntDBI): boolean;
var
  F: TEdDescrBasForm;
begin
  F := ProdTipoEdFormCreate(AOwner, pTitulo, pState, pProdTipo, pProdTipoDBI);
  Result := F.Perg;
end;

function DecoratorExclProdTIpoCreate(pProdTipo: IEntIdDescr): IDecoratorExcl;
begin
//  Result := TDecoratorExclFabr.Create(pProdTipo);
end;
{$ENDREGION}
end.
