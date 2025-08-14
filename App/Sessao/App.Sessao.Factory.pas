unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List, App.Sessao.EventosDeSessao, Vcl.Forms,
  Sis.Usuario,
  App.Sessao.Criador, Sis.ModuloSistema.Types, App.Sessao.EventosDeSessao_u,
  App.UI.Sessoes.Frame_u, App.Constants, App.Sessao, App.UI.Form.Bas.Modulo_u,
  Sis.Entities.Types;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : ISessaoCriador;
function SessaoCriadorListCreate: ISessaoCriadorList;
function EventosDeSessaoCreate: IEventosDeSessao;

function SessaoCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pUsuario: IUsuario; pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pTerminalId: TTerminalId): ISessao;

implementation

uses App.Sessao.Criador.List_u, App.Sessao.Criador.Config_u, App.Sessao_u,
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

function SessaoCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pUsuario: IUsuario; pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pTerminalId: TTerminalId): ISessao;
begin
  Result := TSessao.Create(pTipoOpcaoSisModulo, pUsuario, pModuloBasForm,
    pIndex, pTerminalId);
end;

end.
