unit btu.lib.lists.LojaTermIdItem;

interface

uses btu.lib.lists.IdItem;

type
  ILojaTermIdItem = interface(IIdItem)
    ['{A61D0C96-5851-4305-835A-C434D6E3CB85}']
    procedure SetLojaId(Value:integer);
    function GetLojaId:integer;
    property LojaId:integer read GetLojaId write SetLojaId;

    procedure SetTerminalId(Value:integer);
    function GetTerminalId:integer;
    property TerminalId:integer read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId, pTerminalId, pId: Integer);
    procedure PegarDe(pLojaTermIdItem:ILojaTermIdItem);
    procedure Zerar;
  end;

implementation

end.
