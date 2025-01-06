unit ShopApp.PDV.VendaItem_u;

interface

uses App.PDV.VendaItem_u, ShopApp.PDV.VendaItem;

type
  TShopPDVVendaItem = class(TPDVVendaItem, IShopPDVVendaItem)
  private
    function GetAsLinha1: string;
    function GetAsLinha2: string;
    function GetAsLinha3: string;

    property AsLinha1: string read GetAsLinha1;
    property AsLinha2: string read GetAsLinha2;
    property AsLinha3: string read GetAsLinha3;
  protected
    function GetAsStringFita: string; override;
  public
  end;

implementation

uses Sis.Types.Bool_u, Sis.Types.Floats, System.Math, System.SysUtils;
{ TShopPDVVendaItem }

function TShopPDVVendaItem.GetAsLinha1: string;
begin
  Result := Prod.IdAsStrZero + '  ' + Prod.DescrRed;
end;

function TShopPDVVendaItem.GetAsLinha2: string;
var
  sQtd: string;
  sPrecoUnit: string;
  sPreco: string;
  sDesconto: string;
begin
  sQtd := FormatFloat('###,##0.###', Qtd);
  sPrecoUnit := DinhToStr(PrecoUnit);
  sPreco := DinhToStr(Preco);
  sDesconto := DinhToStr(Desconto);

  Result := ' ' + sQtd //
    + ' ' + Prod.UnidSigla //
    + ' x ' + sPrecoUnit //
    ;

  if Desconto >= 0.01 then
  begin
    Result := Result + ' - ' + sDesconto;
  end;

  Result := Result + ' = ' + sPreco;
end;

function TShopPDVVendaItem.GetAsLinha3: string;
begin
  Result := Iif(Cancelado, '     C A N C E L A D O', '');
end;

function TShopPDVVendaItem.GetAsStringFita: string;
begin
  Result := //
    GetAsLinha1 + #13#10 //
    + GetAsLinha2 + #13#10 //
    + GetAsLinha3 + #13#10 //
    ;
end;

end.
