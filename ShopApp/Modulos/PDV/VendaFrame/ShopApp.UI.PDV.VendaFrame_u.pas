unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types,
  Vcl.Grids, App.PDV.Venda, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  ShopApp.PDV.DBI, ShopApp.UI.PDV.Venda.Frame.FitaDraw, Vcl.ComCtrls,
  Vcl.ToolWin;

type
  TShopVendaPDVFrame = class(TVendaBasPDVFrame)
    InputPanel: TPanel;
    StrBuscaLabel: TLabel;
    CaretTimer: TTimer;
    CaretShape: TShape;
    FitaStringGrid: TStringGrid;
    ItemPanel: TPanel;
    ItemDescrLabel: TLabel;
    ItemTotalLabel: TLabel;
    TotalPanel: TPanel;
    TotalBrutoLabel: TLabel;
    VolumesLabel: TLabel;
    BasePanel: TPanel;
    PDVToolBar: TToolBar;
    ToolButton1: TToolButton;
    ItemCanceleToolButton: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton2: TToolButton;
    procedure CaretTimerTimer(Sender: TObject);
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FitaStringGridEnter(Sender: TObject);
    procedure ItemCanceleToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    FStrBusca: string;
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FFitaDraw: IShopFitaDraw;

    procedure DimensioneItemPanel;
    procedure DimensioneInput;
    procedure DimensioneFitaStringGrid;

    procedure StrBuscaPegueChar(pChar: Char);
    procedure StrBuscaExec; // ADICIONA ITEM
    procedure StrBuscaMudou;

    procedure ItemZerar;
    procedure PreencherControles;

    procedure ExibaItemVendido(pDescr: string; pValor: Currency = 0);

    procedure ItemCancele;
    procedure ItemSelecione(pIndex: integer = -1);
    function GetItemUltimoIndex: integer;
  protected
    procedure SimuleKeyPress(pChar: Char);
  public
    { Public declarations }
    procedure ExibaErro(pMens: string); override;
    procedure DimensioneControles; override;

    // TECLADO KEYDOWN
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

    // TECLADO PRESS
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;

    procedure Iniciar; override;

    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
      pShopAppPDVDBI: IShopAppPDVDBI); reintroduce;
  end;

var
  ShopVendaPDVFrame: TShopVendaPDVFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.UI.Controls.Utils, ShopApp.PDV.Factory_u,
  Sis.Types.Floats, Sis.Types.Bool_u, ShopApp.UI.PDV.ItemCancelarForm_u;

{ TShopVendaPDVFrame }

procedure TShopVendaPDVFrame.CaretTimerTimer(Sender: TObject);
begin
  inherited;
  CaretShape.Visible := not CaretShape.Visible;
end;

constructor TShopVendaPDVFrame.Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
  pShopAppPDVDBI: IShopAppPDVDBI);
begin
  inherited Create(AOwner, pPDVVenda);
  FShopAppPDVDBI := pShopAppPDVDBI;
  FShopPDVVenda := VendaAppCastToShopApp(pPDVVenda);

  FFitaDraw := FitaDrawCreate(FShopPDVVenda, FitaStringGrid);
  FFitaDraw.Atualize;

  FStrBusca := '';
  ItemDescrLabel.Caption := '';
  ItemTotalLabel.Caption := '';
end;

procedure TShopVendaPDVFrame.DimensioneControles;
var
  MargHor: Integer;
  MargVer: Integer;
begin
  inherited;
  MargHor := 5;
  MargVer := 3;

  FColuna1Rect.Left := MargHor;
  FColuna1Rect.Top := MargVer;
  FColuna1Rect.Width := (MeioPanel.Width - (3 * MargHor)) div 2;
  FColuna1Rect.Height := MeioPanel.Height - (2 * MargVer);

  FColuna2Rect.Left := FColuna1Rect.Width + MargHor * 2;
  FColuna2Rect.Top := FColuna1Rect.Top;
  FColuna2Rect.Width := FColuna1Rect.Width;
  FColuna2Rect.Height := FColuna1Rect.Height;

  DimensioneInput;
  DimensioneItemPanel;
  DimensioneFitaStringGrid;
  ControlAlignToCenter(PDVToolBar);

