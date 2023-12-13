unit Sis.Types.Bool_u;

interface

uses System.UITypes;

function BooleanToStr(pBoolValue: boolean): string;
function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string; overload;
procedure InicializeBool;

implementation

uses System.SysUtils, System.StrUtils;

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

end.
