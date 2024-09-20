unit App.Sessao.Criador.Config_u;

interface

uses App.Sessao.Criador_u, Sis.ModuloSistema.Types, App.Sessao;

type
  TSessaoCriadorConfig = class(TSessaoCriador)
  private
  protected
  public
    constructor Create;
  end;

implementation

{ TSessaoCriadorConfig }

constructor TSessaoCriadorConfig.Create;
begin
  TipoOpcaoSisModulo := TTipoOpcaoSisModulo.moduConfiguracoes;
end;

end.
