unit App.Sessao;

interface

uses App.UI.Form.Bas.Modulo_u, Sis.Usuario, App.Constants, Sis.ModuloSistema.Types, Sis.Entities.Types;

type
  ISessao = interface(IInterface)
    ['{5C31438E-579C-4D01-A682-9BC530151709}']
    function GetModuloBasForm: TModuloBasForm;
    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;

    function GetUsuario: IUsuario;
    property Usuario: IUsuario read GetUsuario;

    function GetIndex: TSessaoIndex;
    property Index: TSessaoIndex read GetIndex;

    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo;

    function GetTerminalId: TTerminalId;
    property TerminalId: TTerminalId read GetTerminalId;

    procedure EscondaModuloForm;
  end;

implementation

end.
