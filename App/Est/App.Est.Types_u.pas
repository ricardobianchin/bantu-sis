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
function ProdNatuToChar(pProdNatu: TProdNatu): char;
function ProdNatuToSql(pProdNatu: TProdNatu): string;

implementation

uses System.SysUtils;

procedure BalancaTipoStrToSL(pSL: TStrings);
var
  Tipo: TBalancaTipo;
begin
  pSL.Clear;

  for Tipo := Low(TBalancaTipo) to High(TBalancaTipo) do
    pSL.Add(BalancaTipoStr[Tipo]);
end;

function ProdNatuToChar(pProdNatu: TProdNatu): char;
begin
  Result := Chr(Integer(pProdNatu));
end;

function ProdNatuToSql(pProdNatu: TProdNatu): string;
begin
  Result := QuotedStr(ProdNatuToChar(pProdNatu));
end;


end.
