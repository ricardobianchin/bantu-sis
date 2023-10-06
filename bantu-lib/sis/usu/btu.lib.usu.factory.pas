unit btu.lib.usu.factory;

interface

uses btu.lib.usu.UsuLogin;

function UsuLoginCreate: IUsuLogin;

implementation

uses btu.lib.usu.UsuLogin_u;

function UsuLoginCreate: IUsuLogin;
begin
  result := TUsuLogin.Create;
end;

end.
