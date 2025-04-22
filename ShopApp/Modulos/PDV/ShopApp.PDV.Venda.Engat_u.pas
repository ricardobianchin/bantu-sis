unit ShopApp.PDV.Venda.Engat_u;

interface

type
  TVendaProdEngat = record
    ProdId: integer;
    DescrRed: string;
    PrecoUnit: Currency;
    Qtd: Currency;
    BalancaExige: Boolean;
    function Preco: Currency;
    function GetStrBusca: string;
    function GetText: string;
    procedure PegarDe(pEngat: TVendaProdEngat);
    procedure Zerar;
  end;

implementation

uses System.Math, Sis.Types.Floats, System.SysUtils;

{ TVendaProdEngat }

function TVendaProdEngat.GetStrBusca: string;
begin
  Result := ProdId.ToString + '*' + CurrencyToStrPonto(Qtd);
end;

function TVendaProdEngat.GetText: string;
begin
  Result := ProdId.ToString + ' - ' + DescrRed;
end;

procedure TVendaProdEngat.PegarDe(pEngat: TVendaProdEngat);
begin
  ProdId := pEngat.ProdId;
  DescrRed := pEngat.DescrRed;
  PrecoUnit := pEngat.PrecoUnit;
  Qtd := pEngat.Qtd;
  BalancaExige := pEngat.BalancaExige;
end;

function TVendaProdEngat.Preco: Currency;
begin
  Result := RoundTo(Qtd * PrecoUnit, -2);
end;

procedure TVendaProdEngat.Zerar;
begin
  ProdId := 0;
  DescrRed := '';
  PrecoUnit := 0;
  Qtd := 0;
  BalancaExige := False;
end;

end.
