unit Sis.Types.Utils_u;

interface

uses System.UITypes;

const
  ZERO_CURRENCY: currency = 0.0;
  UM_CENTAVO: Currency = 0.01;
  ZERO_INTEGER: integer = 0;
  STR_NULA = '';

  cENTER = chr(vkReturn);
//  cENTER: char = chr(vkReturn);
  kENTER: word = vkReturn;
//  cESC: char = chr(vkEscape);
  CHAR_ESC = chr(vkEscape);
  CHAR_NULO: char = #0;
  sNOVALIN = sLineBreak;
  CHAR_TAB: char = #9;



{$REGION 'Bool'}
  function BooleanToStr(pBoolValue: boolean): string;
  function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string; overload;
  procedure InicializeBool;
{$ENDREGION}

implementation

uses System.SysUtils;

{$REGION 'Bool Impl'}
procedure InicializeBool;
begin
  setlength(TrueBoolStrs, 4);
  TrueBoolStrs[0]:='S';
  TrueBoolStrs[1]:='true';
  TrueBoolStrs[2]:='y';
  TrueBoolStrs[3]:='sim';

  setlength(FalseBoolStrs, 5);
  FalseBoolStrs[0]:='N';
  FalseBoolStrs[1]:='false';
  FalseBoolStrs[2]:='nao';
  FalseBoolStrs[3]:='não';
  FalseBoolStrs[3]:='';
end;

function Iif(pTeste: boolean; pSeTrue, pSeFalse: string): string;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function BooleanToStr(pBoolValue: boolean): string;
begin
  Result := BoolToStr(pBoolValue, true);
end;
{$ENDREGION}

end.
