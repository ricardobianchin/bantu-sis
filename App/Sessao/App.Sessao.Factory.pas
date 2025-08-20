unit App.Sessao.Factory;

interface

uses App.Sessao.Criador.List, App.Sessao.EventosDeSessao, Vcl.Forms,
  Sis.Usuario, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.Sessao.Criador, Sis.ModuloSistema.Types, App.Sessao.EventosDeSessao_u,
  App.UI.Sessoes.Frame_u, App.Constants, App.Sessao, App.UI.Form.Bas.Modulo_u,
  Sis.Entities.Types, App.UI.Form.Bas.Princ.Sessoes.AtalhosGarantidor,
  System.Classes, App.AppInfo;

function SessaoCriadorCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo)
  : ISessaoCriador;
function SessaoCriadorListCreate: ISessaoCriadorList;
function EventosDeSessaoCreate: IEventosDeSessao;

function SessaoCreate(pTipoOpcaoSisModulo: TOpcaoSisIdModulo;
  pUsuario: IUsuario; pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pTerminalId: TTerminalId): ISessao;

function AtalhosGarantidorCreate(pAppInfo: IAppInfo; pTermsSL: TStrings;
  pOutput: IOutput = nil; pProcessLog: IProcessLog = nil): IAtalhosGarantidor;

implementation

uses App.Sessao.Criador.List_u, App.Sessao.Criador.Config_u, App.Sessao_u,
  App.Sessao.Criador.PDV_u, App.Sessao.Criador.Retag_u,
  App.UI.Form.Bas.Princ.Sessoes.AtalhosGarantidor_u;

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

function AtalhosGarantidorCreate(pAppInfo: IAppInfo; pTermsSL: TStrings;
  pOutput: IOutput = nil; pProcessLog: IProcessLog = nil): IAtalhosGarantidor;
begin
  Result := TAtalhosGarantidor.Create(pAppInfo, pTermsSL, pOutput, pProcessLog);
end;

end.
