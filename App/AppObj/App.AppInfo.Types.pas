unit App.AppInfo.Types;

interface

type
  TAtividadeEconomicaSis = (stativNaoIndicado = 32, stativMercado = 33);

  TAtividadeEconomicaSisHelper = record helper for TAtividadeEconomicaSis
    function ToExpandedASCII: string;
  end;

const
  AtividadeEconomicaSisDescr: array [TAtividadeEconomicaSis] of string =
    ('Nao indicado', 'Mercado');

  AtividadeEconomicaSisName: array [TAtividadeEconomicaSis] of string =
    ('NAO_INDICADO', 'MERCADO');

implementation

uses System.SysUtils;

function TAtividadeEconomicaSisHelper.ToExpandedASCII: string;
begin
  Result := '#' + Format('%.3d', [Ord(Self)]);
end;

end.
