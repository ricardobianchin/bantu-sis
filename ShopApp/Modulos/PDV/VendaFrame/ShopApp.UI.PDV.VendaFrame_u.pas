unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types,
  Vcl.Grids, App.PDV.Venda, ShopApp.PDV.Venda, ShopApp.PDV.VendaItem,
  App.PDV.DBI, ShopApp.PDV.DBI, ShopApp.UI.PDV.Venda.Frame.FitaDraw,
  Vcl.ComCtrls, Vcl.ToolWin, App.PDV.Controlador, ShopApp.PDV.Obj,
  Sis.UI.Select, Sis.DBI, Sis.UI.Frame.Bas.Filtro_u;

const
  // GUTTER espaço entre colunas
  MARGEM = 1 / 205;
  ENTRE_COLS_LARG = 1 / 40{estava 1/25};
  PROD_PANEL_ALT = 1 / 8;
  ENTRE_PROD_PANEL_ALT = 1 / 80;
  INPUT_FONT_SIZE = 25 / 616;
  CARET_RATIO = 5 / 19;
  ITEM_DESCR_FONT_SIZE = 22 / 616;
  ITEM_DESCR_TOP = 27 / 72;
  TOTAL_LIQ_FONT_SIZE = 20 / 616;
  VOLUMES_FONT_SIZE = 12 / 616;


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
    TotalLiquidoLabel: TLabel;
    VolumesLabel: TLabel;
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
    procedure CaretTimerTimer(Sender: TObject);
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FitaStringGridEnter(Sender: TObject);
    procedure ItemCanceleToolButtonClick(Sender: TObject);
    procedure PagSomenteDinheiroToolButtonClick(Sender: TObject);
    procedure PagamentoToolButtonClick(Sender: TObject);
    procedure GavetaToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    FStrBusca: string;
    FShopPDVVenda: IShopPDVVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FFitaDraw: IShopFitaDraw;
    FShopPDVObj: IShopPDVObj;
    FProdSelect: ISelect;

    FItemPanelTop: integer;
    FItemPanelHeight: integer;

    FInputPanelTop: integer;
    FInputPanelHeight: integer;

  MargHor: integer;
  MargVer: integer;
  LargUtil: integer;
  AltuUtil: integer;

    procedure DimensioneItemPanel;
    procedure DimensioneInput;
    procedure DimensioneFitaStringGrid;
    procedure DimensioneTotalPanel;

    procedure StrBuscaPegueChar(pChar: Char);
    procedure StrBuscaExec; // ADICIONA ITEM
    procedure StrBuscaMudou;

    procedure ItemZerar;
    procedure PreencherControles;

    procedure ItemVendidoExiba(pDescr: string; pValor: Currency = 0);
    procedure ItemVendidoRepaint;

    procedure ItemCancele;
    procedure ItemSelecione(pIndex: Integer = -1);
    function GetItemUltimoIndex: Integer;

    procedure AcioneGaveta;
  protected
    procedure ExibaControles; override;

  public
    { Public declarations }
    procedure ExibaErro(pMens: string); override;
    procedure ExibaMens(pMens: string); override;
    procedure DimensioneControles; override;

    // TECLADO KEYDOWN
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

    // TECLADO PRESS
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;

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
  Sis.UI.IO.Input.Perg, Sis.UI.Controls.Factory,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u;

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
  FShopPDVObj := pShopPDVObj;
  FShopPDVVenda := VendaAppCastToShopApp(pPDVVenda);
  FShopAppPDVDBI := DBIAppCastToShopApp(pAppPDVDBI);
  FFitaDraw := FitaDrawCreate(VendaAppCastToShopApp(pPDVVenda), FitaStringGrid, MedeFontesGridPaintBox);
  FProdSelect := pProdSelect;

  FStrBusca := '';
  ItemDescrLabel.Caption := '';
  ItemTotalLabel.Caption := '';
end;

procedure TShopVendaPDVFrame.DimensioneControles;

