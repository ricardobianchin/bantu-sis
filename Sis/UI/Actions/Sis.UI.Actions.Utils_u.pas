unit Sis.UI.Actions.Utils_u;

interface

uses Vcl.ActnList;

function ActionByTag(pActionList: TActionList; pTag: integer): TAction;

implementation

uses System.Actions;

function ActionByTag(pActionList: TActionList; pTag: integer): TAction;
var
  I: integer;
  oAction: TAction;
begin
  Result := nil;

  for I := 0 to pActionList.ActionCount - 1 do
  begin
    oAction := pActionList.Actions[I] as TAction;
    if oAction.Tag = pTag then
    begin
      Result := oAction;
      break;
    end;
  end;

end;

end.
