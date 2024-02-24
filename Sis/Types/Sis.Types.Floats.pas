unit Sis.Types.Floats;

interface

uses System.Math;

function StrToCurrency(S: string): currency;
function StrToNum(S: string): double;
function StrToNumStr(S: string): string;
function FloatToStrPonto(pF: double): string;
function CurrencyToStrPonto(pF: currency): string;
function DinhToStr(pValor: currency): string;
function StrToNumStrPonto(S: string): string;
function TruncTo(const AValue: currency; const ADigit: TRoundToRange = -2)
  : currency;
function DinheiroStr(v: currency; pTrunc: boolean = false): string;

function VarToCurrency(pValue: variant): currency;
function CurrencyToVar(pValue: currency): variant;

implementation

uses
  System.SysUtils, Sis.Types.strings_u, System.StrUtils, System.Variants;

function StrToCurrency(S:string):currency;
begin
  if s='' then
    s:='0';
  result:=strtoCurr(StrToNumStr(s));
end;

function StrToNum(S:string):double;
begin
  if s='' then
    s:='0';
  result:=strtofloat(StrToNumStr(s));
end;

function StrToNumStr(S: string): string;
var
  npontos, t: integer;
  c: string;

begin
  if TemChar(s,',') then
    RemovaChars(s, '.');

  npontos := 0;
  result := '';
  for t := 1 to Length(S) do
  begin
    c := S[t];
    if c = '.' then
      c := ',';
    if c = ',' then
    begin
      if npontos = 0 then
        result := result + c;
      inc(npontos);
    end
    else
    begin
      if pos(c, '0123456789-') <> 0 then
        result := result + c;
    end;
  end;

  result := SemCharAEsquerda(result, '0');

  if result = '' then
    result := '0';

  if result[1] = ',' then
    result := '0' + result;

  if result[Length(result)] = ',' then
    result := result + '0';
end;

function CurrencyToStrPonto(pF: currency): string;
var
  sResultado, r: string;
begin
  r := CurrToStr(pF);
  sResultado := StringReplace(r, ',', '.', [rfReplaceAll]);
  result := sResultado;
end;

function FloatToStrPonto(pF: double): string;
var
  sResultado, r: string;
begin
  r := FloatToStr(pF);
  sResultado := StringReplace(r, ',', '.', [rfReplaceAll]);
  result := sResultado;
end;

function DinhToStr(pValor: currency): string;
begin
  result := FormatFloat('###,###,##0.00', pValor);
end;

function StrToNumStrPonto(S: string): string;
var
  npontos, t: integer;
  c: string;
begin
  npontos := 0;
  result := '';
  for t := 1 to Length(S) do
  begin
    c := S[t];
    if c = ',' then
      c := '.';
    if c = '.' then
    begin
      if npontos = 0 then
        result := result + c;
      inc(npontos);
    end
    else
    begin
      if pos(c, '0123456789-') <> 0 then
        result := result + c;
    end;
  end;

  if result = '' then
    result := '0';

  if result[1] = '.' then
    result := '0' + result;

  if result[Length(result)] = '.' then
    result := result + '0';
end;

function TruncTo(const AValue: currency; const ADigit: TRoundToRange = -2)
  : currency;
var
  LFactor: integer;
begin
  LFactor := Round(IntPower(10, -ADigit));

  result := Trunc(AValue * LFactor) / LFactor;
end;

function DinheiroStr(v: currency; pTrunc: boolean = false): string;
begin
  // result := FormatFloat('R$ ###,###,##0.00',v);
  if pTrunc then
  begin
    result := FormatFloat('###,###,##0.00000000000', v);
    result := StrComerNoFim(result, 9);
    // result:=StrComerDaDir(result,9);
  end
  else
  begin
    result := FormatFloat('###,###,##0.00', v);
  end;
end;

function VarToCurrency(pValue: variant): currency;
var
  sValue: string;
begin
  sValue := VarToStr(pValue);
  Result := StrToCurrency(sValue);
end;

function CurrencyToVar(pValue: currency): variant;
var
  sValue: string;
begin
  sValue := CurrencyToStrPonto(pValue);
  Result := sValue;
end;


end.
