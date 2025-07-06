unit Sis.Entities.Types;

interface

uses Sis.Types;

type
  TLojaId = type TShortId;
  TTerminalId = type TShortId;

  TLojaIdHelper = record helper for TLojaId
    function ToString: string;
    function ToStrZero: string;
  end;

  TTerminalIdHelper = record helper for TTerminalId
    function ToString: string;
    function ToStrZero: string;
  end;

const
  COD_SEPARADOR = '-';
 
function GetCod(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer;
  pPrefixo: string; pSeparador: string = COD_SEPARADOR): string; overload;

function GetCod(pLojaId: TLojaId; pId: integer;
  pPrefixo: string; pSeparador: string = COD_SEPARADOR): string; overload;

implementation

uses System.SysUtils;

{ TTerminalIdHelper }

function TTerminalIdHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TTerminalIdHelper.ToStrZero: string;
begin
  Result := Format('%.3d', [Self]);
end;

{ TLojaIdHelper }

function TLojaIdHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TLojaIdHelper.ToStrZero: string;
begin
  Result := Format('%.3d', [Self]);
end;

function GetCod(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer;
  pPrefixo: string; pSeparador: string): string;
var
  sFormat: string;
begin
  sFormat := '%.2d' + pSeparador + '%.2d' + pSeparador + '%.7d';
  Result := pPrefixo + pSeparador + Format(sFormat,
    [pLojaId, pTerminalId, pId]);
end;

function GetCod(pLojaId: TLojaId; pId: integer; pPrefixo: string;
  pSeparador: string): string;
var
  sFormat: string;
begin
  sFormat := '%.2d' + pSeparador + '%.7d';
  Result := pPrefixo + pSeparador + Format(sFormat,
    [pLojaId, pId]);
end;

end.
