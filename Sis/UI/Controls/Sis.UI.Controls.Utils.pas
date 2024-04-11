unit Sis.UI.Controls.Utils;

interface

uses Vcl.StdCtrls, Controls, messages, System.Classes;

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

implementation

uses System.SysUtils, ComCtrls, types, windows, ExtCtrls, CheckLst, Vcl.Forms,
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
  pWinControlDestino.Left := pWinControlModelo.Left;
  pWinControlDestino.Top := pWinControlModelo.Top;
  pWinControlDestino.Width := pWinControlModelo.Width;
  pWinControlDestino.TabOrder := pWinControlModelo.TabOrder;
  pWinControlDestino.TabStop := pWinControlModelo.TabStop;
  pWinControlModelo.Free;
end;

end.
