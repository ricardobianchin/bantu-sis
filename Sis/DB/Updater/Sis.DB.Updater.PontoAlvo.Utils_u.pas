unit Sis.DB.Updater.PontoAlvo.Utils_u;

interface

uses Sis.Entities.Types;

type
  TDBUpdaterPontoAlvo = (upontoAmbos, upontoServidor, upontoTerminal);

const
  DBUpdaterPontoAlvoNomes: array [TDBUpdaterPontoAlvo] of string = ('Ambos',
    'Servidor', 'Terminal');

function StrToPontoAlvo(pStr: string): TDBUpdaterPontoAlvo;
function TerminalIdToPontoAlvo(pTerminalId: TTerminalId): TDBUpdaterPontoAlvo;
function PontoSeAplica(pTerminalId: TTerminalId;
  pDBUpdaterPontoAlvo: TDBUpdaterPontoAlvo): boolean;
function ComandoPontoSeAplica(pTerminalId: TTerminalId; pLin: string): boolean;
function StrToAtividadeExandedAscii(pStr: string): string;

implementation

uses System.SysUtils, Sis.Sis.Constants, Sis.Types.strings_u;

function StrToPontoAlvo(pStr: string): TDBUpdaterPontoAlvo;
begin
  pStr := UpperCase(Trim(pStr));
  if pStr = 'TERMINAL' then
    Result := TDBUpdaterPontoAlvo.upontoTerminal
  else if pStr = 'SERVIDOR' then
    Result := TDBUpdaterPontoAlvo.upontoServidor
  else // if pStr = 'AMBOS' then
    Result := TDBUpdaterPontoAlvo.upontoAmbos;
end;

function TerminalIdToPontoAlvo(pTerminalId: TTerminalId): TDBUpdaterPontoAlvo;
begin
  if pTerminalId < 0 then
    Result := TDBUpdaterPontoAlvo.upontoAmbos
  else if pTerminalId = 0 then
    Result := TDBUpdaterPontoAlvo.upontoServidor
  else // if pTerminalId > 0 then
    Result := TDBUpdaterPontoAlvo.upontoTerminal;
end;


function PontoSeAplica(pTerminalId: TTerminalId;
  pDBUpdaterPontoAlvo: TDBUpdaterPontoAlvo): boolean;
begin
  case pDBUpdaterPontoAlvo of
    upontoServidor:
      Result := pTerminalId = TERMINAL_ID_RETAGUARDA;
    upontoTerminal:
      Result := pTerminalId > TERMINAL_ID_RETAGUARDA;
  else // upontoAmbos: ;
    Result := True;
  end;
end;

function ComandoPontoSeAplica(pTerminalId: TTerminalId; pLin: string): boolean;
var
  sPontoAlvo: string;
  iDBUpdaterPontoAlvo: TDBUpdaterPontoAlvo;
begin
  sPontoAlvo := StrApos(pLin, '=');
  iDBUpdaterPontoAlvo := StrToPontoAlvo(sPontoAlvo);
  Result := PontoSeAplica(pTerminalId, iDBUpdaterPontoAlvo);
end;

function StrToAtividadeExandedAscii(pStr: string): string;
begin
  pStr := Trim(UpperCase(pStr));

  if pStr = 'MERCADO' then
    Result := '#033'
  else if pStr = 'FARMACIA' then
    Result := '#034'
  else
    Result := '#032';
end;

end.
