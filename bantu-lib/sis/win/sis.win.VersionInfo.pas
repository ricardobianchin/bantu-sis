unit sis.win.VersionInfo;

interface

type
  TWinPlatform = (wplatNaoIndicado, wplatWin32,  wplatWin64);

  IWinVersionInfo = interface(IInterface)
    ['{CEBC44D8-2C54-4B83-BB1C-005237618D2F}']
    function GetVersion: currency;
    procedure SetVersion(const Value: currency);
    property Version: currency read GetVersion write SetVersion;

    procedure PegarVersion(const pMajor: integer; const pMinor: integer);

    function GetCSDVersion: string;
    procedure SetCSDVersion(const Value: string);
    property CSDVersion: string read GetCSDVersion write SetCSDVersion;

    function GetWinPlatform: TWinPlatform;
    procedure SetWinPlatform(const Value: TWinPlatform);
    property WinPlatform: TWinPlatform read GetWinPlatform write SetWinPlatform;
  end;

const
  WinPlatforms: array[TWinPlatform] of string = (
    'NAOINDICADO',
    'WIN32',
    'WIN64'
    );

function StrToWinPlatform(pStr: string): TWinPlatform;

implementation

function StrToWinPlatform(pStr: string): TWinPlatform;
begin
  if pStr = 'NAOINDICADO' then
    Result := wplatNaoIndicado
  else if pStr = 'WIN32' then
    Result := wplatWin32
  else //if pStr = 'WIN64' then
    Result := wplatWin64;
end;

end.
