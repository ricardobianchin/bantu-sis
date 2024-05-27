unit App.Pess.Factory_u;

interface

uses App.Generos, Sis.DB.DBTypes, App.Pess.Ent;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;

implementation

uses App.Generos_u, App.Pess.Ent_u;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;
var
  s: string;
begin
  Result := TGeneros.Create;
end;

end.
