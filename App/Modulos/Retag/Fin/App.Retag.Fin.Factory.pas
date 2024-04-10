unit App.Retag.Fin.Factory;

interface

uses App.FIn.PagFormaTipo;

function PagFormaTipoCreate: IPagFormaTipo;

implementation

uses App.FIn.PagFormaTipo_u;

function PagFormaTipoCreate: IPagFormaTipo;
begin
  Result := TPagFormaTipo.Create();
end;

end.
