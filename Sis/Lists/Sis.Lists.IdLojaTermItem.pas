unit Sis.Lists.IdLojaTermItem;

interface

uses Sis.Lists.IdItem, Sis.Entities.Types;

type
  IIdLojaTermItem = interface(IIdItem)
    ['{A61D0C96-5851-4305-835A-C434D6E3CB85}']
    procedure SetLojaId(Value: TLojaId);
    function GetLojaId: TLojaId;
    property LojaId: TLojaId read GetLojaId write SetLojaId;

    procedure SetTerminalId(Value: TTerminalId);
    function GetTerminalId: TTerminalId;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    procedure Pegar(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer);
    procedure PegarDe(pLojaTermIdItem: IIdLojaTermItem);
    procedure Zerar;
    function GetCodsToStrZero(pLojaNCasas: integer = 0; pTermNCasas: integer = 0; pIdNCasas: integer = 7): string;
  end;

implementation

end.
