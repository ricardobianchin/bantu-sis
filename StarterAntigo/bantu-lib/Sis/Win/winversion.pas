unit winversion;

interface

function GetWindowsVersion: currency;

function GetWinVersion(out pMajor: integer; out pMinor: integer;
  out pCSDVersion: string): boolean;

implementation

uses WinApi.Windows;

function GetWindowsVersion: currency;
var
  VersionInfo: TOSVersionInfoEx;
begin
  // Get the Windows version information
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  GetVersionEx(VersionInfo);

  // Check if the major version is less than or equal to 6 (Windows Vista/7)
  // and the minor version is less than or equal to 1 (Windows 7)
  Result := VersionInfo.dwMajorVersion + VersionInfo.dwMinorVersion / 10;
end;

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

{
var
  Major, Minor, CSDVersion: Integer;
begin
  GetWinVersion(Major, Minor, CSDVersion);

  if Major = 6 and Minor = 1 and CSDVersion <> '' then
    Writeln('O Windows 7 tem o Service Pack 1 instalado.');
  else
    Writeln('O Windows 7 não tem o Service Pack 1 instalado.');
end.
}

end.
