unit Sis.UI.IO.Output.ProcessLog.LogRecord;

interface

uses Sis.UI.IO.Output.ProcessLog;

type
  IProcessLogRecord = interface(IInterface)
    ['{2BDB314C-B9F3-4835-B707-6C10E6D6FC29}']

    function GetVersao: integer;
    property Versao: integer read GetVersao;

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

    function GetTitAsTab: string;
    property TitAsTab: string read GetTitAsTab;

    procedure PegueAssunto(pAssunto: TProcessLogAssunto);
    procedure RetorneAssunto;

    procedure PegueLocal(pLocal: TProcessLogLocal);
    procedure RetorneLocal;

    function GetQtdRecords: integer;
    property QtdRecords: integer read GetQtdRecords;
    procedure IncGetQtdRecords;
    procedure ResetQtdRecords;
  end;

implementation

end.

