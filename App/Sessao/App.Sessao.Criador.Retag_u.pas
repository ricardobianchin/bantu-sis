unit App.Sessao.Criador.Retag_u;

interface

uses App.Sessao.Criador_u, Sis.Modulo.Types, App.Sessao;

type
  TSessaoCriadorRetag = class(TSessaoCriador)
  private
  protected
  public
    constructor Create;
  end;

implementation

{ TSessaoCriadorRetag }

constructor TSessaoCriadorRetag.Create;
begin
  TipoModuloSistema := TTipoModuloSistema.modsisRetaguarda;
end;

end.
