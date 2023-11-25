unit Sis.Win.Utils_u;

interface

uses System.UITypes, Sis.Types.Utils_u;

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

function ExecutePrograma(Nome, Parametros, Pasta: string; out pErro: string): boolean;

implementation

uses
  Vcl.Clipbrd, Winapi.ShellAPI, Winapi.Windows, System.SysUtils, Vcl.Forms;

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

function ExecutePrograma(Nome, Parametros, Pasta: string; out pErro: string): boolean;
var
  SEInfo: TShellExecuteInfo;
begin
  pErro := '';
  // Preencher a estrutura SEInfo com os dados necessários
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := Application.Handle;
  SEInfo.lpFile := PChar(Nome); // Nome do executável
  SEInfo.lpParameters := PChar(Parametros); // Parâmetros do executável
  SEInfo.lpDirectory := PChar(Pasta); // Pasta inicial do executável
  SEInfo.nShow := SW_SHOWNORMAL;

  // Executar o programa usando ShellExecuteEx
  Result := ShellExecuteEx(@SEInfo);
  if not Result then
    pErro := 'ExecutePrograma '+SysErrorMessage(GetLastError);
  {
  if  then
    Result
    // Aguardar o término do programa
    //WaitForSingleObject(SEInfo.hProcess, INFINITE)
  else
    // Mostrar uma mensagem de erro em caso de falha
    raise Exception.Create(SysErrorMessage(GetLastError));
//    ShowMessage(SysErrorMessage(GetLastError));
}
end;


end.
