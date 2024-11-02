unit Sis.Types.Integers;

interface

function IntToStrZero(pInt: Int64; pNCasas: word): string;
function StrToIntStr(S:string):string;
function IntToExpandedASCII(pInt: byte): string;
function StrToSmallInt(S:string): SmallInt;
function StrToInteger(S:string): integer;
function StrToInteger64(S:string): int64;
function VarToInteger(Value: Variant): integer;
function VarToInteger64(Value: Variant): integer;

implementation

uses System.SysUtils, System.StrUtils, System.Variants;

function IntToStrZero(pInt: Int64; pNCasas: word): string;
begin
  // Use the Format function to convert the integer to a string with leading zeros
  Result := Format('%.*d', [pNCasas, pInt]);
end;

function StrToIntStr(S:string):string;
var
  t:integer;
  c:string;
begin
  s:=Trim(s);
  if s='' then
  begin
    result:='0';
    exit;
  end;

  result:='';
  for t := 1 to Length(s) do
  begin
    c:=s[t];
    if pos(c,'-0123456789')=0 then
    begin
      result:='0';
      break;
    end
    else
      Result:=Result+c;
  end;
  repeat
    if Length(result)=0 then
    begin
      result:='0';
      break;
    end;
    if result[1]<>'0' then
      break;
    result:=RightStr(result, Length(result)-1);
  until false;
  if result='' then
    result:='0';
end;

function IntToExpandedASCII(pInt: byte): string;
begin
  Result := '#' + Format('%.3d', [pInt]);
end;


function StrToSmallInt(S:string): SmallInt;
begin
  result:=smallint(StrToInt(StrToIntStr(s)));
end;

function StrToInteger(S:string): integer;
begin
  result:=StrToInt(StrToIntStr(s));
end;

function StrToInteger64(S:string): int64;
begin
  result:=StrToInt64(StrToIntStr(s));
end;

function VarToInteger(Value: Variant): integer;
var
  sResultado: string;
begin
  sResultado := System.Variants.VarToStrDef(Value, '0');
  Result := StrToInteger(sResultado);
end;

function VarToInteger64(Value: Variant): integer;
var
  sResultado: string;
begin
  sResultado := System.Variants.VarToStrDef(Value, '0');
  Result := StrToInteger64(sResultado);
end;

end.
