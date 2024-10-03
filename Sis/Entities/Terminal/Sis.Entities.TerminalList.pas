unit Sis.Entities.TerminalList;

interface

uses System.Classes, Sis.Entities.Terminal;

type
  ITerminalList = interface(IInterfaceList)
    ['{EC559ACF-A5CD-42DE-9B1E-B74C14B1A2C0}']
    function GetTerminal(Index: Integer): ITerminal;
    property Terminal[Index: integer]: ITerminal read GetTerminal; default;
  end;

implementation

end.
