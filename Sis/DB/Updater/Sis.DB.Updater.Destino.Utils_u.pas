unit Sis.DB.Updater.Destino.Utils_u;

interface

uses Sis.Entities.Types;

type
  TDBUpdaterAlvo = (udAmbos, udServidor, udTerminal);

const
  DBUpdaterAlvoNomes: array[TDBUpdaterAlvo] of string = ('Ambos', 'Servidor', 'Terminal');

function StrToAlvo(pStr: string): TDBUpdaterAlvo;
function TerminalIdToAlvo(pTerminalId: TTerminalId): TDBUpdaterAlvo;
function SeAplica(pTerminalId: TTerminalId; pDBUpdaterAlvo: TDBUpdaterAlvo): boolean;
function ComandoSeAplica(pTerminalId: TTerminalId;pLin: string): Boolean;

implementation

uses System.SysUtils, Sis.Sis.Constants, Sis.Types.strings_u;

function StrToAlvo(pStr: string): TDBUpdaterAlvo;
begin
  pStr := UpperCase(Trim(pStr));
  if pStr = 'TERMINAL' then
    Result := TDBUpdaterAlvo.udTerminal
  else if pStr = 'SERVIDOR' then
    Result := TDBUpdaterAlvo.udServidor
  else //if pStr = 'AMBOS' then
    Result := TDBUpdaterAlvo.udAmbos;
end;

function TerminalIdToAlvo(pTerminalId: TTerminalId): TDBUpdaterAlvo;
begin
  if pTerminalId < 0 then
    Result := TDBUpdaterAlvo.udAmbos
  else if pTerminalId = 0 then
    Result := TDBUpdaterAlvo.udServidor
  else //if pTerminalId > 0 then
    Result := TDBUpdaterAlvo.udTerminal;
end;

function SeAplica(pTerminalId: TTerminalId; pDBUpdaterAlvo: TDBUpdaterAlvo): boolean;
begin
  case pDBUpdaterAlvo of
    udServidor: Result := pTerminalId = TERMINAL_ID_RETAGUARDA;
    udTerminal: Result := pTerminalId > TERMINAL_ID_RETAGUARDA;
    else //udAmbos: ;
      Result := True;
  end;
end;

function ComandoSeAplica(pTerminalId: TTerminalId; pLin: string): Boolean;
var
  sAlvo: string;
  iDBUpdaterAlvo: TDBUpdaterAlvo;
begin
  sAlvo := StrApos(pLin, '=');
  iDBUpdaterAlvo := StrToAlvo(sAlvo);
  Result := SeAplica(pTerminalId, iDBUpdaterAlvo);
end;

end.
