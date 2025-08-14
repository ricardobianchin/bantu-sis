unit Sis.Sis.InstanciaAtomica_u;

interface

//foi ma ideia pois o MutexHandle nao sofreria CloseHandle na prim instancia

//uses Vcl.Forms;

//function PrecisaFecharApp(pPrincForm: TForm): Boolean;

implementation
(*
uses Winapi.Windows;

function PrecisaFecharApp(pPrincForm: TForm): Boolean;
var
  Handle, HandleId: THandle;
  // Evita carga dupla da aplicacao
begin
  Handle := CreateMutex(nil, True, '9DC5D990-AAF7-480A-9892-02AF9D0E72ED');
  Result := GetLastError = ERROR_ALREADY_EXISTS;
  if Result then
  begin
    HandleId := FindWindow(PWideChar(pPrincForm.ClassName), nil);
    if not IsWindowVisible(Handle) then
    begin
      ShowWindow(HandleId, SW_RESTORE);
      SetForegroundWindow(HandleId);
    end;
    if Handle <> 0 then
      CloseHandle(Handle);
    Application.Terminate;
    exit;
  end;
end;
*)
end.
