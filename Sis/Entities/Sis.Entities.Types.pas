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

end.

