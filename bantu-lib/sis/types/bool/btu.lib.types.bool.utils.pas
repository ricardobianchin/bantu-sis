unit btu.lib.types.bool.utils;

interface

function BooleanToStr(pBoolValue: boolean): string;
function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string; overload;

implementation

uses System.SysUtils;

function BooleanToStr(pBoolValue: boolean): string;
begin
  Result := BoolToStr(pBoolValue, true);
end;

function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

initialization
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


end.
