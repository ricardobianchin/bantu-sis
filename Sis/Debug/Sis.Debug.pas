unit Sis.Debug;

interface

function DelphiIsOpen: Boolean;
procedure ExecutarNotepadPlusPlus(const Arquivo: string);

implementation

uses sysutils, windows, sis.win.registry, System.Win.Registry, // Unit que contém a classe TRegistry
  Winapi.ShellAPI; // Unit que contém a função ShellExecute

function DelphiIsOpen: Boolean;
var
  ihwnd: HWND;
begin
  ihwnd := FindWindow('TAppBuilder', nil); // Procura pela janela do Delphi
  Result := ihwnd <> 0; // Retorna true se a janela existir
end;

procedure ExecutarNotepadPlusPlus(const Arquivo: string);
var
  Reg: TRegistry; // Variável para instanciar TRegistry
  NotepadPath: string;
  Parametro: string;
begin
  // Criar uma instância de TRegistry
  Reg := TRegistry.Create;
  try
    // Acessar a chave HKEY_LOCAL_MACHINE
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    // Abrir a subchave que contém o caminho do Notepad++
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe') then
    begin
      // Ler o valor padrão da subchave e atribuir à variável NotepadPath
      NotepadPath := Reg.ReadString('');
      // Fechar a subchave
      Reg.CloseKey;
    end
    else
      raise Exception.Create('Notepad++ não encontrado no registro');
  finally
    // Liberar a instância de TRegistry
    Reg.Free;
  end;

  // Verificar se o arquivo existe
  if not FileExists(Arquivo) then
    raise Exception.CreateFmt('Arquivo %s não encontrado', [Arquivo]);

  // Montar o parâmetro com o nome do arquivo entre aspas
  Parametro := '"' + Arquivo + '"';

  // Executar o Notepad++ com o parâmetro
  ShellExecute(0, 'open', PChar(NotepadPath), PChar(Parametro), nil, SW_SHOWNORMAL);
end;

end.
