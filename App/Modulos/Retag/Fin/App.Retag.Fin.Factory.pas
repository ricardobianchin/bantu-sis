unit App.Retag.Fin.Factory;

interface

uses App.FIn.PagFormaTipo, App.Ent.Ed, App.Ent.DBI;

function PagFormaTipoCreate: IPagFormaTipo;
function EntEdCastToFormaTipoEnt(pEntEd: IEntEd): IPagFormaTipo;
function EntDBICastToFormaTipoDBI(pEntDBI: IEntDBI): IEntDBI;

implementation

uses App.FIn.PagFormaTipo_u, App.Retag.Fin.PagForma.DBI_u;

function PagFormaTipoCreate: IPagFormaTipo;
begin
  Result := TPagFormaTipo.Create();
end;

function EntEdCastToFormaTipoEnt(pEntEd: IEntEd): IPagFormaTipo;
begin
  Result := TPagFormaTipo(pEntEd);
end;

function EntDBICastToFormaTipoDBI(pEntDBI: IEntDBI): IEntDBI;
begin
  Result := TPagFormaDBI(pEntDBI);
end;

end.
