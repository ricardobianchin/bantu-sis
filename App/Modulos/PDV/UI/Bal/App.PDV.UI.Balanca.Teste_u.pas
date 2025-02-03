unit App.PDV.UI.Balanca.Teste_u;

interface

uses App.PDV.UI.Balanca;

type
  TBalancaTeste = class(TInterfacedObject, IBalanca)
  private
  public
    procedure LePeso(out pPeso: Currency; out pDeuErro: Boolean;
      out pMens: string);
  end;

implementation

uses System.Math;

{ TBalancaTeste }

procedure TBalancaTeste.LePeso(out pPeso: Currency; out pDeuErro: Boolean;
  out pMens: string);
begin
  pPeso := RoundTo(Random(10000) / 1000, -3);
  pDeuErro := False;
end;

end.
