unit App.Retag.Est.Custo_u;

interface

uses App.Retag.Est.Custo;

type
  TCusto = class(TInterfacedObject, ICusto)
  private
  public
    function GetCustoAtual(pProdId: integer): double;
  end;

implementation

{ TCusto }

function TCusto.GetCustoAtual(pProdId: integer): double;
begin
  Result := 0;
end;

end.
