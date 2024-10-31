unit Sis.DB.DBConfig.Factory_u;

interface

uses Sis.DB.DBConfigDBI, Sis.DB.DBTypes;

function DBConfigDBICreate(pDBConnection: IDBConnection): IDBConfigDBI;

implementation

uses Sis.DB.DBConfigDBI_u;

function DBConfigDBICreate(pDBConnection: IDBConnection): IDBConfigDBI;
begin
  Result := TDBConfigDBI.Create(pDBConnection);
end;

end.
