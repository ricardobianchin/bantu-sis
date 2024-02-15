unit App.Retag.Est.Factory;

interface

uses App.Retag.Est.Prod.Fabr, Data.DB, App.UI.Form.Ed.Retag.Prod.Fabr_u,
  Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes,
  App.Retag.Est.Prod.Fabr.DBI, App.UI.Decorator.Form.Excl;

function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IProdFabr;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabr: IProdFabr): IProdFabrDBI;

function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr; pProdFabrDBI: IProdFabrDBI)
  : TProdFabrEdForm;

function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr;
  pProdFabrDBI: IProdFabrDBI): boolean;

function DecoratorExclFabrCreate(pProdFabr: IProdFabr): IDecoratorExcl;

implementation

uses App.Retag.Est.Prod.Fabr_u, Vcl.Controls, App.Retag.Est.Prod.Fabr.DBI_u,
  App.UI.Decorator.Form.Excl.Fabr_u;

function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IProdFabr;
begin
  Result := TProdFabr.Create(pState, pId, pDescr);
end;

function RetagEstProdFabrDBICreate(pDBConnection: IDBConnection;
  pProdFabr: IProdFabr): IProdFabrDBI;
begin
  Result := TProdFabrDBI.Create(pDBConnection, pProdFabr);
end;

function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr; pProdFabrDBI: IProdFabrDBI)
  : TProdFabrEdForm;
begin
  Result := TProdFabrEdForm.Create(AOwner, pTitulo, pState, pProdFabr,
    pProdFabrDBI);
end;

function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr;
  pProdFabrDBI: IProdFabrDBI): boolean;
var
  F: TProdFabrEdForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pTitulo, pState, pProdFabr, pProdFabrDBI);
  Result := F.Perg;
end;

function DecoratorExclFabrCreate(pProdFabr: IProdFabr): IDecoratorExcl;
begin
  Result := TDecoratorExclFabr.Create(pProdFabr);
end;

end.
