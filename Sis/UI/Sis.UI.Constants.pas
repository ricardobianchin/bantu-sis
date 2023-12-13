unit Sis.UI.Constants;

interface

uses System.UITypes;

function RGB(red, green, blue: Byte): TColor;

/// <summary>
///   constantes nomes para registrar classes ui
/// </summary>
const
  REGNAME_FORMDECORATOR_CANTOSARRED = 'ui.formdecorator.RoundCorners';
  COR_AZUL_VIVO = 21 OR (98 SHL 8) OR (163 SHL 16);
  COR_AZUL_LINK = $ab0d1a;
//#1a0dab AZUL LINK



//var
//  AzulVivo: TColor;

implementation

// A function that receives three byte values red, green, blue and returns the TColor value
function RGB(red, green, blue: Byte): TColor;
begin
  // TColor is a 4-byte integer that stores the color in the format $00BBGGRR
  // To construct a TColor value from the red, green and blue components, we need to shift them to the right positions and combine them with the OR operator
  // For example, if red = 255, green = 128 and blue = 64, then the TColor value is $004080FF
  Result := (blue shl 16) or (green shl 8) or red;
end;

//initialization
//  AzulVivo := RGB(21, 98, 163);

end.