end;

procedure TShopVendaPDVFrame.DimensioneFitaStringGrid;
var
  l, t, w, h: Integer;
  iDir: Integer;
begin
  FitaStringGrid.Font.Name := 'Courier New';
  FitaStringGrid.Font.Size := 12;

  FitaStringGrid.Canvas.Font.Assign(FitaStringGrid.Font);

  h := (FColuna2Rect.Height * 56) div 80;
  t := FColuna2Rect.Top;
  // w := FColuna2Rect.Width;
  w := (FitaStringGrid.Canvas.TextWidth('W') * ((CUPOM_QTD_COLS * 2) +
    1)) div 2;

  iDir := ItemPanel.Left + ItemPanel.Width;
  l := iDir - w;

  FitaStringGrid.Left := l;
  FitaStringGrid.Top := t;
  FitaStringGrid.Width := w;
  FitaStringGrid.Height := h;

  FitaStringGrid.DefaultColWidth := FitaStringGrid.Width;

  FFitaDraw.Prepare;
end;

procedure TShopVendaPDVFrame.DimensioneInput;
var
  l, t, w, h: Integer;
begin
  l := FColuna2Rect.Left;
  h := FColuna2Rect.Height div 8;
  t := FColuna2Rect.Height - h;
  w := FColuna2Rect.Width;

  InputPanel.Left := l;
  InputPanel.Top := t;
  InputPanel.Width := w;
  InputPanel.Height := h;

  InputPanel.Color := Rgb(16, 21, 36);
  // InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);

  CaretShape.Brush.Color := InputPanel.Font.Color;
end;

procedure TShopVendaPDVFrame.DimensioneItemPanel;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := InputPanel.Height;
  w := FColuna2Rect.Left + FColuna2Rect.Width - l;
  t := InputPanel.Top - 4 - h;

  ItemPanel.Left := l;
  ItemPanel.Top := t;
  ItemPanel.Width := w;
  ItemPanel.Height := h;

  ItemPanel.Color := Rgb(16, 21, 36);
  // ItemPanel.BevelOuter := bvNone;
  ItemPanel.Font.Color := Rgb(248, 237, 228);
end;

procedure TShopVendaPDVFrame.ExecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {
[14:17, 12/14/2024] Anderson Aragão Daros: Page up- totalizar
Page down- dinheiro
Insert -cartão
Home- pix ou transferência
End devolução
[14:17, 12/14/2024] Anderson Aragão Daros: Pause cancelamento de item
}

  case key of
    VK_UP:
    begin
      if FitaStringGrid.Row > 0 then
        FitaStringGrid.Row := FitaStringGrid.Row - 1;
    end;
    VK_DOWN:
    begin
      if FitaStringGrid.Row < FitaStringGrid.RowCount - 1 then
        FitaStringGrid.Row := FitaStringGrid.Row + 1;
    end;
    VK_DELETE: ItemCancele;
    VK_NEXT:
  end;
end;

procedure TShopVendaPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  StrBuscaPegueChar(Key);
end;

procedure TShopVendaPDVFrame.ExibaErro(pMens: string);
begin
  inherited;
  ExibaItemVendido(pMens);
end;

procedure TShopVendaPDVFrame.ExibaItemVendido(pDescr: string; pValor: Currency);
begin
  ItemDescrLabel.Caption := pDescr;
  ItemTotalLabel.Caption := Iif(pValor = 0, '', DinhToStr(pValor));
end;

procedure TShopVendaPDVFrame.FitaStringGridDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  FFitaDraw.FitaStringGridDrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TShopVendaPDVFrame.FitaStringGridEnter(Sender: TObject);
begin
  inherited;
  TForm(Parent).ActiveControl := Nil;
//  InputPanel.SetFocus;
end;

function TShopVendaPDVFrame.GetItemUltimoIndex: integer;
begin
  Result := FShopPDVVenda.Count - 1;
end;

procedure TShopVendaPDVFrame.Iniciar;
var
  bCarregou: Boolean;
