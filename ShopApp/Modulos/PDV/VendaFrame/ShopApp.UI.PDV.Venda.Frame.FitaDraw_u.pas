unit ShopApp.UI.PDV.Venda.Frame.FitaDraw_u;

interface

uses ShopApp.UI.PDV.Venda.Frame.FitaDraw, ShopApp.PDV.Venda, Vcl.Grids,
  System.Types, System.Classes, Vcl.Graphics, Sis.Types, Vcl.ExtCtrls;

type
  TShopFitaDraw = class(TInterfacedObject, IShopFitaDraw)
  private
    FVenda: IShopPDVVenda;
    FStringGrid: TStringGrid;
    FHLin: integer;
    CabecalhoLinhasSL: TStringList;
    MedeFontesPaintBox: TPaintBox;
    TestText: string;

    procedure AdjustFontSize;
    procedure DiminuaFonte;
    procedure AumenteFonte;

    procedure PreenchaStringGrid;
    procedure DrawCabecalho(pRect: TRect; State: TGridDrawState);
    procedure DrawItem(ARow: integer; pRect: TRect; State: TGridDrawState);
  public
    procedure Prepare;
    procedure Atualize;
    procedure FitaStringGridDrawCell(Sender: TObject; ACol, ARow: integer;
      Rect: TRect; State: TGridDrawState);

    constructor Create(pVenda: IShopPDVVenda; pStringGrid: TStringGrid; pMedeFontesPaintBox: TPaintBox);
    destructor Destroy; override;

  end;

implementation

uses Sis.Types.Bool_u, Sis.Types.Codigos.Utils, System.SysUtils,
  ShopApp.PDV.VendaItem, Sis.Types.strings_u, Sis.Types.Floats;

{ TShopFitaDraw }

procedure TShopFitaDraw.Atualize;
begin
  PreenchaStringGrid;
end;

procedure TShopFitaDraw.AumenteFonte;
begin

end;

constructor TShopFitaDraw.Create(pVenda: IShopPDVVenda;
  pStringGrid: TStringGrid; pMedeFontesPaintBox: TPaintBox);
var
  sC: string;
begin
  TestText := StringOfChar('M', 51); // String de teste com 51 "M"s

  MedeFontesPaintBox := pMedeFontesPaintBox;
  FVenda := pVenda;
  FStringGrid := pStringGrid;
  FStringGrid.RowCount := 1;
  sC := FVenda.Loja.C;
  if sC <> '' then
  begin
    sC := CodComMasc(sC);
  end;

  CabecalhoLinhasSL := TStringList.Create;
  CabecalhoLinhasSL.Add(FVenda.Loja.Nome);
  if sC <> '' then
    CabecalhoLinhasSL.Add(sC);

end;

procedure TShopFitaDraw.AdjustFontSize;
var
  MinSize, MaxSize, MidSize, TextWidth: Integer;
  TargetWidth: Integer;
begin
  TargetWidth := FStringGrid.Width;
  MedeFontesPaintBox.Canvas.Font.Assign(FStringGrid.Font); // Sincroniza a fonte

  MinSize := 1;  // Tamanho m�nimo
  MaxSize := 20; // Tamanho m�ximo

  // Busca bin�ria
  while MinSize <= MaxSize do
  begin
    MidSize := (MinSize + MaxSize) div 2;
    MedeFontesPaintBox.Canvas.Font.Size := MidSize;
    TextWidth := MedeFontesPaintBox.Canvas.TextWidth(TestText); // Recalcula a cada itera��o

    if Abs(TextWidth - TargetWidth) < 10 then // Toler�ncia de 10 pixels
      Break
    else if TextWidth < TargetWidth then
      MinSize := MidSize + 1
    else
      MaxSize := MidSize - 1;
  end;

  // Ajusta para o maior tamanho que n�o excede (ou o �ltimo calculado)
  FStringGrid.Font.Size := MedeFontesPaintBox.Canvas.Font.Size;

end;

destructor TShopFitaDraw.Destroy;
begin
  CabecalhoLinhasSL.Free;
  inherited;
end;

procedure TShopFitaDraw.DiminuaFonte;
begin

end;

procedure TShopFitaDraw.DrawCabecalho(pRect: TRect; State: TGridDrawState);
var
  i: integer;
  s: string;
  y: integer;
  TextFormat: TTextFormat;
  rRect: TRect;
begin
  TextFormat := [tfCenter, tfTop];
  for i := 0 to CabecalhoLinhasSL.Count - 1 do
  begin
    s := CabecalhoLinhasSL[i];
    y := FHLin * i; // + 1;
    rRect := Rect(pRect.Left, y, pRect.Right, pRect.Bottom);
    FStringGrid.Canvas.TextRect(rRect, s, TextFormat);
  end;

end;

procedure TShopFitaDraw.DrawItem(ARow: integer; pRect: TRect;
  State: TGridDrawState);
var
  y: integer;
  s: string;
  oItem: IShopPDVVendaItem;
  // iPosQtd: integer;
  // iPosPrecoUnit: integer;
  // iPosPreco: integer;
begin
  // iPosQtd := 12;
  // iPosPrecoUnit := 30;
  // f  iPosPreco := 40;

  oItem := FVenda[ARow];

  s := oItem.AsLinha1;
  y := pRect.Top;
  FStringGrid.Canvas.TextOut(pRect.Left, y, s);

  s := oItem.AsLinha2;
  inc(y, FHLin);
  FStringGrid.Canvas.TextOut(pRect.Left, y, s);

  s := oItem.AsLinha3;
  inc(y, FHLin);
  FStringGrid.Canvas.TextOut(pRect.Left, y, s);
end;

procedure TShopFitaDraw.FitaStringGridDrawCell(Sender: TObject;
  ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow = 0 then
    DrawCabecalho(Rect, State)
  else
    DrawItem(ARow - 1, Rect, State)
    {
      TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected,
      gdHotTrack, gdPressed);

    }
end;

procedure TShopFitaDraw.PreenchaStringGrid;
var
  iRowCount: integer;
begin
  // iRowCount := Iif(FVenda.Count = 0, 1, FVenda.Count);
  iRowCount := FVenda.Items.Count + 1;

  FStringGrid.RowCount := iRowCount;
  FStringGrid.Repaint;
end;

procedure TShopFitaDraw.Prepare;
begin
  AdjustFontSize;

  if FStringGrid.RowCount < 1 then
    FStringGrid.RowCount := 1;
  FHLin := (FStringGrid.Canvas.TextHeight('H�gj') * 14) div 10;
  FStringGrid.DefaultRowHeight := FHLin * 3 + 1;
  FStringGrid.RowHeights[0] := FHLin * CabecalhoLinhasSL.Count + 1;
end;

end.
