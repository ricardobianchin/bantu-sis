unit CustomFlatBtn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TCustomFlatBtn = class(TWinControl)
  private
    FImageList: TImageList;
    FImageIndex: integer;
    FCanvas: TCanvas;
    FOnPaint: TNotifyEvent;

    FColor: TColor;
    FPressed: Boolean;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
  protected
    { Protected declarations }
    procedure Paint; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Color: TColor read FColor write FColor default clBtnFace;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property Canvas: TCanvas read FCanvas;
  end;


implementation

{ TCustomFlatBtn }

constructor TCustomFlatBtn.Create(AOwner: TComponent);
begin
  inherited;
  FCanvas := TControlCanvas.Create;
  Canvas.Handle := GetDC(Handle);
end;

destructor TCustomFlatBtn.Destroy;
begin
  ReleaseDC(Handle, Canvas.Handle);
  Canvas.Free;
  inherited;
end;

procedure TCustomFlatBtn.Paint;
begin
  Canvas.Brush.Color := FColor;
  Canvas.FillRect(ClientRect);
  if FPressed then
    Canvas.Pen.Color := clHighlight
  else
    Canvas.Pen.Color := clWindowText;
  Canvas.Ellipse(Width div 2 - 6, Height div 2 - 6, Width div 2 + 6, Height div 2 + 6);
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

procedure TCustomFlatBtn.WMLButtonDown(var Message: TWMLButtonDown);
begin
  FPressed := True;
  Invalidate; // force repaint
end;

procedure TCustomFlatBtn.WMLButtonUp(var Message: TWMLButtonUp);
begin
  FPressed := False;
  Invalidate; // force repaint
end;

procedure TCustomFlatBtn.WMPaint(var Message: TWMPaint);
begin
  Paint; // custom paint method
end;

end.
