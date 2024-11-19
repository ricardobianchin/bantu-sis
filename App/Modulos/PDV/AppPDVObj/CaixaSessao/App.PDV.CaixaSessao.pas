unit App.PDV.CaixaSessao;

interface

uses Sis.Entities.Types;

type
  ICaixaSessao = interface(IInterface)
    ['{A0E95183-26DC-4CB9-892F-86FF6F90984A}']
    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);
    property LojaId: TLojaId read GetLojaId write SetLojaId;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetId: integer;
    procedure SetId(Value: integer);
    property Id: integer read GetId write SetId;
  end;

implementation

end.
