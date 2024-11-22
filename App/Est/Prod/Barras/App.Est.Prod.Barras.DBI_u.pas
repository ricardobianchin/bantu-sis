unit App.Est.Prod.Barras.DBI_u;

interface

uses App.Est.Prod.Barras.DBI, Sis.DBI_u;

type
  TBarrasDBI = class(TDBI, IBarrasDBI)
  private
  public
    function CodBarrasToProdId(pCodBarras: string;
      pProdIdExceto: integer): integer;
  end;

implementation

{ TBarrasDBI }

uses App.Est.Prod.Barras.GetSQL_u, Sis.DB.DBTypes, Sis.DB.Factory, System.SysUtils;

function TBarrasDBI.CodBarrasToProdId(pCodBarras: string;
  pProdIdExceto: integer): integer;
var
  sFormat: string;
  sSql: string;
  Resultado: variant;
  sResultado: string;
  iProdId: integer;
begin
  Result := 0;
  sFormat := GetSQLBarrasExisteFormat;
  sSql := Format(sFormat, [pCodBarras, pProdIdExceto]);

  DBConnection.Abrir;
  try
    Result := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
  end;
end;

end.
