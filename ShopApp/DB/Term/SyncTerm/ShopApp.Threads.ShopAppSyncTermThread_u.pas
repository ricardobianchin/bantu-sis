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
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
  end;

implementation

uses Sis.Entities.Types;

{ TShopAppAppSyncTermThread }

constructor TShopAppAppSyncTermThread.Create(pTerminal: ITerminal;
  pAppObj: IAppObj; pExecutandoSafeBool: ISafeBool; pTitOutput,
  pStatusOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pTerminal, pAppObj, pExecutandoSafeBool, pTitOutput,
    pStatusOutput, pProcessLog);
  NameThreadForDebugging('ShopSyncTerm'+pTerminal.TerminalId.ToString);
end;

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
