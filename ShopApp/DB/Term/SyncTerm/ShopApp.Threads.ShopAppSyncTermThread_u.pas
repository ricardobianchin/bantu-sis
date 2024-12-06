unit ShopApp.Threads.ShopAppSyncTermThread_u;

interface

uses App.Threads.SyncTermThread_u, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj, Sis.Entities.Terminal, Sis.Threads.SafeBool;

type
  TShopAppAppSyncTermThread = class(TAppSyncTermThread)
  private
  protected
    procedure RegistreAddComands(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pSql: TStrings); override;

    ///////
    // EXECUTE
    ///////
    procedure Execute; override;

  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
  end;

implementation

uses Sis.Entities.Types, ShopApp.Threads.ShopAppSyncTermThread.Factory_u;

{ TShopAppAppSyncTermThread }

constructor TShopAppAppSyncTermThread.Create(pTerminal: ITerminal;
  pAppObj: IAppObj; pExecutandoSafeBool: ISafeBool;
  pTitOutput, pStatusOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pTerminal, pAppObj, pExecutandoSafeBool, pTitOutput,
    pStatusOutput, pProcessLog);
  NameThreadForDebugging('ShopSyncTerm' + pTerminal.TerminalId.ToString);
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

procedure TShopAppAppSyncTermThread.RegistreAddComands(pAppObj: IAppObj;
  pTerminal: ITerminal; pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  inherited;
  AddCommandsList.Add(AddComandosProdShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
  AddCommandsList.Add(AddComandosProdCustoShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
  AddCommandsList.Add(AddComandosProdPrecoShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
end;

end.
