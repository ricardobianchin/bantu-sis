unit Sis.UI.Controls.Utils;

interface

uses Vcl.StdCtrls, Controls, messages, System.Classes, System.Types;

function EditVazio(pEdit: TCustomEdit): boolean;
procedure SimuleTecla(VkKeyCode: integer; pControl: TControl = nil);
procedure MakeRounded(Control: TWinControl; Radius: integer);
function CharToAlignment(const pChar: char): TAlignment;
function PrimeiroWinControl(pWinControl: TWinControl): TWinControl;
function PrimeiroWinControlVisivel(pWinControl: TWinControl): TWinControl;
procedure ReadOnlySet(pCustomEdit: TCustomEdit; pValue: boolean = True);
function StrToDigiteStr(pStr: string): string;
procedure DigiteStr(pTexto:string; pEspera:integer);overload;

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl);

procedure ClearStyleElements(Control: TControl);
procedure SetHintToName(Control: TControl);
procedure SetTabOrderToHint(Control: TControl);
procedure SetCursorToChilds(Control: TControl; pCursor: TCursor);
procedure SetOnClickToChilds(Control: TControl; pOnClick: TNotifyEvent);

function GetToolFormHeight: integer;

procedure ControlAlignToCenter(pControl: TControl);
procedure ControlAlignToRect(pControl: TControl; pRect: TRect; pAlignment: TAlignment = taCenter);

function ControlIsVisible(pControl: TControl): Boolean;

procedure TrySetFocus(pWinControl: TWinControl);

implementation

uses System.SysUtils, ComCtrls, windows, ExtCtrls, CheckLst, Vcl.Forms,
  Sis.UI.Constants, Vcl.Graphics, sndkey32, System.StrUtils;

function EditVazio(pEdit: TCustomEdit): boolean;
begin
  pEdit.Text := Trim(pEdit.Text);
  result := pEdit.Text = '';
end;

procedure SimuleTecla(VkKeyCode: integer; pControl: TControl = nil);
var
  contr: TControl;
begin
  if pControl <> nil then
    contr := pControl
  else
    contr := Screen.ActiveControl;
  if contr = nil then
    exit;
  contr.Perform(WM_KEYDOWN, VkKeyCode, KEY_EVENT);
  contr.Perform(WM_KEYup, VkKeyCode, KEY_EVENT);
end;

procedure MakeRounded(Control: TWinControl; Radius: integer);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

function CharToAlignment(const pChar: char): TAlignment;
begin
  case pChar of
    'C', 'c':
      result := taCenter;
    'R', 'r':
      result := taRightJustify;
  else { L, E, '' }
    result := taLeftJustify;
  end;
end;

function PrimeiroWinControl(pWinControl: TWinControl): TWinControl;
var
  c: TControl;
  I: integer;
begin
  result := nil;
  for I := 0 to pWinControl.ControlCount - 1 do
  begin
    c := pWinControl.Controls[I];
    if c is TWinControl then
    begin
      result := TWinControl(c);
      break;
    end;
  end;
end;

function PrimeiroWinControlVisivel(pWinControl: TWinControl): TWinControl;
var
  c: TControl;
  I: integer;
begin
  result := nil;
  for I := 0 to pWinControl.ControlCount - 1 do
  begin
    c := pWinControl.Controls[I];
    if (c is TWinControl) and c.Visible then
    begin
      result := TWinControl(c);
      break;
    end;
  end;
end;

type
  TMyCustomEdit = class(TCustomEdit);

procedure ReadOnlySet(pCustomEdit: TCustomEdit; pValue: boolean);
begin
  with TMyCustomEdit(pCustomEdit) do
  begin
    if pValue then
    begin
      Color := COR_FUNDO_READONLY;
      ReadOnly := True;
    end
    else
    begin
      Color := clWindow;
      ReadOnly := False;
    end;
  end;
end;

function StrToDigiteStr(pStr: string): string;
const
  SENTER = '{ENTER}';
var
  s: string;
begin
  s := ReplaceStr(pStr, #$D#$A, SENTER);
  Result := s;
end;

procedure DigiteStr(pTexto: string; pEspera:integer);overload;
var
  s: string;
begin
  s := StrToDigiteStr(pTexto);
  sndkey32.SendKeys(PWideChar(s), true, pEspera);
end;

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl);
begin
  pWinControlDestino.Parent := pWinControlModelo.Parent;
  pWinControlDestino.Top := pWinControlModelo.Top;
  pWinControlDestino.Left := pWinControlModelo.Left;
  pWinControlDestino.Width := pWinControlModelo.Width;
  pWinControlDestino.TabStop := pWinControlModelo.TabStop;
  pWinControlModelo.Free;
end;

procedure ClearStyleElements(Control: TControl);
var
  I: Integer;
begin
  Control.StyleElements := [];
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      ClearStyleElements(TWinControl(Control).Controls[I]);
end;

procedure SetHintToName(Control: TControl);
var
  I: Integer;
begin
  Control.Hint := Control.Name;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetHintToName(TWinControl(Control).Controls[I]);
end;

procedure SetTabOrderToHint(Control: TControl);
var
  I: Integer;
begin
  if Control is TWinControl then
  begin
    Control.Hint := IntToStr(TWinControl(Control).TabOrder);

    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetTabOrderToHint(TWinControl(Control).Controls[I]);
  end;
end;

procedure SetCursorToChilds(Control: TControl; pCursor: TCursor);
var
  I: Integer;
begin
  Control.Cursor := pCursor;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetCursorToChilds(TWinControl(Control).Controls[I], pCursor);
end;

type
  TMyControl = class(TControl);

procedure SetOnClickToChilds(Control: TControl; pOnClick: TNotifyEvent);
var
  I: Integer;
begin
  TMyControl(Control).OnClick := pOnClick;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnClickToChilds(TWinControl(Control).Controls[I], pOnClick);
end;

function GetToolFormHeight: integer;
begin
  Result := (Screen.Height * 8) div 10;
end;

procedure ControlAlignToCenter(pControl: TControl);
var
  iLargTotal: integer;
  oParent: TControl;
  iDif: integer;
  iLeft: integer;
begin
  oParent := pControl.Parent;

  if not Assigned(oParent) then
    exit;

  iLargTotal := oParent.Width;

  iDif := iLargTotal - pControl.Width;

  iLeft := iDif div 2;

  pControl.Left := iLeft;
end;

procedure ControlAlignToRect(pControl: TControl; pRect: TRect; pAlignment: TAlignment = taCenter);
var
  LargDif: integer;
  AltuDif: integer;
begin
  LargDif := pRect.Width - pControl.Width;
  pControl.Left := LargDif div 2;

  AltuDif := pRect.Height - pControl.Height;
  pControl.Top := AltuDif div 2;
end;

function ControlIsVisible(pControl: TControl): Boolean;
begin
  // Verifica se o controle inicial já está invisível
  Result := pControl.Visible;
  if not Result then
    Exit;

  while pControl.Parent <> nil do
  begin
    pControl := pControl.Parent;

    // Se o parent não estiver visível, saia do loop e retorne False
    Result := pControl.Visible;
    if not Result then
      Break;
  end;
end;

procedure TrySetFocus(pWinControl: TWinControl);
var
  bVisible: Boolean;
begin
  bVisible := ControlIsVisible(pWinControl);
  if not bVisible then
    Exit;

  pWinControl.SetFocus;
end;

end.
