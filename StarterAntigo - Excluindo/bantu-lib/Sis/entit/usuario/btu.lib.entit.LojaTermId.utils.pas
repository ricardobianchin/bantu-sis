unit btu.lib.entit.LojaTermId.utils;

interface

function CodsToStrZero(pQtdCasasId: integer;
  pLojaId, pTerminalId, pId: integer): string;

implementation

uses System.SysUtils;

function CodsToStrZero(pQtdCasasId: integer;
  pLojaId, pTerminalId, pId: integer): string;
var
  Resultado: string;
  FormatString: string;
begin
  FormatString := '%d-%d-%.';

  if pQtdCasasId>0 then
    FormatString := FormatString + pQtdCasasId.ToString;

  FormatString := FormatString + 'd';

  Resultado := Format(FormatString, [pLojaId, pTerminalId, pId]);
  Result := Resultado;
end;

end.
