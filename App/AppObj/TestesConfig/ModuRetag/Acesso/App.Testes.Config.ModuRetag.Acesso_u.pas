unit App.Testes.Config.ModuRetag.Acesso_u;

interface

uses App.Testes.Config.ModuRetag.Acesso //
  , App.Testes.Config.ModuRetag.Acesso.PerfilDeUso //
  , App.Testes.Config.ModuRetag.Acesso.Funcionario //
  ; //

type
  TTesteConfigModuRetagAcesso = class(TInterfacedObject, ITesteConfigModuRetagAcesso)
  private
    FPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
    FFuncionario: ITesteConfigModuRetagAcessoFuncionario;

    function GetPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
    function GetFuncionario: ITesteConfigModuRetagAcessoFuncionario;
  public
    property PerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso read GetPerfilDeUso;
    property Funcionario: ITesteConfigModuRetagAcessoFuncionario read GetFuncionario;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetagAcesso }

constructor TTesteConfigModuRetagAcesso.Create;
begin
  FPerfilDeUso := ModuRetagAcessoPerfilDeUsoCreate;
  FFuncionario := ModuRetagAcessoFuncionarioCreate;
end;

function TTesteConfigModuRetagAcesso.GetFuncionario: ITesteConfigModuRetagAcessoFuncionario;
begin
  Result := FFuncionario;
end;

function TTesteConfigModuRetagAcesso.GetPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
begin
  Result := FPerfilDeUso;
end;

end.
