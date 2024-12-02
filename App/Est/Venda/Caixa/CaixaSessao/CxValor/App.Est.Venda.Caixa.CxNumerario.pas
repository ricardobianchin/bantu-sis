unit App.Est.Venda.Caixa.CxNumerario;

interface

uses Sis.Types, App.Types;

type
  ICxNumerario = interface(IInterface)
    ['{53AA1A76-FB36-4499-87D6-B9249B1BB5FD}']
    function GetValor: TPreco;
    property Valor: TPreco read GetValor;

    function GetQtd: SmallInt;
    property Qtd: SmallInt read GetQtd;
  end;

implementation

end.
