unit App.Sessao;

interface

uses App.UI.Form.Bas.Modulo_u, Sis.Usuario;

type
  ISessao = interface(IInterface)
    ['{5C31438E-579C-4D01-A682-9BC530151709}']
    function GetModuloFormClass: TModuloBasFormClass;
    property ModuloFormClass: TModuloBasFormClass read GetModuloFormClass;

    function GetUsuario: IUsuario;
    property Usuario: IUsuario read GetUsuario;
  end;

implementation

end.
