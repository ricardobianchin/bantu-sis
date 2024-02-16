unit App.Retag.Est.Factory;

interface

uses Data.DB, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes, App.Ent.DBI,
  App.UI.Decorator.Form.Excl, App.UI.Form.Bas.Ed.Descr_u,
  App.Entidade.Ed.Id.Descr;

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

function DecoratorExclFabrCreate(pProdFabr: IEntIdDescr): IDecoratorExcl;

implementation

uses App.Retag.Est.Prod.Fabr_u, Vcl.Controls, App.Retag.Est.Prod.Fabr.DBI_u,
  App.Entidade.Ed.Id.Descr_u;

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

function DecoratorExclFabrCreate(pProdFabr: IEntIdDescr): IDecoratorExcl;
begin
//  Result := TDecoratorExclFabr.Create(pProdFabr);
end;

end.
