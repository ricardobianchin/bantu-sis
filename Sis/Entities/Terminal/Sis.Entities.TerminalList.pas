unit Sis.Entities.TerminalList;

interface

uses System.Classes, Sis.Entities.Terminal, Sis.Entities.Types;

type
  ITerminalList = interface(IInterfaceList)
    ['{EC559ACF-A5CD-42DE-9B1E-B74C14B1A2C0}']
    function GetTerminal(Index: Integer): ITerminal;
    property Terminal[Index: integer]: ITerminal read GetTerminal; default;
    function TerminalIdToTerminal(pTerminalId: TTerminalId): ITerminal;
    function TerminalIdToIndex(pTerminalId: TTerminalId): integer;
  end;

implementation

end.