//  QTD_COLS = 2;
//  GUTTERS_TOTAL = GUTTER * (QTD_COLUNAS - 1);
//  LARG_COLUNA = (LARG_UTIL - GUTTERS_TOTAL) div QTD_COLUNAS;
var
  EntreColsLarg: integer;
  ColunaLarg: integer;
  ColunaAltu: integer;

  EntrePanelsAltu: integer;

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
  FColuna1Rect.width := ColunaLarg;
  FColuna1Rect.Height := ColunaAltu;

  FColuna2Rect.Left := FColuna1Rect.Left + FColuna1Rect.width + EntreColsLarg;
  FColuna2Rect.Top := FColuna1Rect.Top;
  FColuna2Rect.width := FColuna1Rect.width;
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
//  w := (FitaStringGrid.Canvas.TextWidth('W') * ((CUPOM_QTD_COLS * 2) + 1)) div 2;
//  iDir := ItemPanel.Left + ItemPanel.width;
//  l := iDir - w;
//  FitaStringGrid.Left := l;

  FitaStringGrid.Left := FColuna2Rect.Left;
  FitaStringGrid.Top := FColuna2Rect.Top;
  FitaStringGrid.width := FColuna2Rect.Width;
  FitaStringGrid.Height := FColuna2Rect.Height;

  FitaStringGrid.DefaultColWidth := FitaStringGrid.width;

  FFitaDraw.Prepare;
end;

procedure TShopVendaPDVFrame.DimensioneInput;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := FInputPanelHeight;
  t := FInputPanelTop;
  w := FColuna2Rect.Left + FColuna2Rect.width;

  InputPanel.Left := l;
  InputPanel.Top := t;
  InputPanel.width := w;
  InputPanel.Height := h;

  InputPanel.Color := Rgb(16, 21, 36);
  // InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);
  InputPanel.Font.Size := Round(MeioPanel.Height * INPUT_FONT_SIZE);

  StrBuscaLabel.Left := InputPanel.Width - StrBuscaLabel.Width - MargHor;

  MedeFontesInputPaintBox.Canvas.Font.Assign(InputPanel.Font);
  CaretShape.Width := MedeFontesInputPaintBox.Canvas.TextWidth('o');
  CaretShape.Brush.Color := InputPanel.Font.Color;
  CaretShape.left := InputPanel.Width - CaretShape.Width - MargHor;
  CaretShape.Top := StrBuscaLabel.Top + StrBuscaLabel.Height + MargVer;

  h := Round(CARET_RATIO * CaretShape.Width);
  if h < 1 then
    h := 1;
  CaretShape.Height := h;
end;

procedure TShopVendaPDVFrame.DimensioneItemPanel;
var
  l, t, w, h: Integer;
begin
  l := FColuna1Rect.Left;
  h := FItemPanelHeight;
  w := FColuna2Rect.Left + FColuna2Rect.width;
  t := FItemPanelTop;

  ItemPanel.Left := l;
  ItemPanel.Top := t;
  ItemPanel.width := w;
  ItemPanel.Height := h;

  ItemPanel.Color := Rgb(16, 21, 36);
  // ItemPanel.BevelOuter := bvNone;
  ItemPanel.Font.Color := Rgb(248, 237, 228);

  ItemDescrLabel.Font.Size := Round(MeioPanel.Height * ITEM_DESCR_FONT_SIZE);
  ItemDescrLabel.Left := MargHor;
  ItemDescrLabel.Top := Round(ItemPanel.Height * ITEM_DESCR_TOP);

  ItemTotalLabel.Font.Size := ItemDescrLabel.Font.Size;
  ItemTotalLabel.Top := ItemDescrLabel.Top;
  ItemTotalLabel.Left := ItemPanel.WIdth - MargVer - ItemTotalLabel.Width;


end;

