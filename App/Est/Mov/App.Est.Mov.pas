unit App.Est.Mov;

interface

uses Sis.Entities.Types, App.Est.Types_u;

type
  IEstMov = interface(IInterface)
    ['{840A77FC-2634-402B-952B-BF384CFEA00F}']
    function GetLojaId: TLojaId;
    property LojaId: TLojaId read GetLojaId;

    function GetTerminalId: TTerminalId;
    property TerminalId: TTerminalId read GetTerminalId;

    function GetId: Int64;
    procedure SetId(Value: Int64);
    property Id: Int64 read GetId write SetId;

    function GetEstMovTipo: TEstMovTipo;
    property EstMovTipo: TEstMovTipo read GetEstMovTipo;

    function GetTipoOrdem: integer;
    procedure SetTipoOrdem(Value: integer);
    property TipoOrdem: integer read GetTipoOrdem write SetTipoOrdem;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;


  end;

implementation

end.
