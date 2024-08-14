unit App.Testes.Config.ModuRetag.Acesso_u;

interface

uses App.Testes.Config.ModuRetag.Acesso, App.Testes.Config.ModuRetag.Acesso.PerfilDeUso;

type
  TTesteConfigModuRetagAcesso = class(TInterfacedObject, ITesteConfigModuRetagAcesso)
  private
    FPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;

    function GetPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
  public
    property PerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso read GetPerfilDeUso;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetagAcesso }

constructor TTesteConfigModuRetagAcesso.Create;
begin
  FPerfilDeUso := ModuRetagAcessoPerfilDeUsoCreate;
end;

function TTesteConfigModuRetagAcesso.GetPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
begin
  Result := FPerfilDeUso;
end;

end.
