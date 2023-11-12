unit btu.lib.usu.factory;

interface

uses btu.lib.usu.Usuario;

function UsuarioCreate: IUsuario;

implementation

uses btu.lib.usu.Usuario_u;

function UsuarioCreate: IUsuario;
begin
  result := TUsuario.Create;
end;

end.
