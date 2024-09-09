unit App.Testes.Config.Factory;

interface

uses
  App.Testes.Config.ModuConf //
  , App.Testes.Config.ModuConf.Ambi //
  , App.Testes.Config.ModuConf.Ambi.Loja //

  , App.Testes.Config.ModuRetag //
  , App.Testes.Config.ModuRetag.Acesso
  , App.Testes.Config.ModuRetag.Acesso.PerfilDeUso //
  , App.Testes.Config.ModuRetag.Acesso.Funcionario //

  , App.Testes.Config.ModuRetag.Est
  , App.Testes.Config.ModuRetag.Est.Cliente //

  , App.Testes.Config.App//

  ; //

function ModuConfCreate: ITesteConfigModuConf;
function ModuConfAmbiCreate: ITesteConfigModuConfAmbi;
function ModuConfAmbiLojaCreate: ITesteConfigModuConfAmbiLoja;

function ModuRetagCreate: ITesteConfigModuRetag;
function ModuRetagAcessoCreate: ITesteConfigModuRetagAcesso;
function ModuRetagAcessoPerfilDeUsoCreate: ITesteConfigModuRetagAcessoPerfilDeUso;
function ModuRetagAcessoFuncionarioCreate: ITesteConfigModuRetagAcessoFuncionario;

function ModuRetagEstCreate: ITesteConfigModuRetagEst;
function ModuRetagEstClienteCreate: ITesteConfigModuRetagEstCliente;

function AppCreate: ITesteConfigApp;

implementation

uses
  App.Testes.Config.ModuConf_u //
  , App.Testes.Config.ModuConf.Ambi_u //
  , App.Testes.Config.ModuConf.Ambi.Loja_u //

  , App.Testes.Config.ModuRetag_u //
  , App.Testes.Config.ModuRetag.Acesso_u //
  , App.Testes.Config.ModuRetag.Acesso.PerfilDeUso_u //
  , App.Testes.Config.ModuRetag.Acesso.Funcionario_u //

  , App.Testes.Config.ModuRetag.Est_u //
  , App.Testes.Config.ModuRetag.Est.Cliente_u //

  , App.Testes.Config.App_u //

  ; //

function ModuConfCreate: ITesteConfigModuConf;
begin
  Result := TTesteConfigModuConf.Create;
end;

function ModuConfAmbiCreate: ITesteConfigModuConfAmbi;
begin
  Result := TTesteConfigModuConfAmbi.Create;
end;

function ModuConfAmbiLojaCreate: ITesteConfigModuConfAmbiLoja;
begin
  Result := TTesteConfigModuConfAmbiLoja.Create;
end;

function ModuRetagCreate: ITesteConfigModuRetag;
begin
  Result := TTesteConfigModuRetag.Create;
end;

function ModuRetagAcessoCreate: ITesteConfigModuRetagAcesso;
begin
  Result := TTesteConfigModuRetagAcesso.Create;
end;

function ModuRetagAcessoPerfilDeUsoCreate: ITesteConfigModuRetagAcessoPerfilDeUso;
begin
  Result := TTesteConfigModuRetagAcessoPerfilDeUso.Create;
end;

function ModuRetagAcessoFuncionarioCreate: ITesteConfigModuRetagAcessoFuncionario;
begin
  Result := TTesteConfigModuRetagAcessoFuncionario.Create;
end;

function AppCreate: ITesteConfigApp;
begin
  Result := TTesteConfigApp.Create;
end;

function ModuRetagEstCreate: ITesteConfigModuRetagEst;
begin
  Result := TTesteConfigModuRetagEst.Create;
end;

function ModuRetagEstClienteCreate: ITesteConfigModuRetagEstCliente;
begin
  Result := TTesteConfigModuRetagEstCliente.Create;
end;

end.
