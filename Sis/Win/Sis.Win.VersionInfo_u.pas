unit Sis.Win.VersionInfo_u;

interface

uses sis.win.VersionInfo, Sis.Win.Utils_u;

type
  TWinVersionInfo = class(TInterfacedObject, IWinVersionInfo)
  private
    FVersion: currency;
    FCSDVersion: string;
    FWinPlatform: TWinPlatform;

    function GetVersion: currency;
    procedure SetVersion(const Value: currency);

    function GetCSDVersion: string;
    procedure SetCSDVersion(const Value: string);

    function GetWinPlatform: TWinPlatform;
    procedure SetWinPlatform(const Value: TWinPlatform);
  public
    property Version: currency read GetVersion write SetVersion;
    procedure PegarVersion(const pMajor: integer; const pMinor: integer);
    property CSDVersion: string read GetCSDVersion write SetCSDVersion;
    property WinPlatform: TWinPlatform read GetWinPlatform write SetWinPlatform;
    constructor Create;
  end;

implementation

uses Sis.Types.Utils_u;

{ TWinVersionInfo }

constructor TWinVersionInfo.Create;
begin
  inherited Create;
  FVersion := ZERO_INTEGER;
  FCSDVersion := STR_NULA;
  FWinPlatform := wplatNaoIndicado;
end;

function TWinVersionInfo.GetCSDVersion: string;
begin
  result := FCSDVersion;
end;

function TWinVersionInfo.GetVersion: currency;
begin
  result := FVersion;
end;

function TWinVersionInfo.GetWinPlatform: TWinPlatform;
begin
  result := FWinPlatform;
end;

procedure TWinVersionInfo.PegarVersion(const pMajor, pMinor: integer);
begin
  FVersion := pMajor + pMinor / 10;
end;

procedure TWinVersionInfo.SetCSDVersion(const Value: string);
begin
  FCSDVersion := Value;
end;

procedure TWinVersionInfo.SetVersion(const Value: currency);
begin
  FVersion := Value;
end;

procedure TWinVersionInfo.SetWinPlatform(const Value: TWinPlatform);
begin
  FWinPlatform := Value;
end;

end.
