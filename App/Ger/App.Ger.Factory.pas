unit App.Ger.Factory;

interface

uses App.Ger.GerForm.DBI, Sis.DB.DBTypes, App.DB.Utils, Sis.Sis.Constants,
  Sis.DB.DBConfigDBI;

function GerFormDBICreate(pDBConnection: IDBConnection; pDBConfigDBI: IDBConfigDBI): IGerFormDBI;

implementation

uses App.Ger.GerForm.DBI_u;

function GerFormDBICreate(pDBConnection: IDBConnection; pDBConfigDBI: IDBConfigDBI): IGerFormDBI;
begin
  Result := TGerFormDBI.Create(pDBConnection, pDBConfigDBI);
end;

end.
