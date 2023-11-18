unit Sis.Win.Utils_u;

interface

uses System.UITypes, system.SysUtils, Sis.Types.Utils_u;

type
  TWinPlatform = (wplatNaoIndicado, wplatWin32,  wplatWin64);

const
  VERSION_W7_SP1_DESC = 'Service Pack 1';

  WinPlatforms: array[TWinPlatform] of string = (
    'NAOINDICADO',
    'WIN32',
    'WIN64'
    );

function GetWinVersion(out pMajor: integer; out pMinor: integer;
  out pCSDVersion: string): boolean;

function StrToWinPlatform(pStr: string): TWinPlatform;

function IsWow64Process: Boolean;

function GetProgramFilesPath: string;

implementation

uses WinApi.Windows;

function GetWinVersion(out pMajor: integer; out pMinor: integer;
  out pCSDVersion: string): boolean;
var
  OSVI: TOSVersionInfo;
begin
  OSVI.dwOSVersionInfoSize := SizeOf(OSVI);

  Result := GetVersionEx(OSVI);

  if Result then
  begin
    pMajor := OSVI.dwMajorVersion;
    pMinor := OSVI.dwMinorVersion;
    pCSDVersion := OSVI.szCSDVersion;
  end;
end;

function StrToWinPlatform(pStr: string): TWinPlatform;
begin
  if pStr = 'NAOINDICADO' then
    Result := wplatNaoIndicado
  else if pStr = 'WIN32' then
    Result := wplatWin32
  else //if pStr = 'WIN64' then
    Result := wplatWin64;
end;

function IsWow64Process: Boolean;
type
  TIsWow64Process = function(AHandle: DWORD; var AIsWow64: BOOL): BOOL; stdcall;

var
  hIsWow64Process: TIsWow64Process;
  hKernel32: DWORD;
  IsWow64: BOOL;

begin
  Result := False;

  hKernel32 := Winapi.Windows.LoadLibrary('kernel32.dll');
  if hKernel32 = 0 then
    Exit;

  try
    @hIsWow64Process := Winapi.Windows.GetProcAddress(hKernel32, 'IsWow64Process');
    if not System.Assigned(hIsWow64Process) then
      Exit;

    IsWow64 := False;
    if hIsWow64Process(Winapi.Windows.GetCurrentProcess, IsWow64) then
      Result := IsWow64;

  finally
    Winapi.Windows.FreeLibrary(hKernel32);
  end;
end;

function GetProgramFilesPath: string;
var
  ProgramFilesPath: string;
begin
  ProgramFilesPath := GetEnvironmentVariable('ProgramFiles');
  Result := ProgramFilesPath;
end;

end.
