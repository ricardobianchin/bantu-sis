unit Sis.UI.Controls.Utils;

interface

uses Vcl.StdCtrls, controls, messages;

function EditVazio(pEdit: TCustomEdit): boolean;
procedure SimuleTecla(VkKeyCode:integer; pControl:TControl=nil);
procedure MakeRounded(Control: TWinControl; Radius: integer);

implementation

uses SysUtils, ComCtrls, types, windows, ExtCtrls, CheckLst, classes, Vcl.Forms;

function EditVazio(pEdit: TCustomEdit): boolean;
begin
  pEdit.Text := Trim(pEdit.Text);
  result := pEdit.Text = '';
end;

procedure SimuleTecla(VkKeyCode:integer; pControl:TControl=nil);
var
  contr:TControl;
begin
  if pControl<>nil then
    contr:=pControl
  else
    contr:=Screen.ActiveControl;
  if contr=nil then
    exit;
  Contr.Perform(WM_KEYDOWN,VkKeyCode,KEY_EVENT);
  Contr.Perform(WM_KEYup,VkKeyCode,KEY_EVENT);
end;

procedure MakeRounded(Control: TWinControl; Radius: integer);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R   := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@r));
    InflateRect(r, - 5, - 5);
    Perform(EM_SETRECTNP, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
    Invalidate;
  end;
end;

end.