procedure TShopVendaPDVFrame.DimensioneTotalPanel;
begin
  TotalPanel.Left := FColuna1Rect.Left;
  TotalPanel.Top := FColuna1Rect.Top;
  TotalPanel.Width := Round(FColuna1Rect.Width * 0.6);

  TotalLiquidoLabel.Font.Size := Round(MeioPanel.height * TOTAL_LIQ_FONT_SIZE);
  TotalLiquidoLabel.Top := MargHor;

  VolumesLabel.Font.Size := Round(MeioPanel.height * VOLUMES_FONT_SIZE);
  VolumesLabel.Top := TotalLiquidoLabel.Top + TotalLiquidoLabel.Height + MargHor;
  TotalPanel.Height := VolumesLabel.Top + VolumesLabel.Height + MargHor;
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
    Exit;
  end
  else if (Key = VK_F5) and (Shift = []) then
  begin
    AcioneGaveta;
    Exit;
  end;

  case Key of
    VK_UP:
      begin
        Key := 0;
        if FitaStringGrid.Row > 0 then
          FitaStringGrid.Row := FitaStringGrid.Row - 1;
      end;
    VK_DOWN:
      begin
        Key := 0;
        if FitaStringGrid.Row < FitaStringGrid.RowCount - 1 then
          FitaStringGrid.Row := FitaStringGrid.Row + 1;
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
begin
  inherited;
  if Key = #27 then
  begin
    if PDVVenda.VendaId = 0 then
      Exit;

    Key := #0;

    bResultado := PergBool('Deseja cancelar a venda?');
    if not bResultado then
      Exit;

    PDVDBI.EstMovCancele(dtCanceladoEm, bResultado, sMens);

    PDVVenda.Cancelado := True;
    PDVControlador.VaParaFinaliza;
    Exit;
  end
  else if CharInSet(Key, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.',
    ',', '*', #13, #8]) then
  begin
    StrBuscaPegueChar(Key);
  end;
  CharSemAcento(Key);
  if Pos(Key, 'ABCDEFGHIJKLMNOPQRSTUVWXZ') > 0 then
  begin
    StrBuscaPegueChar(Key);
    StrBuscaPegueChar(#13);
  end;
end;

procedure TShopVendaPDVFrame.ExibaControles;
begin
  PreencherControles;
  PDVToolBar.width := PDVToolBar.width + 1;

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

procedure TShopVendaPDVFrame.ItemCancele;
var
  bResultado: Boolean;
begin
  if FitaStringGrid.RowCount = 0 then
  begin
    ShowMessage('Nenhum item a cancelar');
    Exit;
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
    Exit;

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

  for i := 0 to FShopPDVVenda.Items.Count - 1 do
  begin
    oItem := FShopPDVVenda[i];
    if not oItem.Cancelado then
    begin
      Inc(iQtdVolumes, oItem.QtdVolumes);
      uTotalLiquido := uTotalLiquido + oItem.Preco;
    end;
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
  sMensagem: string;
begin
  if not StrIsOnlyDigit(FStrBusca) then
  begin
    if not FProdSelect.Execute(FStrBusca) then
    begin
      FStrBusca := '';
      StrBuscaMudou;
      Exit;
    end;
    FStrBusca := FProdSelect.LastSelected;
  end;

  // recebe codigo, retorna item vendido, ou, avisa que nao encontrou
  oItem := FShopAppPDVDBI.ItemCreatePelaStrBusca(FStrBusca, bEncontrou,
    sMensagem);

  FStrBusca := '';
  StrBuscaMudou;

  try
    if not bEncontrou then
    begin
      ExibaErro(sMensagem);
      Exit;
    end;

    FShopPDVVenda.Items.Add(oItem);
    ItemVendidoExiba(oItem.Prod.DescrRed, oItem.PrecoBruto);
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
      Exit;
    end;

    if pChar = #13 then
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

procedure TShopVendaPDVFrame.PagamentoToolButtonClick(Sender: TObject);
begin
  inherited;
  PDVControlador.VaParaPag;
end;

procedure TShopVendaPDVFrame.PagSomenteDinheiroToolButtonClick(Sender: TObject);
begin
  inherited;
  PDVControlador.PagSomenteDinheiro;
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
