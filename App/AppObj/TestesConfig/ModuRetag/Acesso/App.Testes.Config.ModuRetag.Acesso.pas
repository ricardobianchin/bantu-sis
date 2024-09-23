unit App.Testes.Config.ModuRetag.Acesso;

interface

uses
  App.Testes.Config.ModuRetag.Acesso.PerfilDeUso //
  , App.Testes.Config.ModuRetag.Acesso.Funcionario //
  ; //

type
  ITesteConfigModuRetagAcesso = interface(IInterface)
    ['{4FE24545-82A5-413C-9FF7-E8F3F5FDFC84}']
    function GetPerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso;
    property PerfilDeUso: ITesteConfigModuRetagAcessoPerfilDeUso read GetPerfilDeUso;

    function GetFuncionario: ITesteConfigModuRetagAcessoFuncionario;
    property Funcionario: ITesteConfigModuRetagAcessoFuncionario read GetFuncionario;
  end;

implementation

end.
