unit Sis.Entities.TerminalList_u;

interface

uses System.Classes, Sis.Entities.Terminal, Sis.Entities.TerminalList;

type
  TTerminalList = class(TInterfaceList, ITerminalList)
  private
    function GetTerminal(Index: Integer): ITerminal;
  public
    property Terminal[Index: integer]: ITerminal read GetTerminal; default;
  end;

implementation

{ TTerminalList }

function TTerminalList.GetTerminal(Index: Integer): ITerminal;
begin
  Result := ITerminal(Items[Index]);
end;

end.
