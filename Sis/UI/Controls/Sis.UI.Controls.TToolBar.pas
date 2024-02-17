unit Sis.UI.Controls.TToolBar;

interface

uses Vcl.ComCtrls, Vcl.ActnList;

procedure ToolBarAddButton(pAction: TAction; pToolBar: TToolBar);

implementation

uses System.SysUtils;

procedure ToolBarAddButton(pAction: TAction; pToolBar: TToolBar);
var
  NovoBotao: TToolButton;
  sNameButton: string;
  sNameAction, sNameActionUppercase: string;
  iPosSufixo: integer;
  iIndexUltimoBotao: integer;
begin
  NovoBotao := TToolButton.Create(pToolBar);

  sNameAction := pAction.Name;
  sNameActionUppercase := UpperCase(sNameAction);
  sNameButton := sNameAction;

  iPosSufixo := sNameActionUppercase.LastIndexOf('ACTION') + 1;

  if iPosSufixo = 0 then
    iPosSufixo := sNameActionUppercase.LastIndexOf('ACT') + 1;

  if iPosSufixo > 0 then
    Delete(sNameButton, iPosSufixo, (Length(sNameButton) - iPosSufixo) + 1);

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
