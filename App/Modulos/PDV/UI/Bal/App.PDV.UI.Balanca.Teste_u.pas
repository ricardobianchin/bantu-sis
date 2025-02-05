unit App.PDV.UI.Balanca.Teste_u;

interface

uses App.PDV.UI.Balanca;

type
  TBalancaTeste = class(TInterfacedObject, IBalanca)
  private
  public
    procedure LePeso(out pPeso: string; out pDeuErro: Boolean;
      out pMens: string);
  end;

implementation

uses System.Math, System.SysUtils;

{ TBalancaTeste }

procedure TBalancaTeste.LePeso(out pPeso: string; out pDeuErro: Boolean;
  out pMens: string);
var
  p: Currency;
begin
  p := RoundTo(Random(10000) / 1000, -3);
  pPeso := FormatFloat('#####0.000', p);
  pDeuErro := False;
end;

end.
