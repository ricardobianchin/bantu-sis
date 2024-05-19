unit Sis.Win.ConsoleApp_u;

interface

uses Sis.Win.ConsoleApp, Windows, Classes, SysUtils;

const
  READ_BUFFER_SIZE = 2400;

type
  TConsoleApp = class(TInterfacedObject, IConsoleApp)
  private
  public
    function ExecutarComando(DosApp: string): string;
  end;

implementation

{ TConsoleApp }

function TConsoleApp.ExecutarComando(DosApp: string): string;
var
    Security: TSecurityAttributes;
    ReadableEndOfPipe, WriteableEndOfPipe: THandle;
    Start: TStartUpInfo;
    ProcessInfo: TProcessInformation;
    Buffer: array [0 .. READ_BUFFER_SIZE] of AnsiChar;
    BytesRead: Cardinal;
begin
  Result := '';
  Security.nLength := SizeOf(TSecurityAttributes);
  Security.bInheritHandle := True;
  Security.lpSecurityDescriptor := nil;

  if CreatePipe(ReadableEndOfPipe, WriteableEndOfPipe, @Security, 0) then
  begin
    FillChar(Start, SizeOf(TStartUpInfo), 0);
    Start.cb := SizeOf(TStartUpInfo);
    Start.hStdOutput := WriteableEndOfPipe;
    Start.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    Start.wShowWindow := SW_HIDE;

    if CreateProcess(nil, PChar(DosApp), nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, Start, ProcessInfo) then
    begin
      CloseHandle(WriteableEndOfPipe);
      repeat
        if ReadFile(ReadableEndOfPipe, Buffer, READ_BUFFER_SIZE, BytesRead, nil) then
          Result := Result + Buffer;
      until BytesRead = 0;
      CloseHandle(ReadableEndOfPipe);
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
  end;
end;

end.
