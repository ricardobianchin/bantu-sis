unit App.Est.Types_u;

interface

uses System.Classes;

type
  TBalancaUso = (baltNaoUtiliza, baltUtiliza, baltUsuPrecoTot,
    baltUsoPrecoUnitQtd);

//  TProdNatu = (pnatuNaoIndicado = 32, pnatuProduto = 33, pnatuServico = 34,
//    pnatuMateriaPrima = 35, pnatuCombo = 36, pnatuComposto = 37);

const
  BalancaUsoStr: array [TBalancaUso] of string = (
    'Não utiliza'//
    , 'Utiliza'//
    , 'Usuário indicará preço total'//
    , 'Usuário indicará quantidade e preço unitário'//
    );
//
//  ProdNatuStr: array [TProdNatu] of string = (
//    'Não indicado'//
//    , 'Produto'//
//    , 'Serviço'//
//    , 'Matéria-Prima'//
//    , 'Combo'//
//    , 'Composto'//
//    );

procedure BalancaUsoStrToSL(pSL: TStrings);
//function ProdNatuToChar(pProdNatu: TProdNatu): char;
//function ProdNatuToSql(pProdNatu: TProdNatu): string;

implementation

uses System.SysUtils;

procedure BalancaUsoStrToSL(pSL: TStrings);
var
  Tipo: TBalancaUso;
begin
  pSL.Clear;

  for Tipo := Low(TBalancaUso) to High(TBalancaUso) do
    pSL.Add(BalancaUsoStr[Tipo]);
end;

//function ProdNatuToChar(pProdNatu: TProdNatu): char;
//begin
//  Result := Chr(Integer(pProdNatu));
//end;
//
//function ProdNatuToSql(pProdNatu: TProdNatu): string;
//begin
//  Result := QuotedStr(ProdNatuToChar(pProdNatu));
//end;


end.
