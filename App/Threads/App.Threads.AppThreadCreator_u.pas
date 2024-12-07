unit App.Threads.AppThreadCreator_u;

interface

uses Sis.Threads.ThreadBasCreator_u, Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool, App.AppObj;

type
  TAppThreadCreator = class(TThreadCreator)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; {pExecutandoSafeBool: ISafeBool;}
    pOnTerminate: TNotifyEvent;

      pThreadTitulo: string = '');
  end;

implementation

{ TAppThreadCreator }

constructor TAppThreadCreator.Create(pAppObj: IAppObj;
  {pExecutandoSafeBool: ISafeBool;} pOnTerminate: TNotifyEvent;
  pThreadTitulo: string);
begin
  inherited Create({pExecutandoSafeBool, }pOnTerminate, pThreadTitulo);
  FAppObj := pAppObj;
end;

end.
