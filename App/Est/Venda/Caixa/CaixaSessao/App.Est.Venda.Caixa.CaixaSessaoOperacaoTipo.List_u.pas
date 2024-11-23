unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List_u;

interface

uses App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List, Sis.Lists.HashItemList_u,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  TCxOperacaoTipoList = class(THashItemList,
    ICxOperacaoTipoList)
  private
    function GetCxOperacaoTipo(Index: integer)
      : ICxOperacaoTipo;
  public
    property CxOperacaoTipo[Index: integer]: ICxOperacaoTipo
      read GetCxOperacaoTipo; default;
  end;

implementation

{ TCxOperacaoTipoList }

function TCxOperacaoTipoList.GetCxOperacaoTipo(
  Index: integer): ICxOperacaoTipo;
begin
  Result := ICxOperacaoTipo(Items[Index]);
end;

end.
