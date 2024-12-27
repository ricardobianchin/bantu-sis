unit App.Est.Mov;

interface

uses Sis.Entities.Types, App.Est.Types_u, System.Classes;

type
  IEstMov = interface(IInterfaceList)
    ['{8FE1D118-7395-4E42-89C6-B5A1581ACCDF}']
    function GetLojaId: TLojaId;
    property LojaId: TLojaId read GetLojaId;

    function GetTerminalId: TTerminalId;
    property TerminalId: TTerminalId read GetTerminalId;

    function GetEstMovId: Int64;
    procedure SetEstMovId(Value: Int64);
    property EstMovId: Int64 read GetEstMovId write SetEstMovId;

    function GetEstMovTipo: TEstMovTipo;
    property EstMovTipo: TEstMovTipo read GetEstMovTipo;

    function GetDtHDoc: TDateTime;
    procedure SetDtHDoc(Value: TDateTime);
    property DtHDoc: TDateTime read GetDtHDoc write SetDtHDoc;

    function GetFinalizado: Boolean;
    procedure SetFinalizado(Value: Boolean);
    property Finalizado: Boolean read GetFinalizado write SetFinalizado;

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function GetFinalizadoEm: TDateTime;
    procedure SetFinalizadoEm(Value: TDateTime);
    property FinalizadoEm: TDateTime read GetFinalizadoEm write SetFinalizadoEm;

    function GetCanceladoEm: TDateTime;
    procedure SetCanceladoEm(Value: TDateTime);
    property CanceladoEm: TDateTime read GetCanceladoEm write SetCanceladoEm;

    procedure Zerar;
  end;

implementation

end.
