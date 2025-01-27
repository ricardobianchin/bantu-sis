unit App.PDV.ImpressaoTextoVenda_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.Venda,
  App.PDV.VendaItem;

type
  TImpressaoTextoPDVVenda = class(TImpressaoTextoPDV)
  private
    FPDVVenda: IPDVVenda;
    FLenMaxDescr: integer;

    procedure GereItem(It: IPDVVendaItem);
  protected
    procedure GereTexto; override;
  public
    constructor Create(pImpressoraNome, pDocTitulo: string; pAppObj: IAppObj;
      pTerminal: ITerminal; pPDVVenda: IPDVVenda);
  end;

implementation

uses Sis.Types.strings_u, System.SysUtils, System.StrUtils, System.Math,
  Sis.Types.Floats;

{ TImpressaoTextoPDVVenda }

constructor TImpressaoTextoPDVVenda.Create(pImpressoraNome, pDocTitulo: string;
  pAppObj: IAppObj; pTerminal: ITerminal; pPDVVenda: IPDVVenda);
begin
  inherited Create(pImpressoraNome, pDocTitulo, pAppObj, pTerminal);
  FPDVVenda := pPDVVenda;
end;

procedure TImpressaoTextoPDVVenda.GereItem(It: IPDVVendaItem);
var
  sLinha: string;
  sDescr: string;
  sQtd: string;
  sMascara: string;
begin
  sLinha := '';
  OverwriteStringRight(sLinha, (It.Ordem + 1).ToString, 3);
  OverwriteStringRight(sLinha, (It.Prod.Id).ToString, 11);

  sDescr := StringReplace(It.Prod.DescrRed, #1, #32,
    [rfReplaceAll, rfIgnoreCase]);
  sDescr := Trim(LeftStr(sDescr, FLenMaxDescr));

  OverwriteStringRight(sLinha, sDescr, 13);

  if CurrencyEhInteiro(It.Qtd) then
    sMascara := '#######0'
  else
    sMascara := '#######0.###';

  sLinha := '';
  sQtd := FormatFloat(sMascara, It.Qtd);

  OverwriteStringRight(sLinha, sQtd, 10);
  OverwriteStringRight(sLinha, 'x', 12);
  OverwriteStringRight(sLinha, DinhToStr(it.PrecoUnit), 14);
  if It.Desconto >= 0.01 then
  begin
    sLinha := sLinha + ' - ' + DinhToStr(It.Desconto);
  end;
  while Length(sLinha) <sNCol do
    sLinha := slinha + '.';

end;

procedure TImpressaoTextoPDVVenda.GereTexto;
var
  i: integer;
  oPDVVendaItem: IPDVVendaItem;
begin
  inherited;
  FLenMaxDescr := NCols - 13;
  for i := 0 to FPDVVenda.Items.Count - 1 do
  begin
    oPDVVendaItem := FPDVVenda.Items[i];
    GereItem(oPDVVendaItem);
  end;
end;

end.
