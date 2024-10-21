unit App.AppInfo.Types;

interface

type
  TSisTipoAtividade = (stativNaoIndicado = 32, stativMercado = 33);

const
  TipoAtividadeNegocioDescr: array [TSisTipoAtividade] of string =
    ('Nao indicado', 'Mercado');

  TipoAtividadeNegocioscr: array [TSisTipoAtividade] of string =
    ('Nao indicado', 'Mercado');

implementation

end.
