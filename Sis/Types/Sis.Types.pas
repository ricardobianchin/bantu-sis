unit Sis.Types;

interface

type
  TQuantidade = (qtdNenhu, qtdUm, qtdTodos);
  TId = integer;
  TShortId = SmallInt;

  TIdHelper = record helper for TId
    function ToString: string;
  end;

{
  TQuantidadeHelper = record helper for TQuantidade
  public
    procedure SetByInt(pQuantidade: Integer);
  end;
}

  TProcedureOfObject = procedure of object;
  TProcedureStringOfObject = procedure(pStr: string) of object;

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

{
procedure TQuantidadeHelper.SetByInt(pQuantidade: Integer);
begin
  if pQuantidade <= 0 then
    Self := qtdNenhu
  else if pQuantidade = 1 then
    Self := qtdUm
  else
    Self := qtdTodos;
end;
}

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

{ TIdHelper }

function TIdHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

end.
