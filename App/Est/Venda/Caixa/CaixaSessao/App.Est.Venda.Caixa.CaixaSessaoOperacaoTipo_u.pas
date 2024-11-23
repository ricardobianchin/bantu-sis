unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo_u;

interface

uses Sis.Lists.HashItem_u, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  TCxOperacaoTipo = class(THashItem, ICxOperacaoTipo)
  private
    Fabilitado: Boolean;

    procedure SetHabilitado(Value: Boolean);
    function GetHabilitado: Boolean;
  public
    property Habilitado: Boolean read GetHabilitado write SetHabilitado;
  end;


implementation

{ TCxOperacaoTipo }

function TCxOperacaoTipo.GetHabilitado: Boolean;
begin
  Result := Fabilitado;
end;

procedure TCxOperacaoTipo.SetHabilitado(Value: Boolean);
begin
  Fabilitado := Value;
end;

end.
