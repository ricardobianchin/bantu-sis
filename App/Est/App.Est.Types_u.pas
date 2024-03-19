unit App.Est.Types_u;

interface

uses System.Classes;

type
  TBalancaTipo = (baltNaoUtiliza, baltUtiliza, baltUsuPrecoTot,
    baltUsoPrecoUnitQtd);

const
  BalancaTipoStr: array[TBalancaTipo] of string = (
    'Não utiliza',
    'Utiliza',
    'Usuário indicará preço total',
    'Usuário indicará quantidade e preço unitário'
    );

procedure BalancaTipoStrToSL(pSL: TStrings);

implementation

procedure BalancaTipoStrToSL(pSL: TStrings);
var
  Tipo: TBalancaTipo;
begin
  pSL.Clear;

  for Tipo := Low(TBalancaTipo) to High(TBalancaTipo) do
    pSL.Add(BalancaTipoStr[Tipo]);
end;


end.
