unit Sis.Types.Bool_u;

interface

uses System.UITypes;

function BooleanToStr(pBoolValue: Boolean): string;
function StrToBoolean(pStr: string): Boolean;

function Iif(pTeste: Boolean; pSeTrue: string; pSeFalse: string)
  : string; overload;
function Iif(pTeste: Boolean; pSeTrue: Currency; pSeFalse: Currency)
  : Currency; overload;
function Iif(pTeste: Boolean; pSeTrue: integer; pSeFalse: integer)
  : integer; overload;
function Iif(pTeste: Boolean; pSeTrue: TDateTime; pSeFalse: TDateTime)
  : TDateTime; overload;
function Iif(pTeste: Boolean; pSeTrue: Boolean; pSeFalse: Boolean)
  : Boolean; overload;

procedure InicializeBool;
function BooleanToStrSQL(pBoolValue: Boolean): string;

implementation

uses System.SysUtils, System.StrUtils;

procedure InicializeBool;
begin
  setlength(TrueBoolStrs, 4);
  TrueBoolStrs[0] := 'S';
  TrueBoolStrs[1] := 'true';
  TrueBoolStrs[2] := 'y';
  TrueBoolStrs[3] := 'sim';

  setlength(FalseBoolStrs, 5);
  FalseBoolStrs[0] := 'N';
  FalseBoolStrs[1] := 'false';
  FalseBoolStrs[2] := 'nao';
  FalseBoolStrs[3] := 'não';
  FalseBoolStrs[3] := '';
end;

function Iif(pTeste: Boolean; pSeTrue, pSeFalse: string): string;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: Currency; pSeFalse: Currency)
  : Currency; overload;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: integer; pSeFalse: integer)
  : integer; overload;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: TDateTime; pSeFalse: TDateTime)
  : TDateTime; overload;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: Boolean; pSeFalse: Boolean)
  : Boolean; overload;
begin
  if pTeste then
    result := pSeTrue
  else
    result := pSeFalse;
end;

function BooleanToStr(pBoolValue: Boolean): string;
begin
  result := Iif(pBoolValue, 'S', 'N');
  // Result := BoolToStr(pBoolValue, true);
end;

function StrToBoolean(pStr: string): Boolean;
begin
  // pStr := Trim(pStr);

  // Result := pStr <> '';

  // if not Result then
  // exit;

  result := StrToBool(pStr);
end;

function BooleanToStrSQL(pBoolValue: Boolean): string;
begin
  result := Iif(pBoolValue, 'TRUE', 'FALSE');
end;

initialization

InicializeBool;

end.
