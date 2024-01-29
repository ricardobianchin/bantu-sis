unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List, App.Sessao.Eventos, Vcl.Forms, App.Sessao.Criador,
  Sis.ModuloSistema.Types;

function SessaoEventosCreate(pForm: TForm): ISessaoEventos;

function SessaoCriadorCreate(pTipoModuloSistema: TTipoModuloSistema): ISessaoCriador;
function SessaoCriadorListCreate: ISessaoCriadorList;

implementation

uses App.Sessao.Criador.List_u, App.Sessao.Eventos_u,
  App.Sessao.Criador.Config_u, App.Sessao.Criador.PDV_u,
  App.Sessao.Criador.Retag_u;

function SessaoCriadorCreate(pTipoModuloSistema: TTipoModuloSistema): ISessaoCriador;
begin
  case pTipoModuloSistema of
    modsisConfiguracoes: Result := TSessaoCriadorConfig.Create;
    modsisRetaguarda: Result := TSessaoCriadorRetag.Create;
    modsisPDV: Result := TSessaoCriadorPDV.Create;
    else {moduloNaoIndicado:} Result := nil;
  end;
end;

function SessaoCriadorListCreate: ISessaoCriadorList;
begin
  Result := TSessaoCriadorList.Create;
end;

function SessaoEventosCreate(pForm: TForm): ISessaoEventos;
begin
  Result := TSessaoEventos.Create(pForm);
end;

end.
