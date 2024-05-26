unit App.Pess.Factory_u;

interface

uses App.Generos, Sis.DB.DBTypes;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;

implementation

uses App.Generos_u;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;
var
  s: string;
begin

  Result := TGeneros.Create;
end;

end.
