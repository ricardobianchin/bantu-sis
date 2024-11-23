unit App.Est.Factory_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DB.DBTypes, System.Classes,
  Sis.Entities.Types;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;

implementation

uses App.Est.Prod.Barras.DBI_u, App.Est.Venda.CaixaSessao.DBI_u;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
begin
  Result := TBarrasDBI.Create(pDBConnection);
end;

end.
