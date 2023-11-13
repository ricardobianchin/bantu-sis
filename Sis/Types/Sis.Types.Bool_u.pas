unit Sis.Types.Bool_u;

interface

uses Sis.Types.Bool;

type
  TSisBool = class(TInterfacedObject, ISisBool)
  public
    function BooleanToStr(pBoolValue: boolean): string;
    function Iif(pTeste: boolean; pSeTrue: string; pSeFalse: string): string; overload;
    constructor Create;
  end;

implementation

uses System.SysUtils;

{ TSisBool }

constructor TSisBool.Create;
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

function TSisBool.Iif(pTeste: boolean; pSeTrue, pSeFalse: string): string;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function TSisBool.BooleanToStr(pBoolValue: boolean): string;
begin
  Result := BoolToStr(pBoolValue, true);
end;

end.
