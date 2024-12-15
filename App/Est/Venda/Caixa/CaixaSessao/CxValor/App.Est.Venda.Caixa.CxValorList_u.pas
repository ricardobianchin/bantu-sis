unit App.Est.Venda.Caixa.CxValorList_u;

interface

uses App.Est.Venda.Caixa.CxValorList, Sis.Entities.Types,
  App.Est.Venda.Caixa.CxValor, System.Classes, Sis.Types,
  App.Types;

type
  TCxValorList = class(TInterfaceList, ICxValorList)
  private
    function GetCxValor(Index: integer): ICxValor;
  public
    function PegueCxValor(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;
    property CxValor[Index: integer]: ICxValor read GetCxValor;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u;

{ TCxValorList }

function TCxValorList.GetCxValor(Index: integer): ICxValor;
begin
  Result := ICxValor(Items[Index]);
end;

function TCxValorList.PegueCxValor(pPagamentoFormaId: TId;
  pValor: TPreco): ICxValor;
begin
  Result := CxValorCreate(pPagamentoFormaId, pValor);
  Add(Result);
end;

end.
