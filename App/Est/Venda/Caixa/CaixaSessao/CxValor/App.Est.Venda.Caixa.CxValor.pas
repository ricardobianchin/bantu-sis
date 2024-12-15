unit App.Est.Venda.Caixa.CxValor;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxNumerarioList;

type
  ICxValor = interface(IInterface)
    ['{D3AD4003-DD21-4DC9-8A86-9EB4A9E229A9}']
    function GetPagamentoFormaId: TId;
    property PagamentoFormaId: TId read GetPagamentoFormaId;

    function GetValor: TPreco;
    property Valor: TPreco read GetValor;

    function GetCxNumerarioList: ICxNumerarioList;
    property CxNumerarioList: ICxNumerarioList read GetCxNumerarioList;
  end;

implementation

end.
