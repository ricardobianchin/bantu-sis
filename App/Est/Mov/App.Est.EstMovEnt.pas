unit App.Est.EstMovEnt;

interface

uses
  System.Generics.Collections, Sis.Entities.Types, App.Est.Types_u,
  System.Classes, App.Loja, App.Est.EstMovItem, App.Ent.Ed;

type
  IEstMovEnt<T: IEstMovItem> = interface(IEntEd)
    ['{8FE1D118-7395-4E42-89C6-B5A1581ACCDF}']
    function GetLoja: IAppLoja;
    property Loja: IAppLoja read GetLoja;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

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

    function GetItems: TList<T>;
    property Items: TList<T> read GetItems;

    function GetLogStr: string;
    procedure SetLogStr(Value: string);
    property LogStr: string read GetLogStr write SetLogStr;

    function GetEditandoItem: Boolean;
    procedure SetEditandoItem(Value: Boolean);
    property EditandoItem: Boolean read GetEditandoItem write SetEditandoItem;

    procedure Zerar;
  end;

implementation

end.
