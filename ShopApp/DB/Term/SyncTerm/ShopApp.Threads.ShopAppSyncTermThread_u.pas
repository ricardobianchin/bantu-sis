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
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj; pExecutando: ISafeBool;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pThreadTitulo: string = '');
  end;

implementation

uses Sis.Entities.Types, ShopApp.Threads.ShopAppSyncTermThread.Factory_u;

{ TShopAppAppSyncTermThread }

constructor TShopAppAppSyncTermThread.Create(pTerminal: ITerminal; pAppObj: IAppObj; pExecutando: ISafeBool;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pThreadTitulo: string);
begin
  inherited Create(pTerminal, pAppObj, pExecutando, pTitOutput, pStatusOutput,
    pProcessLog, pThreadTitulo);
  NameThreadForDebugging('ShopSyncTerm' + pTerminal.TerminalId.ToString);
end;

procedure TShopAppAppSyncTermThread.Execute;
begin
//  SetExecutando(True);
  try
    inherited;
  finally
//    SetExecutando(False);
  end;
end;

procedure TShopAppAppSyncTermThread.RegistreAddComands(pAppObj: IAppObj;
  pTerminal: ITerminal; pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  inherited;
  AddCommandsList.Add(ProcLogProdShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
  AddCommandsList.Add(ProcLogProdCustoShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
  AddCommandsList.Add(ProcLogProdPrecoShop(pAppObj, pTerminal, pServCon,
    pTermCon, DBExecScript));
end;

end.
