unit Sis.Entities.TerminalList_u;

interface

uses System.Classes, Sis.Entities.Terminal, Sis.Entities.TerminalList,
  Sis.Entities.Types;

type
  TTerminalList = class(TInterfaceList, ITerminalList)
  private
    function GetTerminal(Index: Integer): ITerminal;
  public
    property Terminal[Index: Integer]: ITerminal read GetTerminal; default;
    function TerminalIdToTerminal(pTerminalId: TTerminalId): ITerminal;
  end;

implementation

{ TTerminalList }

function TTerminalList.GetTerminal(Index: Integer): ITerminal;
begin
  Result := ITerminal(Items[Index]);
end;

function TTerminalList.TerminalIdToTerminal(
  pTerminalId: TTerminalId): ITerminal;
var
  oTerminal: ITerminal;
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    oTerminal := Terminal[i];
    if oTerminal.TerminalId = pTerminalId then
    begin
      Result := oTerminal;
      break;
    end;
  end;

end;

end.
