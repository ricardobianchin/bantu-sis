unit App.Sessao.Criador.PDV_u;

interface

uses App.Sessao.Criador_u, Sis.Modulo.Types, App.Sessao;

type
  TSessaoCriadorPDV = class(TSessaoCriador)
  private
  protected
  public
    constructor Create;
  end;

implementation

{ TSessaoCriadorPDV }

constructor TSessaoCriadorPDV.Create;
begin
  TipoModuloSistema := TTipoModuloSistema.modsisPDV;
end;

end.
