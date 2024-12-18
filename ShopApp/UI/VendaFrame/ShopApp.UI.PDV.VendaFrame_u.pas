unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types,
  Vcl.Grids;

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
    procedure CaretTimerTimer(Sender: TObject);
    procedure ListBox1Enter(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    FStrBusca: string;
    procedure DimensioneItemPanel;
    procedure DimensioneInput;
    procedure DimensioneFitaStringGrid;
    procedure StrBuscaPegueChar(pChar: Char);
    procedure StrBuscaExec;
    procedure StrBuscaMudou;
    procedure ZerarItem;
  public
    { Public declarations }
    procedure DimensioneControles; override;
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;

    procedure Iniciar; override;

    constructor Create(AOwner: TComponent); override;

  end;

var
  ShopVendaPDVFrame: TShopVendaPDVFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.UI.Controls.Utils;

{ TShopVendaPDVFrame }

procedure TShopVendaPDVFrame.CaretTimerTimer(Sender: TObject);
begin
  inherited;
  CaretShape.Visible := not CaretShape.Visible;
end;

constructor TShopVendaPDVFrame.Create(AOwner: TComponent);
begin
  inherited;
  FStrBusca := '';
  ItemDescrLabel.Caption := '';
  ItemTotalLabel.Caption := '';
end;

procedure TShopVendaPDVFrame.DimensioneControles;
var
  MargHor: integer;
  MargVer: integer;
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
end;

procedure TShopVendaPDVFrame.DimensioneFitaStringGrid;
var
  l, t, w, h: integer;
begin
  l := FColuna2Rect.Left;
  h := (FColuna2Rect.Height * 56) div 80;
  t := FColuna2Rect.Top;
  w := FColuna2Rect.Width;

  FitaStringGrid.Left := l;
  FitaStringGrid.Top := t;
  FitaStringGrid.Width := w;
  FitaStringGrid.Height := h;
end;

procedure TShopVendaPDVFrame.DimensioneInput;
var
  l, t, w, h: integer;
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
//  InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);

  CaretShape.Brush.Color := InputPanel.Font.Color;
end;

procedure TShopVendaPDVFrame.DimensioneItemPanel;
var
  l, t, w, h: integer;
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
//  ItemPanel.BevelOuter := bvNone;
  ItemPanel.Font.Color := Rgb(248, 237, 228);
end;

procedure TShopVendaPDVFrame.ExecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

end;

procedure TShopVendaPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  StrBuscaPegueChar(Key);
end;

procedure TShopVendaPDVFrame.Iniciar;
begin
  inherited;
  DigiteStr('2', 0);
end;

procedure TShopVendaPDVFrame.ListBox1Enter(Sender: TObject);
begin
  inherited;
  InputPanel.SetFocus;
end;

procedure TShopVendaPDVFrame.StrBuscaExec;
begin
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
      exit;
    end
    else if pChar = #13 then
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

procedure TShopVendaPDVFrame.ZerarItem;
begin

end;

end.
