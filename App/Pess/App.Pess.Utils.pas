unit App.Pess.Utils;

interface

const
  ENDER_TABVIEW_ORDEM_INDEX = 15;

type
  TEnderQuantidadePermitida = (endqtdNenhum, endqtdUm, endqtdVarios);

function CodsToCodAsString(pLojaId, pTerminalId: smallint; pId: integer; pCodUsaTerminalId: boolean): string;

implementation

uses System.SysUtils;

function CodsToCodAsString(pLojaId, pTerminalId: smallint; pId: integer; pCodUsaTerminalId: boolean): string;
var
  sFormat: string;
begin
  if pCodUsaTerminalId then
  begin
    sFormat := '%.2d-%.2d-%.7d';
    Result := Format(sFormat, [pLojaId, pTerminalId, pId]);
  end
  else
  begin
    sFormat := '%.2d-%.7d';
    Result := Format(sFormat, [pLojaId, pId]);
  end;
end;

end.
