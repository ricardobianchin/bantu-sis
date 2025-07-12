unit Sis.Win.Utils_u;

interface

uses System.UITypes, Sis.Types.Utils_u;

type
  TWinPlatform = (wplatNaoIndicado, wplatWin32, wplatWin64);

const
  VERSION_W7_SP1_DESC = 'Service Pack 1';

  WinPlatforms: array [TWinPlatform] of string = ('NAOINDICADO',
    'WIN32', 'WIN64');

function GetWindowsVersion(out pMajor: integer; out pMinor: integer;
  out pCSDVersion: string): Boolean;

function StrToWinPlatform(pStr: string): TWinPlatform;

function IsWow64Process: Boolean;

function GetProgramFilesPath: string;

function ExecutePrograma(Nome, Parametros, Pasta: string;
  out pErro: string): Boolean;

procedure CopyTextToClipboard(const AText: string);

function GetClipboardText: string;
procedure SetClipboardText(const AText: string);

procedure ExplorerPasta(pPasta: string);

procedure PegarIdMaquina(out pNome: string; out pIp: string);

implementation

uses
  Vcl.Clipbrd, Winapi.ShellAPI, Winapi.Windows, System.SysUtils, Vcl.Forms,
  Vcl.FileCtrl,  Winapi.winsock;

function GetWindowsVersion(out pMajor: integer; out pMinor: integer;
  out pCSDVersion: string): Boolean;
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
  else // if pStr = 'WIN64' then
    Result := wplatWin64;
end;

function IsWow64Process: Boolean;
type
  TIsWow64Process = function(AHandle: THandle; var AIsWow64: BOOL)
    : BOOL; stdcall;

var
  hIsWow64Process: TIsWow64Process;
  hKernel32: HMODULE;
  IsWow64: BOOL;

begin
{$IFDEF CPUX64}
  // Se o código é 64 bits, o Windows também é 64 bits
  Result := True;
{$ELSE}
  // Se o código é 32 bits, usa a função IsWow64Process
  Result := False;

  hKernel32 := Winapi.Windows.LoadLibrary('kernel32.dll');
  if hKernel32 = 0 then
    Exit;

  try
    @hIsWow64Process := Winapi.Windows.GetProcAddress(hKernel32,
      'IsWow64Process');
    if not System.Assigned(hIsWow64Process) then
      Exit;

    IsWow64 := False;
    if hIsWow64Process(Winapi.Windows.GetCurrentProcess, IsWow64) then
      Result := IsWow64;

  finally
    Winapi.Windows.FreeLibrary(hKernel32);
  end;
{$ENDIF}
end;

function GetProgramFilesPath: string;
var
  ProgramFilesPath: string;
begin
  ProgramFilesPath := GetEnvironmentVariable('ProgramFiles');
  Result := ProgramFilesPath;
end;

function ExecutePrograma(Nome, Parametros, Pasta: string;
  out pErro: string): Boolean;
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
    pErro := 'ExecutePrograma ' + SysErrorMessage(GetLastError);
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

// função que retorna o conteúdo da área de transferência como uma string
function GetClipboardText: string;
begin
  // verifica se a área de transferência contém texto
  if Clipboard.HasFormat(CF_TEXT) then
    // retorna o texto da área de transferência
    Result := Clipboard.AsText
  else
    // retorna uma string vazia se não houver texto
    Result := '';
end;

procedure CopyTextToClipboard(const AText: string);
begin
  SetClipboardText(AText);
end;

// procedimento que recebe uma string e coloca na área de transferência
procedure SetClipboardText(const AText: string);
begin
  // limpa a área de transferência
  Clipboard.Clear;
  Sleep(200);
  // coloca a string na área de transferência
  Clipboard.AsText := AText;
  Sleep(200);
end;

procedure ExplorerPasta(pPasta: string);
begin
  if DirectoryExists(pPasta) then
  begin
    // Usa ShellExecute para abrir o Explorer no caminho especificado
    ShellExecute(0, 'open', PChar('explorer.exe'), PChar(pPasta), nil,
      SW_SHOWNORMAL);
  end
  else
  begin
    // Mostra mensagem de erro se o caminho não existir
    //ShowMessage('O caminho especificado não existe: ' + pPasta);
  end;
end;

procedure PegarIdMaquina(out pNome: string; out pIp: string);
var
  Buffer: array [0 .. MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWORD;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  // Get the computer name
  Size := Length(Buffer);
  if GetComputerName(Buffer, Size) then
    pNome := Buffer
  else
    pNome := '';

  // Get the IP address
  WSAStartup($101, WSAData);
  try
    HostEnt := gethostbyname(PAnsiChar(AnsiString(pNome)));
    if HostEnt <> nil then
      pIp := Format('%d.%d.%d.%d', [Byte(HostEnt^.h_addr^[0]),
        Byte(HostEnt^.h_addr^[1]), Byte(HostEnt^.h_addr^[2]),
        Byte(HostEnt^.h_addr^[3])])
    else
      pIp := '';
  finally
    WSACleanup;
  end;
end;

end.
