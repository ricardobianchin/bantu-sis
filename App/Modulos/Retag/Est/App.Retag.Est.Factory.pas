unit App.Retag.Est.Factory;

interface

uses App.Retag.Est.Prod.Fabr, Data.DB, App.UI.Form.Ed.Retag.Prod.Fabr_u,
  System.Classes, App.Retag.Est.Prod.Fabr.DBI;

function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IProdFabr;

function dbi create

function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr): TProdFabrEdForm;

function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr): boolean;

implementation

uses App.Retag.Est.Prod.Fabr_u, Vcl.Controls, App.Retag.Est.Prod.Fabr.DB;

function RetagEstProdFabrCreate(pState: TDataSetState; pId: integer = 0;
  pDescr: string = ''): IProdFabr;
begin
  Result := TProdFabr.Create(pState, pId, pDescr);
end;

function ProdFabrEdFormCreate(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr): TProdFabrEdForm;
begin
  Result := TProdFabrEdForm.Create(AOwner, pTitulo, pState, pProdFabr);
end;

function ProdFabrPerg(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr): boolean;
var
  F: TProdFabrEdForm;
begin
  F := ProdFabrEdFormCreate(AOwner, pTitulo, pState, pProdFabr);
  Result := F.Perg;
end;

end.
