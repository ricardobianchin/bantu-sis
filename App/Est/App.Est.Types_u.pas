unit App.Est.Types_u;

interface

uses System.Classes;

type
  TBalancaUso = (baltNaoUtiliza, baltUtiliza, baltUsuPrecoTot,
    baltUsoPrecoUnitQtd);

  TCaixaSessaoSituacao = (cxFechado, cxAberto, cxAbertoPorOutroUsuario);
  TProdNatu = (pnatuNaoIndicado = 32, pnatuProduto = 33, pnatuServico = 34,
    pnatuMateriaPrima = 35, pnatuKit = 36, pnatuComposicao = 37);

const
  BalancaUsoStr: array [TBalancaUso] of string = ( //
    'Não utiliza' //
    , 'Utiliza' //
    , 'Usuário indicará preço total' //
    , 'Usuário indicará quantidade e preço unitário' //
    );

  ProdNatuStr: array [TProdNatu] of string = ( //
    'Não indicado' //
    , 'Produto' //
    , 'Serviço' //
    , 'Matéria-Prima' //
    , 'Kit' //
    , 'Composição' //
    );

procedure BalancaUsoStrToSL(pSL: TStrings);
function ProdNatuToChar(pProdNatu: TProdNatu): char;
function ProdNatuToSql(pProdNatu: TProdNatu): string;
function StrToProdNatu(const AValue: string): TProdNatu;

type
  TEstMovTipo = ( //
    emtipoNaoIndicado = 32 //
    , emtipoEntrada = 33 // !
    , emtipoVenda = 34 // "
    , emtipoInventario = 35 // #
    , emtipoDevolucaoDeVenda = 36 // $
    , emtipoDevolucaoDeCompra = 37 // %
    , emtipoSaida = 38 // &
    , emtipoSaidaEstorno = 39 // '
    );

type
  TEstMovTipoHelper = record helper for TEstMovTipo
    function ToNome: string;
    function AsSqlConstant: string;
    procedure SetFromString(const AValue: string);
  end;

procedure EstSaldoHistCalc(var pSaldo: Currency; pQtd: Currency;
  pEstMovTipo: string; out pCodUsaTerm: Boolean);

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

function ProdNatuToChar(pProdNatu: TProdNatu): char;
begin
  Result := Chr(Integer(pProdNatu));
end;

function ProdNatuToSql(pProdNatu: TProdNatu): string;
begin
  Result := QuotedStr(ProdNatuToChar(pProdNatu));
end;

function StrToProdNatu(const AValue: string): TProdNatu;
var
  CharValue: char;
begin
  if AValue = '' then
    Result := pnatuNaoIndicado
  else
  begin
    CharValue := AValue[1];
    Result := TProdNatu(Ord(CharValue));
  end;
end;

{ TEstMovTipoHelper }

function TEstMovTipoHelper.AsSqlConstant: string;
begin
  Result := QuotedStr(char(Self));
end;

procedure TEstMovTipoHelper.SetFromString(const AValue: string);
begin
  if (AValue = '') then
    Self := emtipoNaoIndicado
  else
    Self := TEstMovTipo(Ord(AValue[1]));
end;

function TEstMovTipoHelper.ToNome: string;
begin
  case Self of
    emtipoEntrada:
      Result := 'Entrada';
    emtipoVenda:
      Result := 'Venda';
    emtipoInventario:
      Result := 'Inventário';
    emtipoDevolucaoDeVenda:
      Result := 'Devolução de Venda';
    emtipoDevolucaoDeCompra:
      Result := 'Devolução de Compra';
    emtipoSaida:
      Result := 'Saída';
    emtipoSaidaEstorno:
      Result := 'Estorno de Sa�da';
  else { emtipoNaoIndicado: }
    Result := 'Não indicado';
  end;
end;

procedure EstSaldoHistCalc(var pSaldo: Currency; pQtd: Currency;
  pEstMovTipo: string; out pCodUsaTerm: Boolean);
var
  t: TEstMovTipo;
begin
  pCodUsaTerm := False;
  pEstMovTipo := Trim(pEstMovTipo);
  if pEstMovTipo = '' then
    exit;
  t := TEstMovTipo(Ord(pEstMovTipo[1]));
  case t of
    emtipoEntrada:
      pSaldo := pSaldo + pQtd;
    emtipoVenda:
      begin
        pSaldo := pSaldo - pQtd;
        pCodUsaTerm := True;
      end;
    emtipoInventario:
      pSaldo := pQtd;
    emtipoSaida:
      pSaldo := pSaldo - pQtd;
    else begin end;
  end;
end;

end.
