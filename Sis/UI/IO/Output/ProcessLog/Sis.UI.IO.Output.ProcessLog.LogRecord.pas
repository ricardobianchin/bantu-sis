unit Sis.UI.IO.Output.ProcessLog.LogRecord;

interface

uses Sis.UI.IO.Output.ProcessLog.Types;

type
  IProcessLogRecord = interface(IInterface)
    ['{2BDB314C-B9F3-4835-B707-6C10E6D6FC29}']
    function GetDtH: TDateTime;
    procedure SetDtH(Value: TDateTime);
    property DtH: TDateTime read GetDth write SetDtH;

    function GetTipo: TProcessLogTipo;
    procedure SetTipo(Value: TProcessLogTipo);
    property Tipo: TProcessLogTipo read GetTipo write SetTipo;

    function GetAssunto: TProcessLogAssunto;
    procedure SetAssunto(Value: TProcessLogAssunto);
    property Assunto: TProcessLogAssunto read GetAssunto write SetAssunto;

    function GetLocal: TProcessLogLocal;
    procedure SetLocal(Value: TProcessLogLocal);
    property Local: TProcessLogLocal read GetLocal write SetLocal;

    function GetNome: TProcessLogNome;
    procedure SetNome(Value: TProcessLogNome);
    property Nome: TProcessLogNome read GetNome write SetNome;

    function GetTexto: TProcessLogTexto;
    procedure SetTexto(Value: TProcessLogTexto);
    property Texto: TProcessLogTexto read GetTexto write SetTexto;

    function GetAsTab: string;
    property AsTab: string read GetAsTab;
  end;

implementation

end.

