unit App.Est.Factory_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DB.DBTypes, System.Classes;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;

implementation

uses App.Est.Prod.Barras.DBI_u;

function AppEstBarrasDBICreate(pDBConnection: IDBConnection): IBarrasDBI;
begin
  Result := TBarrasDBI.Create(pDBConnection);
end;

end.
