unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types,
  Vcl.Grids, App.PDV.Venda, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  App.PDV.DBI, ShopApp.PDV.DBI, ShopApp.UI.PDV.Venda.Frame.FitaDraw,
  Vcl.ComCtrls, Vcl.ToolWin, App.PDV.Controlador, ShopApp.PDV.Obj,
  Sis.UI.Select, Sis.DBI, Sis.UI.Frame.Bas.Filtro_u, ShopApp.PDV.Venda.Engat_u;

const
  // GUTTER espaço entre colunas
  MARGEM = 1 / 205;
  ENTRE_COLS_LARG = 1 / 40 { estava 1/25 };
  PROD_PANEL_ALT = 1 / 8;
  ENTRE_PROD_PANEL_ALT = 1 / 80;
  INPUT_FONT_SIZE = 25 / 616;
  CARET_RATIO = 5 / 19;
  ITEM_DESCR_FONT_SIZE = 22 / 616;
  ITEM_DESCR_TOP = 27 / 72;
  TOTAL_LIQ_FONT_SIZE = 20 / 616;
  VOLUMES_FONT_SIZE = 12 / 616;
  AZUL_CLARO_COR = $FFD199;
  CINZA_FUNDO_COR = $F0F0F0;
  PRETO_INTERNO_COR = $241510;

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
    BasePanel: TPanel;
    PDVToolBar: TToolBar;
    VoltouToolButton: TToolButton;
    ItemCanceleToolButton: TToolButton;
    PagSomenteDinheiroToolButton: TToolButton;
    PagamentoToolButton: TToolButton;
    ToolButton2: TToolButton;
    CPFToolButton: TToolButton;
    GavetaToolButton: TToolButton;
    MedeFontesInputPaintBox: TPaintBox;
    MedeFontesGridPaintBox: TPaintBox;
    TotalExtPanel: TPanel;
    TotalExtEsqPanel: TPanel;
    TotalExtDirPanel: TPanel;
    TotalPanel: TPanel;
    TotalLiquidoLabel: TLabel;
    VolumesLabel: TLabel;
    PaintBox2: TPaintBox;
    PaintBox1: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    PaintPanel1: TPanel;
    PaintPanel2: TPanel;
    PaintPanel3: TPanel;
    PaintPanel4: TPanel;
    PaintBoxGrid1: TPaintBox;
    PaintBoxGrid2: TPaintBox;
    PaintBoxGrid3: TPaintBox;
    PaintBoxGrid4: TPaintBox;
    ItemPaintPanel1: TPanel;
    ItemPaintBox1: TPaintBox;
    ItemPaintPanel2: TPanel;
    ItemPaintBox2: TPaintBox;
    ItemPaintPanel3: TPanel;
    ItemPaintBox3: TPaintBox;
    ItemPaintPanel4: TPanel;
    ItemPaintBox4: TPaintBox;
    InputPaintPanel1: TPanel;
    InputPaintBox1: TPaintBox;
    InputPaintPanel2: TPanel;
    InputPaintBox2: TPaintBox;
    InputPaintPanel3: TPanel;
    InputPaintBox3: TPaintBox;
    InputPaintPanel4: TPanel;
    InputPaintBox4: TPaintBox;
    procedure CaretTimerTimer(Sender: TObject);
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FitaStringGridEnter(Sender: TObject);
    procedure ItemCanceleToolButtonClick(Sender: TObject);
    procedure PagSomenteDinheiroToolButtonClick(Sender: TObject);
    procedure PagamentoToolButtonClick(Sender: TObject);
    procedure GavetaToolButtonClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
    procedure PaintBox4Paint(Sender: TObject);
    procedure PaintBoxGrid1Paint(Sender: TObject);
    procedure PaintBoxGrid2Paint(Sender: TObject);
    procedure PaintBoxGrid3Paint(Sender: TObject);
    procedure PaintBoxGrid4Paint(Sender: TObject);
    procedure ItemPaintBox1Paint(Sender: TObject);
    procedure ItemPaintBox2Paint(Sender: TObject);
    procedure ItemPaintBox3Paint(Sender: TObject);
    procedure ItemPaintBox4Paint(Sender: TObject);
    procedure InputPaintBox1Paint(Sender: TObject);
    procedure InputPaintBox2Paint(Sender: TObject);
    procedure InputPaintBox3Paint(Sender: TObject);
    procedure InputPaintBox4Paint(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    FStrBusca: string;
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FFitaDraw: IShopFitaDraw;
    FShopPDVObj: IShopPDVObj;
    FProdSelect: ISelect;

    FItemPanelTop: Integer;
    FItemPanelHeight: Integer;

    FInputPanelTop: Integer;
    FInputPanelHeight: Integer;

    MargHor: Integer;
    MargVer: Integer;
    LargUtil: Integer;
    AltuUtil: Integer;

    FEngat: TVendaProdEngat;

    procedure DimensioneItemPanel;
    procedure DimensioneInput;
    procedure DimensioneFitaStringGrid;
    procedure DimensioneTotalPanel;

    procedure StrBuscaPegueChar(pChar: Char);

    // processa enter
    procedure StrBuscaExec;

    procedure StrBuscaMudou;

    procedure ItemZerar;
    procedure PreencherControles;

    procedure ItemVendidoExiba(pDescr: string; pValor: Currency = 0);
    procedure ItemVendidoRepaint;

    procedure ItemCancele;
    procedure ItemSelecione(pIndex: Integer = -1);
    function GetItemUltimoIndex: Integer;

    procedure AcioneGaveta;
    procedure EngatPegar(pEngat: TVendaProdEngat);
    procedure EngatVender;

  protected
    procedure ExibaControles; override;

  public
    { Public declarations }
    procedure ExibaErro(pMens: string); override;
    procedure ExibaMens(pMens: string); override;
    procedure DimensioneControles; override;

    // TECLADO PRESS
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;

    // TECLADO KEYDOWN
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

    procedure Iniciar; override;

    constructor Create(AOwner: TComponent; pShopPDVObj: IShopPDVObj;
      pPDVVenda: IPDVVenda; pAppPDVDBI: IAppPDVDBI;
      pPDVControlador: IPDVControlador; pProdSelect: ISelect); reintroduce;
  end;

var
  ShopVendaPDVFrame: TShopVendaPDVFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.UI.Controls.Utils, ShopApp.PDV.Factory_u,
  Sis.Types.Floats, Sis.Types.Bool_u, ShopApp.UI.PDV.ItemCancelarForm_u,
  Sis.UI.IO.Input.Perg, Sis.UI.Controls.Factory, ShopApp.PDV.Venda.Utils_u,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u,
  ShopApp.UI.Form.PDV.Venda.ItemQtdPerg_u;

{ TShopVendaPDVFrame }

procedure TShopVendaPDVFrame.AcioneGaveta;
begin
  ExibaMens('Acionando gaveta');
  ItemVendidoRepaint;

  PDVObj.Gaveta.Acione;

  Sleep(300);

  StrBuscaMudou;
end;

procedure TShopVendaPDVFrame.CaretTimerTimer(Sender: TObject);
begin
  inherited;
  CaretShape.Visible := not CaretShape.Visible;
end;

constructor TShopVendaPDVFrame.Create(AOwner: TComponent;
  pShopPDVObj: IShopPDVObj; pPDVVenda: IPDVVenda; pAppPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador; pProdSelect: ISelect);
begin
  inherited Create(AOwner, pShopPDVObj, pPDVVenda, pAppPDVDBI, pPDVControlador);
  FEngat.Zerar;
  FShopPDVObj := pShopPDVObj;
  FShopPDVVenda := VendaAppCastToShopApp(pPDVVenda);
  FShopAppPDVDBI := DBIAppCastToShopApp(pAppPDVDBI);
  FFitaDraw := FitaDrawCreate(VendaAppCastToShopApp(pPDVVenda), FitaStringGrid,
    MedeFontesGridPaintBox);
  FProdSelect := pProdSelect;

  FStrBusca := '';
  ItemDescrLabel.Caption := '';
  ItemTotalLabel.Caption := '';
end;

procedure TShopVendaPDVFrame.DimensioneControles;

// QTD_COLS = 2;
// GUTTERS_TOTAL = GUTTER * (QTD_COLUNAS - 1);
// LARG_COLUNA = (LARG_UTIL - GUTTERS_TOTAL) div QTD_COLUNAS;
var
  EntreColsLarg: Integer;
  ColunaLarg: Integer;
  ColunaAltu: Integer;

  EntrePanelsAltu: Integer;

begin
  inherited;
  MargHor := Round(MARGEM * MeioPanel.Height);
  if MargHor < 1 then
    MargHor := 1;

  MargVer := Round(MARGEM * MeioPanel.Width);
  if MargVer < 1 then
    MargVer := 1;

  EntreColsLarg := Round(ENTRE_COLS_LARG * MeioPanel.Width);
  if EntreColsLarg < 1 then
    EntreColsLarg := 1;

  LargUtil := MeioPanel.Width - (2 * MargVer);
  AltuUtil := MeioPanel.Height - (2 * MargHor);

  EntrePanelsAltu := Round(AltuUtil * ENTRE_PROD_PANEL_ALT);
  if EntrePanelsAltu < 1 then
    EntrePanelsAltu := 1;

  FInputPanelHeight := Round(AltuUtil * PROD_PANEL_ALT) - EntrePanelsAltu div 2;
  FItemPanelHeight := FInputPanelHeight;

  FInputPanelTop := MargVer + AltuUtil - FInputPanelHeight;
  FItemPanelTop := FInputPanelTop - FItemPanelHeight - EntrePanelsAltu;

  ColunaLarg := (LargUtil - EntreColsLarg) div 2;
  ColunaAltu := FItemPanelTop - MargVer;

  FColuna1Rect.Left := MargHor;
  FColuna1Rect.Top := MargVer;
  FColuna1Rect.Width := ColunaLarg;
  FColuna1Rect.Height := ColunaAltu;

  FColuna2Rect.Left := FColuna1Rect.Left + FColuna1Rect.Width + EntreColsLarg;
  FColuna2Rect.Top := FColuna1Rect.Top;
  FColuna2Rect.Width := FColuna1Rect.Width;
  FColuna2Rect.Height := FColuna1Rect.Height;

  DimensioneInput;
  DimensioneItemPanel;
  DimensioneFitaStringGrid;
  DimensioneTotalPanel;
  ControlAlignToCenter(PDVToolBar);
  PDVToolBar.StyleElements := [seFont, seClient, seBorder];
end;

procedure TShopVendaPDVFrame.DimensioneFitaStringGrid;
var
  l, t, w, h: Integer;
  iDir: Integer;
begin
  FitaStringGrid.Font.Name := 'Courier New';
  FitaStringGrid.Font.Size := 12;

  FitaStringGrid.Canvas.Font.Assign(FitaStringGrid.Font);

  t := FColuna2Rect.Top;
  h := t + FColuna2Rect.Height;
  w := FColuna2Rect.Width;
  // w := (FitaStringGrid.Canvas.TextWidth('W') * ((CUPOM_QTD_COLS * 2) + 1)) div 2;
  // iDir := ItemPanel.Left + ItemPanel.width;
  // l := iDir - w;
  // FitaStringGrid.Left := l;

  FitaStringGrid.Left := FColuna2Rect.Left;
  FitaStringGrid.Top := FColuna2Rect.Top;
  FitaStringGrid.Width := FColuna2Rect.Width;
  FitaStringGrid.Height := FColuna2Rect.Height;

  PaintBoxGrid1.BringToFront;
  PaintBoxGrid2.BringToFront;
  PaintBoxGrid3.BringToFront;
  PaintBoxGrid4.BringToFront;

  PaintPanel1.Left := FitaStringGrid.Left;
  PaintPanel1.Top := FitaStringGrid.Top;

  PaintPanel2.Left := FitaStringGrid.Left + FitaStringGrid.Width -
    PaintBoxGrid2.Width;
  PaintPanel2.Top := FitaStringGrid.Top;

  PaintPanel3.Left := FitaStringGrid.Left;
  PaintPanel3.Top := FitaStringGrid.Top + FitaStringGrid.Height -
    PaintBoxGrid3.Height;

  PaintPanel4.Left := FitaStringGrid.Left + FitaStringGrid.Width -
    PaintBoxGrid4.Width;
  PaintPanel4.Top := FitaStringGrid.Top + FitaStringGrid.Height -
    PaintBoxGrid4.Height;

  FitaStringGrid.DefaultColWidth := FitaStringGrid.Width;

  FFitaDraw.Prepare;
end;

procedure TShopVendaPDVFrame.DimensioneInput;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := FInputPanelHeight;
  t := FInputPanelTop;
  w := FColuna2Rect.Left + FColuna2Rect.Width;

  InputPanel.Left := l;
  InputPanel.Top := t;
  InputPanel.Width := w;
  InputPanel.Height := h;

  InputPanel.Color := Rgb(16, 21, 36);
  // InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);
  InputPanel.Font.Size := Round(MeioPanel.Height * INPUT_FONT_SIZE);

  CaretShape.Width := MedeFontesInputPaintBox.Canvas.TextWidth('o');
  StrBuscaLabel.Left := InputPanel.Width - StrBuscaLabel.Width -
    (MargHor * 2 + CaretShape.Width);

  MedeFontesInputPaintBox.Canvas.Font.Assign(InputPanel.Font);
  CaretShape.Brush.Color := InputPanel.Font.Color;
  CaretShape.Left := InputPanel.Width - CaretShape.Width -
    (MargHor * 2 + CaretShape.Width);
  CaretShape.Top := StrBuscaLabel.Top + StrBuscaLabel.Height + MargVer;

  h := Round(CARET_RATIO * CaretShape.Width);
  if h < 1 then
    h := 1;
  CaretShape.Height := h;

  InputPaintPanel1.BringToFront;
  InputPaintPanel2.BringToFront;
  InputPaintPanel3.BringToFront;
  InputPaintPanel4.BringToFront;

  InputPaintPanel1.Left := InputPanel.Left;
  InputPaintPanel1.Top := InputPanel.Top;

  InputPaintPanel2.Left := InputPanel.Left + InputPanel.Width -
    ItemPaintPanel2.Width - 1;
  InputPaintPanel2.Top := InputPanel.Top;

  InputPaintPanel3.Left := InputPanel.Left;
  InputPaintPanel3.Top := InputPanel.Top + InputPanel.Height -
    ItemPaintPanel3.Height - 1;

  InputPaintPanel4.Left := InputPanel.Left + InputPanel.Width -
    ItemPaintPanel2.Width - 1;
  InputPaintPanel4.Top := InputPanel.Top + InputPanel.Height -
    ItemPaintPanel3.Height - 1;

  CaretShape.BringToFront;
end;

procedure TShopVendaPDVFrame.DimensioneItemPanel;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := FItemPanelHeight;
  w := FColuna2Rect.Left + FColuna2Rect.Width;
  t := FItemPanelTop;

  ItemPanel.Left := l;
  ItemPanel.Top := t;
  ItemPanel.Width := w;
  ItemPanel.Height := h;

  ItemPanel.Color := Rgb(16, 21, 36);
  // ItemPanel.BevelOuter := bvNone;
  ItemPanel.Font.Color := Rgb(248, 237, 228);

  ItemDescrLabel.Font.Size := Round(MeioPanel.Height * ITEM_DESCR_FONT_SIZE);
  ItemDescrLabel.Left := MargHor;
  ItemDescrLabel.Top := Round(ItemPanel.Height * ITEM_DESCR_TOP);

  ItemTotalLabel.Font.Size := ItemDescrLabel.Font.Size;
  ItemTotalLabel.Top := ItemDescrLabel.Top;
  ItemTotalLabel.Left := ItemPanel.Width - MargVer - ItemTotalLabel.Width;

  ItemPaintPanel1.BringToFront;
  ItemPaintPanel2.BringToFront;
  ItemPaintPanel3.BringToFront;
  ItemPaintPanel4.BringToFront;

  ItemPaintPanel1.Left := ItemPanel.Left;
  ItemPaintPanel1.Top := ItemPanel.Top;

  ItemPaintPanel2.Left := ItemPanel.Left + ItemPanel.Width -
    ItemPaintPanel2.Width - 1;
  ItemPaintPanel2.Top := ItemPanel.Top;

  ItemPaintPanel3.Left := ItemPanel.Left;
  ItemPaintPanel3.Top := ItemPanel.Top + ItemPanel.Height -
    ItemPaintPanel3.Height - 1;

  ItemPaintPanel4.Left := ItemPanel.Left + ItemPanel.Width -
    ItemPaintPanel2.Width - 1;
  ItemPaintPanel4.Top := ItemPanel.Top + ItemPanel.Height -
    ItemPaintPanel3.Height - 1;
end;

procedure TShopVendaPDVFrame.DimensioneTotalPanel;
begin
  TotalExtPanel.Left := FColuna1Rect.Left;
  TotalExtPanel.Top := FColuna1Rect.Top;
  TotalExtPanel.Width := FColuna1Rect.Right; // Round(FColuna1Rect.Right * 0.6);
  TotalExtPanel.Height := 70;

  TotalLiquidoLabel.Font.Size := Round(MeioPanel.Height * TOTAL_LIQ_FONT_SIZE);
  TotalLiquidoLabel.Top := MargHor;

  VolumesLabel.Font.Size := Round(MeioPanel.Height * VOLUMES_FONT_SIZE);
  VolumesLabel.Top := TotalLiquidoLabel.Top + TotalLiquidoLabel.Height
    + MargHor;
  TotalPanel.Height := VolumesLabel.Top + VolumesLabel.Height + MargHor;
end;

procedure TShopVendaPDVFrame.EngatPegar(pEngat: TVendaProdEngat);
begin
  if pEngat.ProdId > 0 then
  begin
    EngatVender;
  end;
  FEngat.PegarDe(pEngat);
  ItemVendidoExiba(FEngat.DescrRed, FEngat.Preco);
  PreencherControles;
end;

procedure TShopVendaPDVFrame.EngatVender;
var
  oItem: IShopPdvVendaItem;
  bEncontrou: Boolean;
  sMens: string;
  sStrBusca: string;
begin
  if FEngat.ProdId = 0 then
    exit;

  sStrBusca := FEngat.GetStrBusca;
  oItem := FShopAppPDVDBI.ItemCreatePelaStrBusca(sStrBusca, bEncontrou, sMens);

  FEngat.Zerar;
  FStrBusca := '';
  StrBuscaMudou;

  try
    if not bEncontrou then
    begin
      ExibaErro(sMens);
      exit;
    end;

    FShopPDVVenda.Items.Add(oItem);
    ItemVendidoExiba(oItem.Prod.DescrRed, oItem.PrecoBruto);
  finally
    PreencherControles;
  end;
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

  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
    Key := 0;
    // FecharAction_ModuloBasForm.Execute;
    exit;
  end
  else if (Key = VK_F6) and (Shift = []) then
  begin
    AcioneGaveta;
    exit;
  end;

  case Key of
    VK_UP:
      begin
        Key := 0;
        if FitaStringGrid.Row > 0 then
        begin
          FitaStringGrid.Row := FitaStringGrid.Row - 1;
          PaintBoxGrid1.Repaint;
          PaintBoxGrid2.Repaint;
        end;
      end;
    VK_DOWN:
      begin
        Key := 0;
        if FitaStringGrid.Row < FitaStringGrid.RowCount - 1 then
        begin
          FitaStringGrid.Row := FitaStringGrid.Row + 1;
          PaintBoxGrid1.Repaint;
          PaintBoxGrid2.Repaint;
        end;
      end;
    VK_DELETE:
      begin
        Key := 0;
        ItemCancele;
      end;
    VK_PRIOR:
      begin
        Key := 0;
        PDVControlador.VaParaPag;
      end;
    VK_NEXT:
      begin
        Key := 0;
        if FShopPDVVenda.VendaPagList.Count = 0 then
          PDVControlador.PagSomenteDinheiro
        else
          PDVControlador.VaParaPag;
      end;
  end;
end;

procedure TShopVendaPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
var
  dtCanceladoEm: TDateTime;
  bResultado: Boolean;
  sMens: string;
  uQtd: Currency;
begin
  inherited;
  if CharInSet(Key, [',', '.']) then
  begin
    if FStrBusca = '' then
    begin
      StrBuscaPegueChar(Key);
      StrBuscaPegueChar(#13);
      Key := #0;
    end;
  end;

  if Key = #13 then
  begin
    if FEngat.ProdId > 0 then
    begin
      if FStrBusca = '' then
      begin
        key := #0;
        EngatVender;
        FEngat.Zerar;
        ItemVendidoExiba('');
        PreencherControles;
        exit;
      end;
    end;
  end;

  if Key = '*' then
  begin
    if FEngat.ProdId > 0 then
    begin
      if FStrBusca = '' then
      begin
        if ItemQtdPerg(FEngat) then
        begin
          Key := #0;
          ItemVendidoExiba(FEngat.DescrRed, FEngat.Preco);
          PreencherControles;
          exit;
        end;
      end
      else if IsValidFloatString(FStrBusca) then
      begin
        uQtd := StrToCurrency(FStrBusca);
        if ItemQtdValida(uQtd, FEngat.BalancaExige, sMens) then
        begin
          FEngat.Qtd := uQtd;
          FStrBusca := '';
          StrBuscaMudou;
          ItemVendidoExiba(FEngat.DescrRed, FEngat.Preco);
          PreencherControles;
        end
        else
        begin
          ExibaErro(sMens);
        end;
          Key := #0;
          exit;
      end;
      StrBuscaPegueChar(Key);
      StrBuscaPegueChar(#13);
      Key := #0;
    end;
  end;

  if Key = #27 then
  begin
    if FEngat.ProdId > 0 then
    begin
      FEngat.Zerar;
      FStrBusca := '';
      StrBuscaMudou;
      ItemVendidoExiba('');
      PreencherControles;
      Key := #0;
      exit;
    end;

    if PDVVenda.VendaId = 0 then
      exit;

    Key := #0;
    bResultado := PergBool('Deseja cancelar a venda?');
    if not bResultado then
      exit;

    PDVDBI.EstMovCancele(dtCanceladoEm, bResultado, sMens);

    PDVVenda.Cancelado := True;
    PDVControlador.VaParaFinaliza;
    exit;
  end
  else if CharInSet(Key, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.',
    ',', '*', #13, #8]) then
  begin
    StrBuscaPegueChar(Key);
  end;
  CharSemAcento(Key);
  if Pos(Key, 'ABCDEFGHIJKLMNOPQRSTUVWXZ/\|!@#$%&()-_<>"''') > 0 then
  begin
    StrBuscaPegueChar(Key);
    StrBuscaPegueChar(#13);
  end;
end;

procedure TShopVendaPDVFrame.ExibaControles;
begin
  PreencherControles;
  PDVToolBar.Width := PDVToolBar.Width + 1;

  // ControlAlignToCenter(PDVToolBar);

  inherited;

end;

procedure TShopVendaPDVFrame.ExibaErro(pMens: string);
begin
  inherited;
  ItemVendidoExiba(pMens);
end;

procedure TShopVendaPDVFrame.ItemVendidoExiba(pDescr: string; pValor: Currency);
begin
  ItemDescrLabel.Caption := pDescr;
  ItemTotalLabel.Caption := Iif(pValor = 0, '', DinhToStr(pValor));
end;

procedure TShopVendaPDVFrame.ItemVendidoRepaint;
begin
  ItemDescrLabel.Repaint;
  ItemTotalLabel.Repaint;
end;

procedure TShopVendaPDVFrame.ExibaMens(pMens: string);
begin
  ItemVendidoExiba(pMens);
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
  // InputPanel.SetFocus;
end;

procedure TShopVendaPDVFrame.GavetaToolButtonClick(Sender: TObject);
begin
  inherited;
  AcioneGaveta;
end;

function TShopVendaPDVFrame.GetItemUltimoIndex: Integer;
begin
  Result := FShopPDVVenda.Items.Count - 1;
end;

procedure TShopVendaPDVFrame.Iniciar;
var
  bCarregou: Boolean;
begin
  inherited;

  FShopAppPDVDBI.CarregueVendaPendente(bCarregou);
  PreencherControles;
  if FShopPDVVenda.Items.Count = 0 then
    ItemVendidoExiba('');

  SimuleTecla(VK_PRIOR)
end;

procedure TShopVendaPDVFrame.InputPaintBox1Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(0, 0, 29, 29);
end;

procedure TShopVendaPDVFrame.InputPaintBox2Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(-13, 0, 29 - 13, 29);
end;

procedure TShopVendaPDVFrame.InputPaintBox3Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(0, -13, 29, 29 - 13);
end;

procedure TShopVendaPDVFrame.InputPaintBox4Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(-13, -13, 29 - 13, 29 - 13);
end;

procedure TShopVendaPDVFrame.ItemCancele;
var
  bResultado: Boolean;
begin
  if FShopPDVVenda.GetQtdItensAtivos = 0 then
  begin
    ShowMessage('Apagar item:'#13#10'Venda sem itens a cancelar');
    exit;
  end;

  ItemCancelarForm_ShopApp := TItemCancelarForm_ShopApp.Create(FitaStringGrid,
    FShopPDVVenda, FShopAppPDVDBI);
  try
    bResultado := ItemCancelarForm_ShopApp.Perg;

    if bResultado then
      PreencherControles;
  finally
    FreeAndNil(ItemCancelarForm_ShopApp);
  end;
end;

procedure TShopVendaPDVFrame.ItemSelecione(pIndex: Integer);
var
  iMax: Integer;
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
  PaintBoxGrid1.Repaint;
  PaintBoxGrid2.Repaint;
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

  for i := 0 to FShopPDVVenda.Items.Count - 1 do
  begin
    oItem := FShopPDVVenda[i];
    if not oItem.Cancelado then
    begin
      Inc(iQtdVolumes, oItem.QtdVolumes);
      uTotalLiquido := uTotalLiquido + oItem.Preco;
    end;
  end;
  if FEngat.ProdId > 0 then
  begin
    Inc(iQtdVolumes, Iif(CurrencyEhInteiro(FEngat.Qtd), Trunc(FEngat.Qtd), 1));
    uTotalLiquido := uTotalLiquido + FEngat.Preco;
  end;

  s := iQtdVolumes.ToString;
  VolumesLabel.Caption := 'Volumes: ' + s;

  s := DinhToStr(uTotalLiquido);
  TotalLiquidoLabel.Caption := 'Total: ' + s;

  ItemSelecione;
end;

procedure TShopVendaPDVFrame.StrBuscaExec;
var
  oItem: IShopPdvVendaItem;
  bEncontrou: Boolean;
  sMens: string;
  sStrBusca: string;
  eResultado: TPDVBuscaResultado;

  sBusca: string;

  rEngat: TVendaProdEngat;
begin
  try
    eResultado := BuscaNumericaStatus(FStrBusca);
    if eResultado in PDVBuscaResultadosAbreSelect then
    begin
      if not FProdSelect.Execute(FStrBusca) then
      begin
        FStrBusca := '';
        StrBuscaMudou;
        if FEngat.ProdId > 0 then
          ItemVendidoExiba(FEngat.DescrRed, FEngat.Preco)
        else
          ItemVendidoExiba('');
        exit;
      end;
      sStrBusca := StrAntes(FProdSelect.LastSelected, ';');
      FStrBusca := sStrBusca;
    end;

    SepareBuscaStr(FStrBusca, sBusca, rEngat.Qtd);

    FShopAppPDVDBI.StrBuscaToProd(sBusca, rEngat, bEncontrou, sMens);
    if not bEncontrou then
    begin
      ExibaErro(sMens);
      exit;
    end;

    if not ItemQtdValida(rEngat.Qtd, rEngat.BalancaExige, sMens) then
    begin
      ExibaErro(sMens);
      exit;
    end;

    EngatPegar(rEngat);
    FStrBusca := '';
    StrBuscaMudou;
    ItemVendidoExiba(FEngat.DescrRed, FEngat.Preco);
  finally
    PreencherControles;
  end;
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
      exit;
    end;

    if pChar = #13 then
    begin
      StrBuscaExec;
      exit;
    end;

    CharSemAcento(pChar);
    FStrBusca := FStrBusca + pChar;
  finally
    StrBuscaMudou;
  end;
end;

procedure TShopVendaPDVFrame.PagamentoToolButtonClick(Sender: TObject);
var
    uTotalLiquido: Currency;
    uTotalDevido: Currency;
    uTotalEntregue: Currency;
    uFalta: Currency;
    uTroco: Currency;
begin
  inherited;
  EngatVender;

  PDVVenda.ItensPegarTots(uTotalLiquido, uTotalDevido, uTotalEntregue,
    uFalta, uTroco);
  if uTotalLiquido = 0 then
  begin
    ShowMessage('O Total líquido da venda está zerado');
    exit;
  end;

  PDVControlador.VaParaPag;
end;

procedure TShopVendaPDVFrame.PagSomenteDinheiroToolButtonClick(Sender: TObject);
var
    uTotalLiquido: Currency;
    uTotalDevido: Currency;
    uTotalEntregue: Currency;
    uFalta: Currency;
    uTroco: Currency;
begin
  inherited;
  EngatVender;

  PDVVenda.ItensPegarTots(uTotalLiquido, uTotalDevido, uTotalEntregue,
    uFalta, uTroco);
  if uTotalLiquido = 0 then
  begin
    ShowMessage('O Total líquido da venda está zerado');
    exit;
  end;

  PDVControlador.PagSomenteDinheiro;
end;

procedure TShopVendaPDVFrame.PaintBox1Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := AZUL_CLARO_COR;
  p.Canvas.Ellipse(0, 0, 29, 29);
end;

procedure TShopVendaPDVFrame.PaintBox2Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := AZUL_CLARO_COR;
  p.Canvas.Ellipse(-13, 0, 29 - 13, 29);
end;

procedure TShopVendaPDVFrame.PaintBox3Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := AZUL_CLARO_COR;
  p.Canvas.Ellipse(0, -13, 29, 29 - 13);
end;

procedure TShopVendaPDVFrame.PaintBox4Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := AZUL_CLARO_COR;
  p.Canvas.Ellipse(-13, -13, 29 - 13, 29 - 13);
end;

procedure TShopVendaPDVFrame.PaintBoxGrid1Paint(Sender: TObject);
var
  p: TPaintBox;
  cor: TColor;
begin
  inherited;
  if FitaStringGrid.Row = 0 then
    cor := AZUL_CLARO_COR
  else
    cor := FitaStringGrid.Color;

  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := cor;
  p.Canvas.Ellipse(0, 0, 29, 29);
end;

procedure TShopVendaPDVFrame.PaintBoxGrid2Paint(Sender: TObject);
var
  p: TPaintBox;
  cor: TColor;
begin
  inherited;
  if FitaStringGrid.Row = 0 then
    cor := AZUL_CLARO_COR
  else
    cor := FitaStringGrid.Color;

  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := cor;
  p.Canvas.Ellipse(-13, 0, 29 - 13, 29);
end;

procedure TShopVendaPDVFrame.PaintBoxGrid3Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := clWhite;
  p.Canvas.Ellipse(0, -13, 29, 29 - 13);
end;

procedure TShopVendaPDVFrame.PaintBoxGrid4Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := clWhite;
  p.Canvas.Ellipse(-13, -13, 29 - 13, 29 - 13);
end;

procedure TShopVendaPDVFrame.ItemCanceleToolButtonClick(Sender: TObject);
begin
  inherited;
  ItemCancele;
end;

procedure TShopVendaPDVFrame.ItemPaintBox1Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(0, 0, 29, 29);
end;

procedure TShopVendaPDVFrame.ItemPaintBox2Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(-13, 0, 29 - 13, 29);
end;

procedure TShopVendaPDVFrame.ItemPaintBox3Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(0, -13, 29, 29 - 13);
end;

procedure TShopVendaPDVFrame.ItemPaintBox4Paint(Sender: TObject);
var
  p: TPaintBox;
begin
  inherited;
  p := TPaintBox(Sender);
  p.Canvas.pen.Style := psClear;
  p.Canvas.Brush.Style := bsSolid;
  p.Canvas.Brush.Color := CINZA_FUNDO_COR;
  p.Canvas.rectangle(0, 0, 16, 16);
  p.Canvas.Brush.Color := PRETO_INTERNO_COR;
  p.Canvas.Ellipse(-13, -13, 29 - 13, 29 - 13);
end;

procedure TShopVendaPDVFrame.ItemZerar;
begin

end;

end.
