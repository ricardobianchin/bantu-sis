unit App.Sessao_u;

interface

uses App.UI.Form.Bas.Modulo_u, Sis.Usuario, App.Sessao;

type
  TSessao = class(TInterfacedObject, ISessao)
  private
    FModuloFormClass: TModuloBasFormClass;
    FUsuario: IUsuario;

    function GetModuloFormClass: TModuloBasFormClass;
    function GetUsuario: IUsuario;
  public
    property ModuloFormClass: TModuloBasFormClass read GetModuloFormClass;
    property Usuario: IUsuario read GetUsuario;

    constructor Create(pModuloFormClass: TModuloBasFormClass; pUsuario: IUsuario);
  end;

implementation

{ TSessao }

constructor TSessao.Create(pModuloFormClass: TModuloBasFormClass; pUsuario: IUsuario);
begin
  FModuloFormClass := pModuloFormClass;
  FUsuario := pUsuario;
end;

function TSessao.GetModuloFormClass: TModuloBasFormClass;
begin
  Result := FModuloFormClass;
end;

function TSessao.GetUsuario: IUsuario;
begin
  Result := FUsuario;
end;

end.
