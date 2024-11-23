unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List;

interface

uses Sis.Lists.HashItemList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  ICxOperacaoTipoList = interface(IHashItemList)
    ['{947DB0B6-A760-4625-8DE4-0849E8A88CD3}']
    function GetCxOperacaoTipo(Index: integer)
      : ICxOperacaoTipo;
    property CxOperacaoTipo[Index: integer]: ICxOperacaoTipo
      read GetCxOperacaoTipo; default;
  end;

implementation

end.
