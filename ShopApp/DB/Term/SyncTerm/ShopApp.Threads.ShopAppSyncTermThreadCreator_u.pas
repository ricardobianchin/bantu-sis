unit ShopApp.Threads.ShopAppSyncTermThreadCreator_u;

interface

uses App.Threads.SyncTermThreadCreator_u, Sis.Threads.ThreadCreator,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Threads.ThreadBas_u,
  System.Classes, Sis.Threads.SafeBool, Sis.Entities.Terminal, App.AppObj,
  ShopApp.Threads.ShopAppSyncTermThread_u;

type
  TShopAppSyncTermThreadCreator = class(TAppSyncTermThreadCreator)
  protected
  public
    function ThreadBasCreate: TThreadBas; override;
  end;

implementation

{ TShopAppSyncTermThreadCreator }

function TShopAppSyncTermThreadCreator.ThreadBasCreate: TThreadBas;
begin
  Result := TShopAppAppSyncTermThread.Create(Terminal, AppObj, Executando,
    TitOutput, StatusOutput, ProcessLog);
end;

end.
