unit ShopApp.Threads.ShopAppSyncTermThread_u;

interface

uses App.Threads.SyncTermThread_u, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj, Sis.Entities.Terminal, Sis.Threads.SafeBool, FireDAC.Comp.Client;

type
  TShopAppAppSyncTermThread = class(TAppSyncTermThread)
  private
  protected
    procedure RegistreProcLog(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pSql: TStrings); override;

    /// ////
    // EXECUTE
    /// ////
    procedure Execute; override;

  public
    constructor Create(pServFDConnection: TFDConnection;
      pTermFDConnection: TFDConnection; pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutando: ISafeBool; pTitOutput: IOutput; pStatusOutput: IOutput;
      pProcessLog: IProcessLog; pOnTerminate: TNotifyEvent;
      pThreadTitulo: string);
  end;

implementation

uses Sis.Entities.Types, ShopApp.Threads.ShopAppSyncTermThread.Factory_u;

{ TShopAppAppSyncTermThread }

constructor TShopAppAppSyncTermThread.Create(pServFDConnection: TFDConnection;
  pTermFDConnection: TFDConnection; pTerminal: ITerminal; pAppObj: IAppObj;
  pExecutando: ISafeBool; pTitOutput: IOutput; pStatusOutput: IOutput;
  pProcessLog: IProcessLog; pOnTerminate: TNotifyEvent; pThreadTitulo: string);
begin
  inherited Create(pServFDConnection, pTermFDConnection, pTerminal, pAppObj,
    pExecutando, pTitOutput, pStatusOutput, pProcessLog, pOnTerminate,
    pThreadTitulo);

  NameThreadForDebugging('ShopSyncTerm' + pTerminal.TerminalId.ToString);
end;

procedure TShopAppAppSyncTermThread.Execute;
begin
  Executando := True;
  try
    inherited;
  finally
    Executando := False;
  end;
end;

procedure TShopAppAppSyncTermThread.RegistreProcLog(pAppObj: IAppObj;
  pTerminal: ITerminal; pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  inherited;
  ProcLogList.Add(ProcLogProdShop(pAppObj, pTerminal, pServCon, pTermCon,
    DBExecScript));
  ProcLogList.Add(ProcLogProdCustoShop(pAppObj, pTerminal, pServCon, pTermCon,
    DBExecScript));
  ProcLogList.Add(ProcLogProdPrecoShop(pAppObj, pTerminal, pServCon, pTermCon,
    DBExecScript));
end;

end.
