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

  TCxOpTipoHelper = record helper for TCxOpTipo
  public
    function ToChar: Char;
    function ToSqlConstant: string;
    procedure FromString(const S: string);
  end;

implementation

uses System.SysUtils;

function TCxOpTipoHelper.ToChar: Char;
begin
  Result := Chr(Ord(Self));
end;

function TCxOpTipoHelper.ToSqlConstant: string;
begin
  Result := QuotedStr(ToChar);
end;

procedure TCxOpTipoHelper.FromString(const S: string);
begin
  if S = '' then
    Self := cxopNaoIndicado
  else
    Self := TCxOpTipo(Ord(S[1]));
end;

end.
