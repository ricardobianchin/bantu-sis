unit App.Est.Types_u;

interface

uses System.Classes;

type
  TBalancaTipo = (baltNaoUtiliza, baltUtiliza, baltUsuPrecoTot,
    baltUsoPrecoUnitQtd);

  TProdNatu = (pnatuNaoIndicado = 32, pnatuProduto = 33, pnatuServico = 34,
    pnatuMateriaPrima = 35, pnatuCombo = 36, pnatuComposto = 37);

const
  BalancaTipoStr: array [TBalancaTipo] of string = (
    'Não utiliza'//
    , 'Utiliza'//
    , 'Usuário indicará preço total'//
    , 'Usuário indicará quantidade e preço unitário'//
    );

  ProdNatuStr: array [TProdNatu] of string = (
    'Não indicado'//
    , 'Produto'//
    , 'Serviço'//
    , 'Matéria-Prima'//
    , 'Combo'//
    , 'Composto'//
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
