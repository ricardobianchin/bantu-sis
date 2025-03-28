unit Sis.UI.Controls.Utils;

interface

uses Vcl.StdCtrls, Vcl.Controls, Winapi.Messages, System.Classes, System.Types,
  Vcl.Graphics;

function EditVazio(pEdit: TCustomEdit): boolean;
procedure SimuleTecla(VkKeyCode: integer; pControl: TControl = nil);
procedure MakeRounded(Control: TWinControl; Radius: integer);
function CharToAlignment(const pChar: char): TAlignment;
function PrimeiroWinControl(pWinControl: TWinControl): TWinControl;
function PrimeiroWinControlVisivel(pWinControl: TWinControl): TWinControl;
procedure ReadOnlySet(pCustomEdit: TCustomEdit; pValue: boolean = True);
function StrToDigiteStr(pStr: string): string;
procedure DigiteStr(pTexto: string; pEspera: integer); overload;

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl; pApagaModelo: Boolean = True);

procedure ClearStyleElements(pControl: TControl);

/// <param name="pStyleElements">
///     TStyleElements = set of (seFont, seClient, seBorder);
/// </param>
procedure SetStyleElementsRecursive(pControl: TControl; pStyleElements: TStyleElements);
procedure SetNameToHint(Control: TControl);
procedure SetTabOrderToHint(Control: TControl);
procedure SetCursorToChilds(Control: TControl; pCursor: TCursor);
procedure SetOnClickToChilds(Control: TControl; pOnClick: TNotifyEvent);

function GetToolFormHeight: integer;

procedure ControlAlignToCenter(pControl: TControl);
procedure ControlAlignToRect(pControl: TControl; pRect: TRect;
  pAlignment: TAlignment = taCenter);

procedure ControlAlignHorizontal(pControl: TControl);

function ControlIsVisible(pControl: TControl): boolean;

procedure TrySetFocus(pWinControl: TWinControl);

function ButtonCreate(pOwner: TComponent; pParent: TWinControl;
  pCaption: string; pLeft, pTop: integer; pClickEvent: TNotifyEvent;
  pCanvas: TCanvas; pTag: NativeInt = 0): TButton;

implementation

uses System.SysUtils, ComCtrls, windows, ExtCtrls, CheckLst, Vcl.Forms,
  Sis.UI.Constants, sndkey32, System.StrUtils;

type
  TMyCustomEdit = class(TCustomEdit);
  TMyControl = class(TControl);

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
    'R', 'r', 'D', 'd':
      result := taRightJustify;
  else { L, E, l, e, '' }
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
  result := s;
end;

procedure DigiteStr(pTexto: string; pEspera: integer); overload;
var
  s: string;
begin
  s := StrToDigiteStr(pTexto);
  sndkey32.SendKeys(PWideChar(s), True, pEspera);
end;

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl; pApagaModelo: Boolean);
begin
  pWinControlDestino.Parent := pWinControlModelo.Parent;
  pWinControlDestino.Top := pWinControlModelo.Top;
  pWinControlDestino.Left := pWinControlModelo.Left;
  pWinControlDestino.Width := pWinControlModelo.Width;
  pWinControlDestino.TabStop := pWinControlModelo.TabStop;

  TMyControl(pWinControlDestino).Font.Assign(TMyControl(pWinControlModelo).Font);

  if pApagaModelo then
    pWinControlModelo.Free;
end;

procedure ClearStyleElements(pControl: TControl);
var
  I: integer;
begin
  pControl.StyleElements := [];
  if pControl is TWinControl then
    for I := 0 to TWinControl(pControl).ControlCount - 1 do
      ClearStyleElements(TWinControl(pControl).Controls[I]);
end;

procedure SetStyleElementsRecursive(pControl: TControl; pStyleElements: TStyleElements);
var
  I: integer;
begin
  pControl.StyleElements := pStyleElements;
  if pControl is TWinControl then
    for I := 0 to TWinControl(pControl).ControlCount - 1 do
      ClearStyleElements(TWinControl(pControl).Controls[I]);
end;


procedure SetNameToHint(Control: TControl);
var
  I: integer;
begin
  Control.Hint := Control.Name;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetNameToHint(TWinControl(Control).Controls[I]);
end;

procedure SetTabOrderToHint(Control: TControl);
var
  I: integer;
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
  I: integer;
begin
  Control.Cursor := pCursor;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetCursorToChilds(TWinControl(Control).Controls[I], pCursor);
end;

procedure SetOnClickToChilds(Control: TControl; pOnClick: TNotifyEvent);
var
  I: integer;
begin
  TMyControl(Control).OnClick := pOnClick;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnClickToChilds(TWinControl(Control).Controls[I], pOnClick);
end;

function GetToolFormHeight: integer;
begin
  result := (Screen.Height * 8) div 10;
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

procedure ControlAlignToRect(pControl: TControl; pRect: TRect;
  pAlignment: TAlignment = taCenter);
var
  LargDif: integer;
  AltuDif: integer;
begin
  LargDif := pRect.Width - pControl.Width;
  pControl.Left := LargDif div 2;

  AltuDif := pRect.Height - pControl.Height;
  pControl.Top := AltuDif div 2;
end;

procedure ControlAlignHorizontal(pControl: TControl);
var
  LargDif: integer;
begin
  LargDif := pControl.Parent.Width - pControl.Width;
  pControl.Left := LargDif div 2;
end;

function ControlIsVisible(pControl: TControl): boolean;
begin
  // Verifica se o controle inicial j� est� invis�vel
  result := pControl.Visible;
  if not result then
    exit;

  while pControl.Parent <> nil do
  begin
    pControl := pControl.Parent;

    // Se o parent n�o estiver vis�vel, saia do loop e retorne False
    result := pControl.Visible;
    if not result then
      break;
  end;
end;

procedure TrySetFocus(pWinControl: TWinControl);
var
  bVisible: boolean;
begin
  if not Assigned(pWinControl) then
    exit;

  bVisible := ControlIsVisible(pWinControl);
  if not bVisible then
    exit;
  try
    pWinControl.SetFocus;
  except

  end;
end;

function ButtonCreate(pOwner: TComponent; pParent: TWinControl;
  pCaption: string; pLeft, pTop: integer; pClickEvent: TNotifyEvent;
  pCanvas: TCanvas; pTag: NativeInt = 0): TButton;
var
  ButtonWidth: integer;
begin
  // Cria��o do bot�o
  result := TButton.Create(pOwner);
  result.Parent := pParent;
  result.Caption := pCaption;
  result.OnClick := pClickEvent;

  pCanvas.Font.Assign(result.Font);
  ButtonWidth := pCanvas.TextWidth(result.Caption) + 20;
  // Adiciona um pequeno padding

  result.Width := ButtonWidth;

  // Definir posi��o e outros ajustes adicionais, se necess�rio
  result.Left := pLeft;
  result.Top := pTop; // Exemplo de posi��o
  Result.Tag := pTag;
end;

end.
