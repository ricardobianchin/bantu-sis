unit App.Est.Venda.Caixa.CxValor;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxNumerario;

type
  ICxValor = interface(IInterface)
    ['{D3AD4003-DD21-4DC9-8A86-9EB4A9E229A9}']
    function GetPagamentoFormaId: TId;
    property PagamentoFormaId: TId read GetPagamentoFormaId;

    function GetValor: TPreco;
    property Valor: TPreco read GetValor;

    function PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;

    function GetCxNumerario(Index: integer): ICxNumerario;
    property CxNumerario[Index: integer]: ICxNumerario read GetCxNumerario; default;
  end;

implementation

end.
