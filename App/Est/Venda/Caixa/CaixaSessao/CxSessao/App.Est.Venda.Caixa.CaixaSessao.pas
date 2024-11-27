unit App.Est.Venda.Caixa.CaixaSessao;

interface

uses Sis.Lists.IdLojaTermItem, Sis.Usuario;

type
  ICaixaSessao = interface(IIdLojaTermItem)
    ['{1CCD0B38-65A8-4CED-AF95-60844D286809}']
    function GetLogUsuario: IUsuario;
    property LogUsuario: IUsuario read GetLogUsuario;

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
