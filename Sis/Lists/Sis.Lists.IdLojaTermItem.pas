unit Sis.Lists.IdLojaTermItem;

interface

uses Sis.Lists.IdItem;

type
  IIdLojaTermItem = interface(IIdItem)
    ['{A61D0C96-5851-4305-835A-C434D6E3CB85}']
    procedure SetLojaId(Value: integer);
    function GetLojaId: integer;
    property LojaId: integer read GetLojaId write SetLojaId;

    procedure SetTerminalId(Value: integer);
    function GetTerminalId: integer;
    property TerminalId: integer read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId, pTerminalId, pId: integer);
    procedure PegarDe(pLojaTermIdItem: IIdLojaTermItem);
    procedure Zerar;
    function GetCodsToStrZero(pLojaNCasas: integer = 0; pTermNCasas: integer = 0; pIdNCasas: integer = 7): string;
  end;

implementation

end.
