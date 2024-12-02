unit App.Est.Venda.Caixa.CxValor.DBI_u;

interface

uses App.Est.Venda.Caixa.CxValor.DBI, Sis.DBI_u, System.Generics.Collections;

type
  TCxValorDBI = class(TDBI, ICxValorDBI)
  private
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
  end;

implementation

uses Data.DB;

{ TCxValorDBI }

function TCxValorDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT VALOR FROM NUMERARIO_CORRENTE WHERE ATIVO ORDER BY VALOR DESC;';;
end;

end.
