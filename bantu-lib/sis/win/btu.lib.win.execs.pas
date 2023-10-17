unit btu.lib.win.execs;

interface

function ExecutePrograma(Nome, Parametros, Pasta: string; out pErro: string): boolean;

implementation

uses
  Vcl.Clipbrd, Winapi.ShellAPI, Winapi.Windows, System.SysUtils, Vcl.Forms;

// Procedure que recebe o nome de um executável, uma string com os seus parâmetros e uma string com a pasta inicial
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
    pErro := SysErrorMessage(GetLastError);
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
