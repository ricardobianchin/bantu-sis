unit Sis.UI.Controls.TToolBar;

interface

uses Vcl.ComCtrls, Vcl.ActnList;

procedure ToolBarAddButton(pAction: TAction; pToolBar: TToolBar);

implementation

uses System.SysUtils, Sis.UI.Controls.TAction;

procedure ToolBarAddButton(pAction: TAction; pToolBar: TToolBar);
var
  NovoBotao: TToolButton;
  sNameButton: string;
  sNameAction: string;
  iIndexUltimoBotao: integer;
begin
  NovoBotao := TToolButton.Create(pToolBar);

  sNameAction := pAction.Name;
  sNameButton := GetActionNamePrefix(sNameAction);
  sNameButton := sNameButton + 'ToolButton';

  NovoBotao.Name := sNameButton;
  NovoBotao.Style := tbsButton;
  NovoBotao.Action := pAction;

  iIndexUltimoBotao := pToolBar.ButtonCount - 1;
  if iIndexUltimoBotao > -1 then
    NovoBotao.Left := pToolBar.Buttons[iIndexUltimoBotao].Left +
      pToolBar.Buttons[iIndexUltimoBotao].Width
  else
    NovoBotao.Left := 0;
  NovoBotao.Parent := pToolBar;
end;

end.
