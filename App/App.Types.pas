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


implementation

uses
  System.SysUtils;


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

end.
