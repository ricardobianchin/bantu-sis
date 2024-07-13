unit App.Testes.Config.Factory;

interface

uses
  App.Testes.Config.ModuConf //
  , App.Testes.Config.ModuConf.Ambi //
  , App.Testes.Config.ModuConf.Ambi.Loja //

  , App.Testes.Config.App //

  ; //

function ModuConfCreate: ITesteConfigModuConf;
function ModuConfAmbiCreate: ITesteConfigModuConfAmbi;
function ModuConfAmbiLojaCreate: ITesteConfigModuConfAmbiLoja;

function AppCreate: ITesteConfigApp;

implementation

uses
  App.Testes.Config.ModuConf_u //
  , App.Testes.Config.ModuConf.Ambi_u //
  , App.Testes.Config.ModuConf.Ambi.Loja_u //

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

function AppCreate: ITesteConfigApp;
begin
  Result := TTesteConfigApp.Create;
end;

end.
