unit App.Est.Venda.Caixa.CxValorList;

interface

uses Sis.Entities.Types, App.Est.Venda.Caixa.CxValor, System.Classes, Sis.Types,
  App.Types;

type
  ICxValorList = interface(IInterfaceList)
    ['{92529648-34C4-4232-B07F-7EE93969276C}']
    function PegueCxValor(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;
    function GetCxValor(Index: integer): ICxValor;
    property CxValor[Index: integer]: ICxValor read GetCxValor;
  end;

implementation

end.
