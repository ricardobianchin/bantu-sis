unit Sis.Entities.Types;

interface

type
  TLojaId = type Smallint;
  TTerminalId = type SmallInt;

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

end.

