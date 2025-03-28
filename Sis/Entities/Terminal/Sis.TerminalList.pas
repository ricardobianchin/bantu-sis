unit Sis.TerminalList;

interface

uses System.Classes, Sis.Terminal, Sis.Entities.Types;

type
  ITerminalList = interface(IInterfaceList)
    ['{EC559ACF-A5CD-42DE-9B1E-B74C14B1A2C0}']
    function GetTerminal(Index: Integer): ITerminal;
    property Terminal[Index: integer]: ITerminal read GetTerminal; default;
    function TerminalIdToTerminal(pTerminalId: TTerminalId): ITerminal;
    function TerminalIdToIndex(pTerminalId: TTerminalId): integer;
    procedure ExecuteForAll(const Proc: TTerminalProcedure; const pNomeNaRede: string= '');

    function GetAsString: string;
    property AsString: string read GetAsString;
  end;


implementation

end.