begin
  inherited;

  FShopAppPDVDBI.CarregueVendaPendente(bCarregou);
  PreencherControles;

  // SimuleKeyPress('3');
  // SimuleKeyPress('*');
  // SimuleKeyPress('2');

  // DigiteStr('2~', 0);
  // DigiteStr('3*2~', 0);
  // ExecKeyPress(
end;

procedure TShopVendaPDVFrame.ItemCancele;
var
  bResultado: Boolean;
begin
  if FitaStringGrid.RowCount = 0 then
  begin
    ShowMessage('Nenhum item a cancelar');
    exit;
  end;

  ItemCancelarForm_ShopApp := TItemCancelarForm_ShopApp.Create( FitaStringGrid,
    FShopPDVVenda, FShopAppPDVDBI);
  try
    bResultado := ItemCancelarForm_ShopApp.Perg;

    if bResultado then
      PreencherControles;
  finally
    FreeAndNil(ItemCancelarForm_ShopApp);
  end;
end;

procedure TShopVendaPDVFrame.ItemSelecione(pIndex: integer);
var
  iMax: integer;
begin
  if FitaStringGrid.RowCount < 2 then
    exit;

  iMax := GetItemUltimoIndex;

  if pIndex < 0 then
  begin
    pIndex := iMax;
  end
  else if pIndex > iMax then
  begin
    pIndex := iMax;
  end;

  FitaStringGrid.Row := pIndex + 1;
end;

procedure TShopVendaPDVFrame.PreencherControles;
var
  i: Integer;
  oItem: IShopPdvVendaItem;
  iQtdVolumes: Integer;
  uTotalLiquido: Currency;
  s: string;
begin
  FFitaDraw.Atualize;

  iQtdVolumes := 0;
  uTotalLiquido := 0;

  for i := 0 to FShopPDVVenda.Count - 1 do
  begin
    oItem := FShopPDVVenda[i];
    if not oItem.Cancelado then
    begin
      Inc(iQtdVolumes, oItem.QtdVolumes);
      uTotalLiquido := uTotalLiquido + oItem.Preco;
    end;
  end;

  if iQtdVolumes = 0 then
    s := ''
  else
    s := iQtdVolumes.ToString;

  VolumesLabel.Caption := 'Volumes: ' + s;

  if uTotalLiquido = 0 then
    s := ''
  else
    s := DinhToStr(uTotalLiquido);

  TotalBrutoLabel.Caption := 'Total: ' + s;

  ItemSelecione;
//  InputPanel.SetFocus;
end;

procedure TShopVendaPDVFrame.SimuleKeyPress(pChar: Char);
begin
  ExecKeyPress(Self, pChar);
end;

procedure TShopVendaPDVFrame.StrBuscaExec;
var
  oItem: IShopPdvVendaItem;
  bEncontrou: Boolean;
  sMensagem: string;
begin
  oItem := FShopAppPDVDBI.ItemCreatePelaStrBusca(FStrBusca, bEncontrou,
    sMensagem);

  if not bEncontrou then
  begin
    ExibaErro(sMensagem);
    Exit;
  end;
  FShopPDVVenda.Add(oItem);
  ExibaItemVendido(oItem.Prod.DescrRed, oItem.PrecoBruto);
  PreencherControles;
  FStrBusca := '';
  StrBuscaMudou;
end;

procedure TShopVendaPDVFrame.StrBuscaMudou;
begin
  if FStrBusca = '' then
    StrBuscaLabel.Caption := 'Quantidade * Código / Código'
  else
    StrBuscaLabel.Caption := FStrBusca;
end;

procedure TShopVendaPDVFrame.StrBuscaPegueChar(pChar: Char);
begin
  try
    if pChar = #8 then
    begin
      StrDeleteNoFim(FStrBusca, 1);
      Exit;
    end
    else if pChar = #13 then
    begin
      StrBuscaExec;
      Exit;
    end;
    CharSemAcento(pChar);
    FStrBusca := FStrBusca + pChar;
  finally
    StrBuscaMudou;
  end;
end;

procedure TShopVendaPDVFrame.ItemCanceleToolButtonClick(Sender: TObject);
begin
  inherited;
  ItemCancele;
end;

procedure TShopVendaPDVFrame.ItemZerar;
begin

end;

end.
