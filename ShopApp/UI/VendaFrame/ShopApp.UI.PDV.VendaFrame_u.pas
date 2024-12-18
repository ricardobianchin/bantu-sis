unit ShopApp.UI.PDV.VendaFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types;

type
  TShopVendaPDVFrame = class(TVendaBasPDVFrame)
    InputPanel: TPanel;
    BuscaLabel: TLabel;
    CaretTimer: TTimer;
    CaretShape: TShape;
    procedure CaretTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FColuna1Rect, FColuna2Rect: TRect;
    procedure DimensioneInput;
  public
    { Public declarations }
    procedure DimensioneControles; override;
  end;

var
  ShopVendaPDVFrame: TShopVendaPDVFrame;

implementation

{$R *.dfm}
{ TShopVendaPDVFrame }

procedure TShopVendaPDVFrame.CaretTimerTimer(Sender: TObject);
begin
  inherited;
  CaretShape.Visible := not CaretShape.Visible;
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
  InputPanel.BevelOuter := bvNone;
  InputPanel.Font.Color := Rgb(248, 237, 228);

  CaretShape.Brush.Color := InputPanel.Font.Color;
end;

end.
