unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo_u;

interface

uses Sis.Lists.IdCharHashItem_u, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  TCxOperacaoTipo = class(TIdCharHashItem, ICxOperacaoTipo)
  private
    FHabilitadoDuranteSessao: Boolean;

    procedure SetHabilitadoDuranteSessao(Value: Boolean);
    function GetHabilitadoDuranteSessao: Boolean;
  public
    property HabilitadoDuranteSessao: Boolean read GetHabilitadoDuranteSessao write SetHabilitadoDuranteSessao;
    constructor Create(pId: string; pCaption: string;  pHabilitadoDuranteSessao: Boolean);
  end;

implementation

{ TCxOperacaoTipo }

constructor TCxOperacaoTipo.Create(pId: string; pCaption: string;  pHabilitadoDuranteSessao: Boolean);
begin
  inherited Create(pCaption, pId);
  FHabilitadoDuranteSessao := pHabilitadoDuranteSessao;
end;

function TCxOperacaoTipo.GetHabilitadoDuranteSessao: Boolean;
begin
  Result := FHabilitadoDuranteSessao;
end;

procedure TCxOperacaoTipo.SetHabilitadoDuranteSessao(Value: Boolean);
begin
  FHabilitadoDuranteSessao := Value;
end;

end.
