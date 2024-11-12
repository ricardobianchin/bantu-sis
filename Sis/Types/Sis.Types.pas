unit Sis.Types;

interface

type
  TQuantidade = (qtdNenhu, qtdUm, qtdTodos);
  TProcedureOfObject = procedure of object;

  TFunctionString = function: string;
  TFunctionStringOfObject = function: string of object;

  TSelectItem = record
    Id: integer;
    Descr: string;
  end;

function CodsToCodAsString(pLojaId, pTerminalId: smallint; pId: integer;
  pCodUsaTerminalId: boolean): string;

implementation

uses System.SysUtils;

function CodsToCodAsString(pLojaId, pTerminalId: smallint; pId: integer;
  pCodUsaTerminalId: boolean): string;
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
