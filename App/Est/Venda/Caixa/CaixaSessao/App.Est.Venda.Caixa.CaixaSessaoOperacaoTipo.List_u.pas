unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List_u;

interface

uses App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.List,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

type
  TCxOperacaoTipoList = class(TInterfaceList, ICxOperacaoTipoList)
  private
    function GetCxOperacaoTipo(Index: integer): ICxOperacaoTipo;
  public
    property CxOperacaoTipo[Index: integer]: ICxOperacaoTipo
      read GetCxOperacaoTipo; default;
    function CxOpTipoToOperacaoTipo(pCxOpTipo: TCxOpTipo): ICxOperacaoTipo;
  end;

implementation

{ TCxOperacaoTipoList }

function TCxOperacaoTipoList.CxOpTipoToOperacaoTipo(pCxOpTipo: TCxOpTipo)
  : ICxOperacaoTipo;
var
  ot: ICxOperacaoTipo;
  i: integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
  begin
    ot := CxOperacaoTipo[i];
    if ot.Id = pCxOpTipo then
    begin
      Result := ot;
      break;
    end;
  end;
end;

function TCxOperacaoTipoList.GetCxOperacaoTipo(Index: integer): ICxOperacaoTipo;
begin
  Result := ICxOperacaoTipo(Items[Index]);
end;

end.
