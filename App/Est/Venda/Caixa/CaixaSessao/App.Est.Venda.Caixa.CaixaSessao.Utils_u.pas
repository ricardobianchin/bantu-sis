unit App.Est.Venda.Caixa.CaixaSessao.Utils_u;

interface

type
  TCxOpTipo = ( //
    cxopNaoIndicado = 032 //
    , cxopAbertura = 033 //
    , cxopSangria = 034 //
    , cxopSuprimento = 035 //
    , cxopVale = 036 //
    , cxopDespesa = 037 //
    , cxopConvenio = 038 //
    , cxopCrediario = 039 //
    , cxopFechamento = 040 //
    , cxopDevolucao = 041 //
    , cxopVenda = 042 //
    );

function CharToCxOpTipo(pChar: string): TCxOpTipo;
function CxOpTipoToSqlConstant(pCxOpTipo: TCxOpTipo): string;

implementation

uses System.SysUtils;

function CharToCxOpTipo(pChar: string): TCxOpTipo;
var
  c: Char;
begin
  pChar := Trim(pChar);
  if pChar = '' then
    c := #032
  else
    c := pChar[1];

  case c of
    #033: Result := cxopAbertura;
    #034: Result := cxopSangria;
    #035: Result := cxopSuprimento;
    #036: Result := cxopVale;
    #037: Result := cxopDespesa;
    #038: Result := cxopConvenio;
    #039: Result := cxopCrediario;
    #040: Result := cxopFechamento;
    #041: Result := cxopDevolucao;
    #042: Result := cxopVenda;
    else {#032:} Result := cxopNaoIndicado;
  end;
end;

function CxOpTipoToSqlConstant(pCxOpTipo: TCxOpTipo): string;
var
  b: Byte;
  c: Char;
begin
  b := Integer(pCxOpTipo);
  c := Chr(b);
  Result := QuotedStr(c);
end;

end.
