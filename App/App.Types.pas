unit App.Types;

interface

uses Data.FmtBcd;

type
  TPreco = TBcd;
  TCusto = TBcd;

  TPrecoHelper = record helper for TPreco
  public
    function AsSqlConstant: string;
  end;

function CustoToCustoUnit(pCusto: Currency; pQtd: Currency): Currency;
function PrecoSugeridoCalc(pCustoUnit: Currency; pMargem: Currency): Currency;

implementation

uses
  System.SysUtils, System.Math;


function TPrecoHelper.AsSqlConstant: string;
var
  sResultado, r: string;
begin
  r := BcdToStr(Self);
  sResultado := StringReplace(r, ',', '.', [rfReplaceAll]);
  result := sResultado;
end;
{var
  DecimalSeparatorOriginal: Char;
  FormattedValue: string;
begin
  // Salva o separador decimal original
  DecimalSeparatorOriginal := FormatSettings.DecimalSeparator;

  try
    // Define o separador decimal como '.'
    FormatSettings.DecimalSeparator := '.';

    // Converte o valor de TBcd para string
    FormattedValue := BcdToStr(Self);

    // Remove separadores de milhar
    FormattedValue := StringReplace(FormattedValue, ',', '', [rfReplaceAll]);

    // Retorna o valor formatado
    Result := FormattedValue;
  finally
    // Restaura o separador decimal original
    FormatSettings.DecimalSeparator := DecimalSeparatorOriginal;
  end;
end;
  }

function CustoToCustoUnit(pCusto: Currency; pQtd: Currency): Currency;
begin
  Result := RoundTo(pCusto / pQtd, -4);
end;

function PrecoSugeridoCalc(pCustoUnit: Currency; pMargem: Currency): Currency;
begin
  Result := RoundTo(pCustoUnit * pMargem, -2);
end;

end.
