unit Sis.Sessao.Types;

interface

type
  TTipoAtividadeNegocio = (ativNaoIndicado, ativMercado);

  TTipoModuloSistema = (moduloNaoIndicado, moduloClienteConfig,
    moduloConfiguracoes, moduloRetaguarda, moduloPDV);

function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;

const
  TipoAtividadeNegocioDescr: array [TTipoAtividadeNegocio] of string =
    ('Nao indicado', 'Mercado');


implementation

function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;
begin
  case pTipoModuloSistema of
    moduloClienteConfig: Result := 'Cliente Config';
    moduloConfiguracoes: Result := 'Configuracoes';
    moduloRetaguarda: Result := 'Retaguarda';
    moduloPDV: Result := 'PDV';
    else Result := 'Nao indicado';//moduloNaoIndicado: ;
  end;
end;

end.
