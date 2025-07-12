unit App.PDV.ImpressaoTextoPOSPrinterVenda_u;

interface

uses App.PDV.ImpressaoTexto.POSPrinter_u, App.AppObj, Sis.Terminal,
  App.PDV.Venda,
  App.PDV.VendaItem, App.PDV.VendaPag;

type
  TImpressaoTextoPOSPrinterPDVVenda = class(TImpressaoTextoPOSPrinterPDV)
  private
    FPDVVenda: IPDVVenda;
    FLenMaxDescr: integer;
    FTotalLiquido: Currency;
    procedure GereItem(It: IPDVVendaItem);
    procedure GerePag(Pag: IVendaPag);
  protected
    procedure GereCabec; override;
    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer;
      pUsuarioNomeExib: string; pAppObj: IAppObj; pTerminal: ITerminal;
      pPDVVenda: IPDVVenda);
  end;

implementation

uses Sis.Types.strings_u, System.SysUtils, System.StrUtils, System.Math,
  Sis.Types.Floats, App.PDV.Factory_u, Sis.Types.Integers;

{ TImpressaoTextoPOSPrinterPDVVenda }

constructor TImpressaoTextoPOSPrinterPDVVenda.Create(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pPDVVenda: IPDVVenda);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib, pAppObj,
    pTerminal, CupomEspelhoVendaCreate(pAppObj));
  FPDVVenda := pPDVVenda;
end;

procedure TImpressaoTextoPOSPrinterPDVVenda.GereCabec;
var
  s: string;
begin
  inherited;
  s := FPDVVenda.GetCod;
  PegueLinha('</ce>' + s);
end;

procedure TImpressaoTextoPOSPrinterPDVVenda.GereItem(It: IPDVVendaItem);
var
  sLinha: string;
  sDescr: string;
  sQtd: string;
  sMascara: string;
begin
  // sLinha := '';
  // OverwriteStringRight(sLinha, IntToStrZero(It.Ordem + 1, 3), 3);
  OverwriteStringRight(sLinha, (It.Prod.Id).ToString, 11);

  sLinha := IntToStrZero(It.Ordem + 1, 3);
  OverwriteStringRight(sLinha, IntToStrZero(It.Prod.Id, 7), 11);

  sDescr := StringReplace(It.Prod.DescrRed, #1, #32,
    [rfReplaceAll, rfIgnoreCase]);
  sDescr := Trim(LeftStr(sDescr, FLenMaxDescr));

  sLinha := sLinha + ' ' + sDescr;

  PegueLinha('</ae>' + sLinha);

  sLinha := '';
  if CurrencyEhInteiro(It.Qtd) then
    sMascara := '#######0'
  else
    sMascara := '#######0.###';

  sQtd := FormatFloat(sMascara, It.Qtd);

  sLinha := ' ' + sQtd + ' x ' + DinhToStr(It.PrecoUnit);

  // OverwriteStringRight(sLinha, sQtd, 10);
  // OverwriteStringRight(sLinha, 'x', 12);
  // OverwriteStringRight(sLinha, DinhToStr(it.PrecoUnit), 14);
  if It.Desconto >= 0.01 then
  begin
    sLinha := sLinha + ' - ' + DinhToStr(It.Desconto);
  end;

  while Length(sLinha) < NCols do
    sLinha := sLinha + '.';

  OverwriteStringRight(sLinha, DinhToStr(It.Preco), NCols);
  PegueLinha(sLinha);

  if It.Cancelado then
    PegueLinha('     C A N C E L A D O')
  else
    FTotalLiquido := FTotalLiquido + It.Preco;
end;

procedure TImpressaoTextoPOSPrinterPDVVenda.GerePag(Pag: IVendaPag);
var
  sLinha: string;
  sDescr: string;
  sQtd: string;
  sMascara: string;
begin
  sLinha := Pag.PagamentoFormaTipoDescrRed + ' ' + Pag.PagamentoFormaDescr;
  OverwriteStringRight(sLinha, DinhToStr(Pag.ValorDevido), NCols);
  PegueLinha(sLinha);
  if Pag.Troco >= 0.01 then
  begin
    sLinha := 'TROCO';
    OverwriteStringRight(sLinha, DinhToStr(Pag.Troco), NCols);
    PegueLinha(sLinha);
  end;

  if Pag.Cancelado then
    PegueLinha('     C A N C E L A D O');
end;

procedure TImpressaoTextoPOSPrinterPDVVenda.GereTexto;
var
  i: integer;
  oPDVVendaItem: IPDVVendaItem;
  oVendaPag: IVendaPag;
  iQtdVolumes: integer;
  sLinha: string;
begin
  inherited;
  iQtdVolumes := 0;
  FLenMaxDescr := NCols - 13;
  for i := 0 to FPDVVenda.Items.Count - 1 do
  begin
    oPDVVendaItem := FPDVVenda.Items[i];
    GereItem(oPDVVendaItem);
    inc(iQtdVolumes, oPDVVendaItem.QtdVolumes);;
  end;

  sLinha := '<CE>QTD.ITENS: ' + iQtdVolumes.ToString + '</CE>';
  PegueLinha(sLinha);

  PegueSeparador;
  sLinha := 'TOTAL A PAGAR';

  OverwriteStringRight(sLinha, DinhToStr(FTotalLiquido), NCols);

  PegueLinha(sLinha);

  for i := 0 to FPDVVenda.VendaPagList.Count - 1 do
  begin
    oVendaPag := FPDVVenda.VendaPagList[i];
    GerePag(oVendaPag);
  end;
end;

function TImpressaoTextoPOSPrinterPDVVenda.GetDocTitulo: string;
begin
  Result := 'Cupom Venda ' + FPDVVenda.GetCod;
end;

function TImpressaoTextoPOSPrinterPDVVenda.GetDtDoc: TDateTime;
begin
  Result := FPDVVenda.DtHDoc;
end;

function TImpressaoTextoPOSPrinterPDVVenda.GetEspelhoAssuntoAtual: string;
begin
  Result := FPDVVenda.GetCod;
end;

end.
