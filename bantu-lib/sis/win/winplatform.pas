unit winplatform;

interface

//function IsWindows64: Boolean;
function IsWow64Process: Boolean;

implementation

uses WinApi.Windows;

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

{
function IsWindows64: Boolean;
var
  IsWow64: BOOL;
begin
  // Get the pointer to the IsWow64Process function
//  IsWow64Process := GetProcAddress(GetModuleHandle('kernel32'), 'IsWow64Process');

  // If the function exists, call it with the current process handle
  if Assigned(IsWow64Process) then
    IsWow64Process(GetCurrentProcess, IsWow64)
  else
    // If the function does not exist, assume it is a 32-bit platform
    IsWow64 := False;

  // Return the result as a Boolean
  Result := IsWow64;
end;
}

end.
