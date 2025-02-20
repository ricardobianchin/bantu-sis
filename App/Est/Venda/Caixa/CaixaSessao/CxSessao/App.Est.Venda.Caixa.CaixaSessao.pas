unit App.Est.Venda.Caixa.CaixaSessao;

interface

uses Sis.Lists.IdLojaTermItem, Sis.Usuario;

type
  ICaixaSessao = interface(IIdLojaTermItem)
    ['{1CCD0B38-65A8-4CED-AF95-60844D286809}']
    function GetLogUsuario: IUsuario;
    property LogUsuario: IUsuario read GetLogUsuario;

    function GetAberto: Boolean;
    procedure SetAberto(Value: Boolean);
    property Aberto: Boolean read GetAberto write SetAberto;

    function GetConferido: Boolean;
    procedure SetConferido(Value: Boolean);
    property Conferido: Boolean read GetConferido write SetConferido;

    function GetMachineIdentId: SmallInt;
    property MachineIdentId: SmallInt read GetMachineIdentId;

    function GetAbertoEm: TDateTime;
    procedure SetAbertoEm(Value: TDateTime);
    property AbertoEm: TDateTime read GetAbertoEm write SetAbertoEm;

    function GetSessaoCod(pSeparador: string = '-'): string;
  end;


implementation

end.
