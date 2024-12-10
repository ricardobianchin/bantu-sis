unit ShopApp.Threads.ShopAppSyncTermTarefa_u;

interface

uses App.Threads.SyncTermTarefa_u, Sis.Threads.ThreadBas_u;

type
  TShopAppSyncTermTarefa = class(TSyncTermTarefa)

  protected
    function GetThreadTitulo: string; override;
    function ThreadCreate: TThreadBas; override;
  end;

implementation

uses ShopApp.Threads.ShopAppSyncTermThread_u;

{ TShopAppSyncTermTarefa }

function TShopAppSyncTermTarefa.GetThreadTitulo: string;
begin
  Result := '';
end;

function TShopAppSyncTermTarefa.ThreadCreate: TThreadBas;
begin
  Result := TShopAppAppSyncTermThread.Create(ServDBConnectionParams,
    TermDBConnectionParams, Terminal, AppObj, Executando, Frame.TitOutput,
    Frame.StatusOutput, Frame.ProcessLog, DoThreadTerminate, ThreadTitulo);
end;

end.
