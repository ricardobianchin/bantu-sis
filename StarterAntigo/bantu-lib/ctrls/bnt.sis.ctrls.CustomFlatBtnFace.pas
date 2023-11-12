unit bnt.sis.ctrls.CustomFlatBtnFace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TCustomFlatBtnFace = class(TGraphicControl)
  private
    FHoverColor: TColor;
    FPressed: Boolean;
    FMouseOver: Boolean;
    FFocused: Boolean;

    procedure SetHoverColor(const Value: TColor);
    procedure SetFocused(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HoverColor: TColor read FHoverColor write SetHoverColor;
    property Focused: Boolean read FFocused write SetFocused;
  published
  end;

implementation

function AdjustLuminosity(Color: TColor; LuminosityFactor: Double): TColor;
var
  R, G, B: Byte;
begin
  Color := ColorToRGB(Color);
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);

  if LuminosityFactor < 1 then
  begin
    R := Round(R * LuminosityFactor);
    G := Round(G * LuminosityFactor);
    B := Round(B * LuminosityFactor);
  end
  else
  begin
    R := Round(R + (255 - R) * (LuminosityFactor - 1));
    G := Round(G + (255 - G) * (LuminosityFactor - 1));
    B := Round(B + (255 - B) * (LuminosityFactor - 1));
  end;

  Result := RGB(R, G, B);
end;


{ TCustomFlatBtn }

procedure TCustomFlatBtnFace.CMMouseEnter(var Message: TMessage);
begin
  if not FMouseOver then
  begin
    FMouseOver := True;
    Invalidate;
  end;
end;

procedure TCustomFlatBtnFace.CMMouseLeave(var Message: TMessage);
begin
  if FMouseOver then
  begin
    FMouseOver := False;
    Invalidate;
  end;
end;

constructor TCustomFlatBtnFace.Create(AOwner: TComponent);
begin
  inherited;
  FFocused := False;
  FMouseOver := false;

  Color := $009A5E14; // RGB(103, 103, 102);
  FHoverColor := AdjustLuminosity(Color, 1.23); //RGB(127, 127, 126);
  Font.Color := clWhite; RGB(227, 227, 226);
  Font.Name := 'Segoe UI';
  Font.Size := 9;
  StyleElements := [];
  Parent := TWinControl(AOwner);
  Align := alClient;
end;

destructor TCustomFlatBtnFace.Destroy;
begin
  inherited;
end;

procedure TCustomFlatBtnFace.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressed := True;
    //Invalidate;
  end;
end;

procedure TCustomFlatBtnFace.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressed := False;
//    Invalidate;
  end;
end;

procedure TCustomFlatBtnFace.Paint;
var
  x, y: integer;
begin
  inherited;
  Canvas.Font.Assign(Font);

//  if FPressed then
//    Canvas.Brush.Color := FHoverColor
//  else
  if FMouseOver then
    Canvas.Brush.Color := FHoverColor
  else
    Canvas.Brush.Color := Color;

  if FFocused and Enabled then
  begin
    Canvas.Pen.Color := Font.Color;
    Canvas.Pen.Width := 2;
    Canvas.Rectangle(1,1,width, Height);
    Canvas.Pen.Width := 1;
  end
  else
  begin
    Canvas.FillRect(ClientRect);
  end;

  x := 8;
  if Assigned(Action) then
  begin
    if Assigned(TAction(Action).Images) then
    begin
      y := (Height-TAction(Action).Images.Height) div 2;
      TAction(Action).Images.Draw(Canvas, X, Y,
        TAction(Action).ImageIndex, enabled);
      x := x + TAction(Action).Images.Width + 4;
    end;
  end;
  y := (Height-Canvas.TextHeight(Caption)) div 2;

  Canvas.TextOut(x, y, Caption);
end;

procedure TCustomFlatBtnFace.SetFocused(const Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    Invalidate;
  end;
end;

procedure TCustomFlatBtnFace.SetHoverColor(const Value: TColor);
begin
  if FHoverColor <> Value then
  begin
    FHoverColor := Value;
    Invalidate;
  end;
end;

end.
