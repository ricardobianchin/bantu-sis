unit Sis.UI.Controls.Utils;

interface

uses Vcl.StdCtrls, Vcl.Controls, Winapi.Messages, System.Classes, System.Types,
  Vcl.Graphics, Vcl.Forms;

procedure PosicionarCursorFim(Edit: TCustomEdit);
function EditVazio(pEdit: TCustomEdit): boolean;
procedure SimuleTecla(VkKeyCode: integer; pControl: TControl = nil);
procedure MakeRounded(Control: TWinControl; Radius: integer);
function CharToAlignment(const pChar: char): TAlignment;
function PrimeiroWinControl(pWinControl: TWinControl): TWinControl;
function PrimeiroWinControlVisivel(pWinControl: TWinControl): TWinControl;
procedure ReadOnlySet(pCustomEdit: TCustomEdit; pValue: boolean = True);
function StrToDigiteStr(pStr: string): string;
procedure DigiteStr(pTexto: string; pEspera: integer); overload;

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl;
  pApagaModelo: boolean = True);

procedure ClearStyleElements(pControl: TControl);

/// <param name="pStyleElements">
/// TStyleElements = set of (seFont, seClient, seBorder);
/// </param>
procedure SetStyleElementsRecursive(pControl: TControl;
  pStyleElements: TStyleElements);
procedure SetNameToHint(Control: TControl);
procedure SetTabOrderToHint(Control: TControl);
procedure SetCursorToChilds(Control: TControl; pCursor: TCursor);

procedure SetOnClickToChilds(Control: TControl; pOnClick: TNotifyEvent);
procedure SetOnMouseUpToChilds(Control: TControl; pOnMouseUp: TMouseEvent);
procedure SetOnMouseDownToChilds(Control: TControl; pOnMouseDown: TMouseEvent);
procedure SetOnMouseEnterToChilds(Control: TControl; pOnMouseEnter: TNotifyEvent);
procedure SetOnMouseLeaveToChilds(Control: TControl; pOnMouseLeave: TNotifyEvent);

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

procedure FormGarantaNaTela(pForm: TForm);

implementation

uses System.SysUtils, ComCtrls, windows, ExtCtrls, CheckLst,
  Sis.UI.Constants, sndkey32, System.StrUtils;

type
  TMyCustomEdit = class(TCustomEdit);
  TMyControl = class(TControl);

procedure PosicionarCursorFim(Edit: TCustomEdit);
begin
  if Assigned(Edit) then
  begin
    Edit.SelStart := Length(Edit.Text);
    Edit.SelLength := 0;
  end;
end;

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

procedure PegueFormatoDe(pWinControlDestino, pWinControlModelo: TWinControl;
  pApagaModelo: boolean);
begin
  pWinControlDestino.Parent := pWinControlModelo.Parent;
  pWinControlDestino.Top := pWinControlModelo.Top;
  pWinControlDestino.Left := pWinControlModelo.Left;
  pWinControlDestino.Width := pWinControlModelo.Width;
  pWinControlDestino.TabStop := pWinControlModelo.TabStop;

  TMyControl(pWinControlDestino)
    .Font.Assign(TMyControl(pWinControlModelo).Font);

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

procedure SetStyleElementsRecursive(pControl: TControl;
  pStyleElements: TStyleElements);
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

procedure SetOnMouseDownToChilds(Control: TControl; pOnMouseDown: TMouseEvent);
var
  I: integer;
begin
  TMyControl(Control).OnMouseDown := pOnMouseDown;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnMouseDownToChilds(TWinControl(Control).Controls[I], pOnMouseDown);
end;

procedure SetOnMouseUpToChilds(Control: TControl; pOnMouseUp: TMouseEvent);
var
  I: integer;
begin
  TMyControl(Control).OnMouseUp := pOnMouseUp;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnMouseUpToChilds(TWinControl(Control).Controls[I], pOnMouseUp);
end;

procedure SetOnMouseEnterToChilds(Control: TControl; pOnMouseEnter: TNotifyEvent);
var
  I: integer;
begin
  TMyControl(Control).OnMouseEnter := pOnMouseEnter;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnMouseEnterToChilds(TWinControl(Control).Controls[I], pOnMouseEnter);
end;

procedure SetOnMouseLeaveToChilds(Control: TControl; pOnMouseLeave: TNotifyEvent);
var
  I: integer;
begin
  TMyControl(Control).OnMouseLeave := pOnMouseLeave;
  if Control is TWinControl then
    for I := 0 to TWinControl(Control).ControlCount - 1 do
      SetOnMouseLeaveToChilds(TWinControl(Control).Controls[I], pOnMouseLeave);
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
  // Verifica se o controle inicial já está invisível
  result := pControl.Visible;
  if not result then
    exit;

  while pControl.Parent <> nil do
  begin
    pControl := pControl.Parent;

    // Se o parent não estiver visível, saia do loop e retorne False
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

  if not pWinControl.Enabled then
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
  // Criação do botão
  result := TButton.Create(pOwner);
  result.Parent := pParent;
  result.Caption := pCaption;
  result.OnClick := pClickEvent;

  pCanvas.Font.Assign(result.Font);
  ButtonWidth := pCanvas.TextWidth(result.Caption) + 20;
  // Adiciona um pequeno padding

  result.Width := ButtonWidth;

  // Definir posição e outros ajustes adicionais, se necessário
  result.Left := pLeft;
  result.Top := pTop; // Exemplo de posição
  result.Tag := pTag;
end;

procedure FormGarantaNaTela(pForm: TForm);
var
  DesktopRect: TRect;
  FormRect: TRect;
  NewLeft, NewTop: integer;
begin
  // Verifica se o formulário é válido
  if not Assigned(pForm) then
    exit;

  // Obtém as coordenadas úteis do desktop
  DesktopRect := Screen.WorkAreaRect;

  // Obtém as coordenadas do formulário
  FormRect.Left := pForm.Left;
  FormRect.Top := pForm.Top;
  FormRect.Width := pForm.Width;
  FormRect.Height := pForm.Height;

  // Inicializa as novas posições
  NewLeft := pForm.Left;
  NewTop := pForm.Top;

  // Verifica se o formulário está fora da área útil à direita
  if FormRect.Left + FormRect.Width > DesktopRect.Right then
    NewLeft := DesktopRect.Right - FormRect.Width;

  // Verifica se o formulário está fora da área útil à esquerda
  if FormRect.Left < DesktopRect.Left then
    NewLeft := DesktopRect.Left;

  // Verifica se o formulário está fora da área útil abaixo
  if FormRect.Top + FormRect.Height > DesktopRect.Bottom then
    NewTop := DesktopRect.Bottom - FormRect.Height;

  // Verifica se o formulário está fora da área útil acima
  if FormRect.Top < DesktopRect.Top then
    NewTop := DesktopRect.Top;

  // Ajusta a posição do formulário, se necessário
  if (NewLeft <> pForm.Left) or (NewTop <> pForm.Top) then
  begin
    pForm.Left := NewLeft;
    pForm.Top := NewTop;
  end;
end;

end.
