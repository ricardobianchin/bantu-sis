unit Sis.DB.Updater.Destino.Utils_u;

interface

uses Sis.Entities.Types;

type
  TDBUpdaterDestino = (udAmbos, udServidor, udTerminal);

function StrToDestino(pStr: string): TDBUpdaterDestino;
function TerminalIdToDestino(pTerminalId: TTerminalId): TDBUpdaterDestino;

implementation

uses System.SysUtils;

function StrToDestino(pStr: string): TDBUpdaterDestino;
begin
  pStr := UpperCase(Trim(pStr));
  if pStr = 'AMBOS' then
    Result := TDBUpdaterDestino.udAmbos
  else if pStr = 'SERVIDOR' then
    Result := TDBUpdaterDestino.udServidor
  else //if pStr = 'TERMINAL' then
    Result := TDBUpdaterDestino.udTerminal;
end;

function TerminalIdToDestino(pTerminalId: TTerminalId): TDBUpdaterDestino;
begin
  if pTerminalId < 0 then
    Result := TDBUpdaterDestino.udAmbos
  else if pTerminalId = 0 then
    Result := TDBUpdaterDestino.udServidor
  else //if pTerminalId > 0 then
    Result := TDBUpdaterDestino.udTerminal;
end;

end.
