unit App.AppInfo.Types;

interface

type
  TAtividadeEconomicaSis = (ativeconNaoIndicado = 32, ativeconMercado = 33, ativeconFarmacia = 34);

  TAtividadeEconomicaSisHelper = record helper for TAtividadeEconomicaSis
    function ToExpandedASCII: string;
  end;

const
  AtividadeEconomicaSisDescr: array [TAtividadeEconomicaSis] of string =
    ('Nao indicado', 'Mercado', 'Farmácia');

  AtividadeEconomicaSisName: array [TAtividadeEconomicaSis] of string =
    ('NAO_INDICADO', 'MERCADO', 'FARMACIA');

implementation

uses System.SysUtils;

function TAtividadeEconomicaSisHelper.ToExpandedASCII: string;
begin
  Result := '#' + Format('%.3d', [Ord(Self)]);
end;

end.
