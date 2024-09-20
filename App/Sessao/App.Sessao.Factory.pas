unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List, App.Sessao.Eventos, Vcl.Forms, App.Sessao.Criador,
  Sis.ModuloSistema.Types;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo)
  : ISessaoCriador;
function SessaoCriadorListCreate: ISessaoCriadorList;

implementation

uses App.Sessao.Criador.List_u, App.Sessao.Criador.Config_u,
  App.Sessao.Criador.PDV_u,
  App.Sessao.Criador.Retag_u;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TTipoOpcaoSisModulo)
  : ISessaoCriador;
begin
  case pTipoOpcaoSisModulo of
    moduConfiguracoes:
      Result := TSessaoCriadorConfig.Create;
    moduRetaguarda:
      Result := TSessaoCriadorRetag.Create;
    moduPDV:
      Result := TSessaoCriadorPDV.Create;
  else { moduloNaoIndicado: }
    Result := nil;
  end;
end;

function SessaoCriadorListCreate: ISessaoCriadorList;
begin
  Result := TSessaoCriadorList.Create;
end;

end.
