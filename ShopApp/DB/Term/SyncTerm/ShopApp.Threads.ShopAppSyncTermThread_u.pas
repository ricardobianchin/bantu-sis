unit ShopApp.Threads.ShopAppSyncTermThread_u;

interface

uses App.Threads.SyncTermThread_u, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj, Sis.Entities.Terminal, Sis.Threads.SafeBool;

type
  TShopAppAppSyncTermThread = class(TAppSyncTermThread)
  private
  protected
      procedure Execute; override;

  public
  end;

implementation

{ TShopAppAppSyncTermThread }

procedure TShopAppAppSyncTermThread.Execute;
begin
  SetExecutando(True);
  try
    inherited;
  finally
    SetExecutando(False);
  end;

end;

end.
