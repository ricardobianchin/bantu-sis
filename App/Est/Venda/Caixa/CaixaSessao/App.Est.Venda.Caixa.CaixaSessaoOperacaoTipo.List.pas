unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List;

interface

uses Sis.Lists.IdCharHashList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  ICxOperacaoTipoList = interface(IIdCharHashList)
    ['{947DB0B6-A760-4625-8DE4-0849E8A88CD3}']
    function GetCxOperacaoTipo(Index: integer)
      : ICxOperacaoTipo;
    property CxOperacaoTipo[Index: integer]: ICxOperacaoTipo
      read GetCxOperacaoTipo; default;
  end;

implementation

end.
