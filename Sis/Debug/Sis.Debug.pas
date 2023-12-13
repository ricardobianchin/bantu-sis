unit Sis.Debug;

interface

function DelphiIsOpen: Boolean;
procedure ExecutarNotepadPlusPlus(const Arquivo: string);

implementation

uses sysutils, windows, sis.win.registry, System.Win.Registry, // Unit que cont�m a classe TRegistry
  Winapi.ShellAPI; // Unit que cont�m a fun��o ShellExecute

function DelphiIsOpen: Boolean;
var
  ihwnd: HWND;
begin
  ihwnd := FindWindow('TAppBuilder', nil); // Procura pela janela do Delphi
  Result := ihwnd <> 0; // Retorna true se a janela existir
end;

procedure ExecutarNotepadPlusPlus(const Arquivo: string);
var
  Reg: TRegistry; // Vari�vel para instanciar TRegistry
  NotepadPath: string;
  Parametro: string;
begin
  // Criar uma inst�ncia de TRegistry
  Reg := TRegistry.Create;
  try
    // Acessar a chave HKEY_LOCAL_MACHINE
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    // Abrir a subchave que cont�m o caminho do Notepad++
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe') then
    begin
      // Ler o valor padr�o da subchave e atribuir � vari�vel NotepadPath
      NotepadPath := Reg.ReadString('');
      // Fechar a subchave
      Reg.CloseKey;
    end
    else
      raise Exception.Create('Notepad++ n�o encontrado no registro');
  finally
    // Liberar a inst�ncia de TRegistry
    Reg.Free;
  end;

  // Verificar se o arquivo existe
  if not FileExists(Arquivo) then
    raise Exception.CreateFmt('Arquivo %s n�o encontrado', [Arquivo]);

  // Montar o par�metro com o nome do arquivo entre aspas
  Parametro := '"' + Arquivo + '"';

  // Executar o Notepad++ com o par�metro
  ShellExecute(0, 'open', PChar(NotepadPath), PChar(Parametro), nil, SW_SHOWNORMAL);
end;

end.
