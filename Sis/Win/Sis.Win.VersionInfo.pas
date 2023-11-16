unit Sis.Win.VersionInfo;

interface

uses Sis.Win.Utils_u;

type
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

implementation

end.
