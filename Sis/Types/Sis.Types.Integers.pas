unit Sis.Types.Integers;

interface

function IntToStrZero(pInt: Int64; pNCasas: word): string;

implementation

uses System.SysUtils;

function IntToStrZero(pInt: Int64; pNCasas: word): string;
begin
  // Use the Format function to convert the integer to a string with leading zeros
  Result := Format('%.*d', [pNCasas, pInt]);
end;

end.
