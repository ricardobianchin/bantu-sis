unit Sis.Types.Bool_u;

interface

uses System.UITypes;

const
  TrueStrs: array [0 .. 9] of string = ( //
    'S', 's', //
    'true', 'TRUE', 'True', //
    'y', 'Y', //
    'sim', 'SIM', 'Sim' //
    );
  FalseStrs: array [0 .. 11] of string = ( //
    'N', 'n', //
    'false', 'FALSE', 'False', //
    'nao', 'NAO', 'Nao', //
    'não', 'NÃO', 'Não', //
    ''); //

function BooleanToStr(pBoolValue: Boolean): string; inline;
function StrToBoolean(pStr: string): Boolean; inline;

function Iif(pTeste: Boolean; pSeTrue: string; pSeFalse: string): string;
  inline; overload;
function Iif(pTeste: Boolean; pSeTrue: Currency; pSeFalse: Currency): Currency;
  inline; overload;
function Iif(pTeste: Boolean; pSeTrue: integer; pSeFalse: integer): integer;
  inline; overload;
function Iif(pTeste: Boolean; pSeTrue: TDateTime; pSeFalse: TDateTime)
  : TDateTime; inline; overload;
function Iif(pTeste: Boolean; pSeTrue: Boolean; pSeFalse: Boolean): Boolean;
  inline; overload;

procedure InicializeBool; inline;
function BooleanToStrSQL(pBoolValue: Boolean): string; inline;

implementation

uses System.SysUtils, System.StrUtils;

procedure InicializeBool; inline;
begin
  setlength(TrueBoolStrs, Length(TrueStrs));
  Move(TrueStrs[0], TrueBoolStrs[0], Length(TrueStrs) * SizeOf(string));

  setlength(FalseBoolStrs, Length(FalseStrs));
  Move(FalseStrs[0], FalseBoolStrs[0], Length(FalseStrs) * SizeOf(string));
end;

function Iif(pTeste: Boolean; pSeTrue, pSeFalse: string): string; inline;
begin
  if pTeste then
    Result := pSeTrue
  else
    Result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: Currency; pSeFalse: Currency): Currency;
  inline; overload;
begin
  if pTeste then
    Result := pSeTrue
  else
    Result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: integer; pSeFalse: integer): integer;
  inline; overload;
begin
  if pTeste then
    Result := pSeTrue
  else
    Result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: TDateTime; pSeFalse: TDateTime)
  : TDateTime; inline; overload;
begin
  if pTeste then
    Result := pSeTrue
  else
    Result := pSeFalse;
end;

function Iif(pTeste: Boolean; pSeTrue: Boolean; pSeFalse: Boolean): Boolean;
  inline; overload;
begin
  if pTeste then
    Result := pSeTrue
  else
    Result := pSeFalse;
end;

function BooleanToStr(pBoolValue: Boolean): string; inline;
begin
  Result := Iif(pBoolValue, 'S', 'N');
end;

function StrToBoolean(pStr: string): Boolean; inline;
begin
  pStr := Trim(pStr);
  Result := pStr <> '';
  if not Result then
    exit;

  Result := StrToBool(pStr);
end;

function BooleanToStrSQL(pBoolValue: Boolean): string; inline;
begin
  Result := Iif(pBoolValue, 'TRUE', 'FALSE');
end;

initialization

InicializeBool;

end.
