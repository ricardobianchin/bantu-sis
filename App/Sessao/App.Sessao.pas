unit App.Sessao;

interface

uses App.UI.Form.Bas.Modulo_u, Sis.Usuario, App.Constants;

type
  ISessao = interface(IInterface)
    ['{5C31438E-579C-4D01-A682-9BC530151709}']
    function GetModuloBasForm: TModuloBasForm;
    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;

    function GetUsuario: IUsuario;
    property Usuario: IUsuario read GetUsuario;

    function GetIndex: TSessaoIndex;
    property Index: TSessaoIndex read GetIndex;

    procedure EscondaModuloForm;
  end;

implementation

end.
