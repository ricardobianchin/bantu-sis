unit App.Est.Venda.Caixa.CaixaSessao;

interface

uses Sis.Entities.Types;

type
  ICaixaSessao = interface(IInterface)
    ['{1CCD0B38-65A8-4CED-AF95-60844D286809}']
    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);
    property LojaId: TLojaId read GetLojaId write SetLojaId;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetSessId: integer;
    procedure SetSesslId(Value: integer);
    property SesslId: integer read GetSessId write SetSessId;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);
    property LogId: Int64 read GetLogId write SetLogId;

    function GetAberto: Boolean;
    procedure SetAberto(Value: Boolean);
    property Aberto: Boolean read GetAberto write SetAberto;

    function GetConferido: Boolean;
    procedure SetConferido(Value: Boolean);
    property Conferido: Boolean read GetConferido write SetConferido;
  end;


implementation

end.
