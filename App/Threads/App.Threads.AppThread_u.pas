unit App.Threads.AppThread_u;

interface

uses Sis.UI.IO.Output, Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj, Sis.Threads.SafeBool;

type
  TAppThread = class(TThreadBas)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; //pExecutandoSafeBool: ISafeBool;
      pThreadTitulo: string = '');
  end;

implementation

{ TAppThread }

constructor TAppThread.Create(pAppObj: IAppObj; //pExecutandoSafeBool: ISafeBool;
  pThreadTitulo: string);
begin
  inherited Create({pExecutandoSafeBool,} pThreadTitulo);
  FAppObj := pAppObj
end;

end.
