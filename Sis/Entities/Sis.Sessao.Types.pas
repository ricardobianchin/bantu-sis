unit Sis.Sessao.Types;

interface

type
  TSisTipoAtividade = (stativNaoIndicado = 32, stativMercado = 33);

  TTipoModuloSistema = (moduloNaoIndicado = 32, moduloConfiguracoes = 33,
    moduloRetaguarda = 34, moduloPDV = 35);

function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;

const
  TipoAtividadeNegocioDescr: array [TSisTipoAtividade] of string =
    ('Nao indicado', 'Mercado');

implementation

function TipoModuloSistemaToStr(pTipoModuloSistema: TTipoModuloSistema): string;
begin
  case pTipoModuloSistema of
    moduloConfiguracoes:
      Result := 'Configuracoes';
    moduloRetaguarda:
      Result := 'Retaguarda';
    moduloPDV:
      Result := 'PDV';
  else
    Result := 'Nao indicado'; // moduloNaoIndicado: ;
  end;
end;

end.
