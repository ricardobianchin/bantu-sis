unit Sis.UI.Controls.TAction;

interface

function GetActionNamePrefix(pActionName: string): string;

implementation

uses System.SysUtils;

function GetActionNamePrefix(pActionName: string): string;
var
  iPosSufixo: integer;
  sNameAction, sNameActionUppercase: string;
begin
  sNameAction := pActionName;
  sNameActionUppercase := UpperCase(sNameAction);

  Result := sNameAction;

  iPosSufixo := sNameActionUppercase.LastIndexOf('ACTION') + 1;

  if iPosSufixo = 0 then
    iPosSufixo := sNameActionUppercase.LastIndexOf('ACT') + 1;

  if iPosSufixo > 0 then
    Delete(Result, iPosSufixo, (Length(Result) - iPosSufixo) + 1);

end;

end.
