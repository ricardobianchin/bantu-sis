unit CustomFlatBtn_antigo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TCustomFlatBtn = class(TWinControl)
  private
    FImageList: TImageList;
    FImageIndex: integer;

    FPressed: boolean;
    FCanvas: TCanvas;
    FOnPaint: TNotifyEvent; // declare a field to store the event handler

    FHoverColor: TColor;

    FAction: TAction;

    FChildHandle: HWND; // handle of the child window

    procedure ChildWndProc(var Message: TMessage); // window procedure of the child window
    procedure SetOnPaint(Value: TNotifyEvent); // declare a method to set the event handler
    procedure DoPaint{(DC: HDC)}; // custom painting method
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;


    procedure SetAction(const Value: TAction);
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);override;
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
    function IsOnClickStored: Boolean;


  published
    property OnPaint: TNotifyEvent read FOnPaint write SetOnPaint; // declare a property to expose the event handler



  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    property HoverColor: TColor read FHoverColor write FHoverColor;

    property Action: TAction read FAction write SetAction;
    property ImageList: TImageList read FImageList write FImageList;
    property ImageIndex: integer read FImageIndex write FImageIndex;
    property Canvas: TCanvas read FCanvas;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
  end;

implementation

{ TCustomFlatBtn }

procedure TCustomFlatBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
//  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TAction then
  begin
    if not CheckDefaults or (Caption = '') then
      Caption := TAction(Sender).Caption;
    if not CheckDefaults or (Hint = '') then
      Hint := TAction(Sender).Hint;
    if not CheckDefaults or not Assigned(OnClick) then
      OnClick := TAction(Sender).OnExecute;
  end;
end;

procedure TCustomFlatBtn.ChildWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_PAINT: // handle the paint message of the child window
      begin
        DoPaint{(Message.WParam)}; // call the custom painting method with the device context of the child window
        Message.Result := 0; // return zero to indicate that the message is processed
      end;
    else // for other messages, call the default window procedure of the child window
      with Message do
        Result := CallWindowProc(Pointer(GetWindowLong(FChildHandle, GWL_USERDATA)),
          FChildHandle, Msg, WParam, LParam);
  end;
end;

constructor TCustomFlatBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Parent := TWinControl(AOwner);
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
//  FCanvas.Handle := GetDC(Handle);

  // create a child window that covers the entire client area of the component
  FChildHandle := CreateWindow('STATIC', nil, WS_CHILD or WS_VISIBLE,
    0, 0, Width, Height, Handle, 0, HInstance, nil);
  // subclass the child window to intercept its messages
  SetWindowLong(FChildHandle, GWL_WNDPROC, Longint(MakeObjectInstance(ChildWndProc)));



  Width := 250;
  Height := 49;
  Font.Name := 'Segoe';
  Font.Size := 10;
  Color := RGB(103, 103, 102);
  HoverColor := RGB(127, 127, 126);
end;

destructor TCustomFlatBtn.Destroy;
begin
//  ReleaseDC(Handle, FCanvas.Handle);
  // restore the original window procedure of the child window
  SetWindowLong(FChildHandle, GWL_WNDPROC, GetWindowLong(FChildHandle, GWL_USERDATA));
  // destroy the child window
  DestroyWindow(FChildHandle);
  // other finalization code

  FCanvas.Free;
  inherited Destroy;
end;

procedure TCustomFlatBtn.DoPaint{(DC: HDC)};
var
  R: TRect;
begin
  try
//    Canvas.Handle := DC; // assign the device context of the child window to the canvas handle
    Canvas.Font.Assign(Font); // assign the font of the component to the canvas font
    Canvas.Brush.Color := Color; // assign the color of the component to the canvas brush color
    Canvas.FillRect(ClientRect); // fill the client area of the child window with the brush color
//    if FPressed then // if the component is pressed, use the hover color instead
//      Canvas.Brush.Color := HoverColor;
    R := ClientRect;
    InflateRect(R, -4, -4);
    if FAction <> nil then // if the component has an action assigned, draw its image and caption
    begin
      if FImageList <> nil then
      begin
        FImageList.Draw(Canvas, r.Left, r.Top, FImageIndex, Enabled);
        Inc(R.Left, FImageList.Width + 4);
      end;
      DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
    end;
    if Assigned(FOnPaint) then // check if the event handler is assigned
      FOnPaint(Self); // call the event handler with Self as the sender parameter
  finally
    Canvas.Free; // free the temporary canvas object
  end;
end;

function TCustomFlatBtn.IsCaptionStored: Boolean;
begin
  Result := (FAction = nil) or (Caption <> FAction.Caption);
end;

function TCustomFlatBtn.IsHintStored: Boolean;
begin
  Result := (FAction = nil) or (Hint <> FAction.Hint);
end;

function TCustomFlatBtn.IsOnClickStored: Boolean;
begin
  Result := (FAction = nil) or not Assigned(OnClick) or (@OnClick <> @FAction.OnExecute);
end;

procedure TCustomFlatBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
    FPressed := True;
end;

procedure TCustomFlatBtn.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    FPressed := False;
  end;
end;

procedure TCustomFlatBtn.SetAction(const Value: TAction);
begin
  if FAction <> Value then
  begin
    if FAction <> nil then
      FAction.RemoveFreeNotification(Self);
    FAction := Value;
    if FAction <> nil then
    begin
      FAction.FreeNotification(Self);
      ActionChange(FAction, False);
    end;
  end;
end;

procedure TCustomFlatBtn.SetOnPaint(Value: TNotifyEvent);
begin
  if @FOnPaint <> @Value then
  begin
    FOnPaint := Value; // assign the event handler to the field
    Invalidate; // invalidate the component to trigger a repaint
  end;

end;

procedure TCustomFlatBtn.WMPaint(var Message: TWMPaint);
begin
        DoPaint{(Message.WParam)}; // call the custom painting method with the device context of the child window

end;

end.
