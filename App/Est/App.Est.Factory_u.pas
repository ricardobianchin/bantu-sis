unit App.Est.Factory_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DB.DBTypes, System.Classes, App.Est.Prod,
  Sis.Types;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
function ProdCreate(pId: TId; pDescrRed, pFabrNome, pUnidSigla: string): IProd;

implementation

uses App.Est.Prod.Barras.DBI_u, App.Est.Prod_u;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
begin
  Result := TBarrasDBI.Create(pDBConnection);
end;

function ProdCreate(pId: TId; pDescrRed, pFabrNome, pUnidSigla: string): IProd;
begin
  Result := TProd.Create(pId, pDescrRed, pFabrNome, pUnidSigla);
end;

end.
