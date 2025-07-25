unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List, App.Sessao.EventosDeSessao, Vcl.Forms,
  App.Sessao.Criador, Sis.ModuloSistema.Types, App.Sessao.EventosDeSessao_u,
  App.UI.Sessoes.Frame_u;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : ISessaoCriador;
function SessaoCriadorListCreate: ISessaoCriadorList;
function EventosDeSessaoCreate: IEventosDeSessao;

implementation

uses App.Sessao.Criador.List_u, App.Sessao.Criador.Config_u,
  App.Sessao.Criador.PDV_u, App.Sessao.Criador.Retag_u;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : ISessaoCriador;
begin
  case pTipoOpcaoSisModulo of
    opmoduConfiguracoes:
      Result := TSessaoCriadorConfig.Create;
    opmoduRetaguarda:
      Result := TSessaoCriadorRetag.Create;
    opmoduPDV:
      Result := TSessaoCriadorPDV.Create;
  else { moduloNaoIndicado: }
    Result := nil;
  end;
end;

function SessaoCriadorListCreate: ISessaoCriadorList;
begin
  Result := TSessaoCriadorList.Create;
end;

function EventosDeSessaoCreate: IEventosDeSessao;
begin
  Result := TEventosDeSessao.Create;
end;

end.
