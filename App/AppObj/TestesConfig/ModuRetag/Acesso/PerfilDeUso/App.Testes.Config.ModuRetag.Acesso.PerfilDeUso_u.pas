unit App.Testes.Config.ModuRetag.Acesso.PerfilDeUso_u;

interface

uses App.Testes.Config.ModuRetag.Acesso.PerfilDeUso;

type
  TTesteConfigModuRetagAcessoPerfilDeUso = class(TInterfacedObject, ITesteConfigModuRetagAcessoPerfilDeUso)
  private
    FAutoExec: boolean;
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagAcessoPerfilDeUso }

constructor TTesteConfigModuRetagAcessoPerfilDeUso.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuRetagAcessoPerfilDeUso.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuRetagAcessoPerfilDeUso.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
