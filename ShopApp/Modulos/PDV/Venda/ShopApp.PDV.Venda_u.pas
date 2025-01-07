unit ShopApp.PDV.Venda_u;

interface

uses ShopApp.PDV.Venda, App.PDV.Venda_u, Sis.Entities.Types, App.Est.Types_u,
  Sis.Types, Sis.Sis.Constants, ShopApp.PDV.VendaItem;

type
  TShopPDVVenda = class(TPDVVenda, IShopPDVVenda)
  private
    function GetVendaItem(Index: integer): IShopPDVVendaItem;
  public
    procedure Zerar;
    property VendaItem[Index: integer]: IShopPDVVendaItem read GetVendaItem; default;
  end;

implementation

{ TShopPDVVenda }

function TShopPDVVenda.GetVendaItem(Index: integer): IShopPDVVendaItem;
begin
  Result := IShopPDVVendaItem(Items[Index]);
end;

procedure TShopPDVVenda.Zerar;
begin
  inherited;
  TerminalId := CaixaSessao.TerminalId;
end;

end.
