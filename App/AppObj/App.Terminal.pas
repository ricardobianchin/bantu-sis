unit App.Terminal;

interface

uses App.Types;

type
  ITerminal = interface(IInterface)
    ['{479E1F2F-F592-405C-99EF-5E330B4EEB7F}']

    function GetLojaId: TLojaId;
    procedure SetLojaId(const pLojaId: TLojaId);
    property LojaId: TLojaId read GetLojaId write SetLojaId;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(const pTerminalId: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetLojaId;

    function GetNumeroExib: integer;
    procedure SetNumeroExib(const pNumeroExib: integer);
    property NumeroExib: integer read GetNumeroExib write SetNumeroExib;

  end;

implementation

end.
