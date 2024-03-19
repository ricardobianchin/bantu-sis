unit App.Est.Types_u;

interface

uses System.Classes;

type
  TBalancaTipo = (baltNaoUtiliza, baltUtiliza, baltUsuPrecoTot,
    baltUsoPrecoUnitQtd);

const
  BalancaTipoStr: array[TBalancaTipo] of string = (
    'N�o utiliza',
    'Utiliza',
    'Usu�rio indicar� pre�o total',
    'Usu�rio indicar� quantidade e pre�o unit�rio'
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
