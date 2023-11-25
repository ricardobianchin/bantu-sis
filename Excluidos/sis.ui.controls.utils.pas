unit sis.ui.controls.utils;

interface

uses Vcl.StdCtrls, controls, messages;

function EditVazio(pEdit: TCustomEdit): boolean;
procedure SimuleTecla(VkKeyCode:integer; pControl:TControl=nil);

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


end.
