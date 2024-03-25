unit App.Est.Prod.Barras.DBI_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DBI_u;

type
  TBarrasDBI = class(TDBI, IBarrasDBI)
  private
  public
    function BarrasExiste(pBarras: string; pProdIdExceto: integer): boolean;
  end;

implementation

{ TBarrasDBI }

function TBarrasDBI.BarrasExiste(pBarras: string;
  pProdIdExceto: integer): boolean;
begin

end;

end.
