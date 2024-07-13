unit Sis.Types.Utils_u;

interface

uses System.UITypes;

const
  ZERO_CURRENCY: currency = 0.0;
  UM_CENTAVO: Currency = 0.01;
  ZERO_INTEGER: integer = 0;
  STR_NULA = '';

  CHAR_ENTER = chr(vkReturn);
//  cENTER: char = chr(vkReturn);
  WKEY_ENTER: word = vkReturn;
//  cESC: char = chr(vkEscape);
  CHAR_ESC = chr(vkEscape);
  CHAR_NULO: char = #0;
  sNOVALIN = sLineBreak;
  CHAR_TAB: char = #9;

function ObterHierarquiaDeClasses(pClasse: TClass): string;

implementation

function ObterHierarquiaDeClasses(pClasse: TClass): string;
begin
  Result := pClasse.ClassName;
  if pClasse <> TObject then
    Result := ObterHierarquiaDeClasses(pClasse.ClassParent) + '\' + Result;
end;

end.
