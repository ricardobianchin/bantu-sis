unit App.Threads.SyncTermThreadCreator_u;

interface

uses App.Threads.TermThreadCreator_u, Sis.Threads.ThreadCreator,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.SafeBool, Sis.Entities.Terminal, App.AppObj;

type
  TAppSyncTermThreadCreator = class(TTermThreadCreator)
  private
  public
  end;

implementation

{ TAppSyncTermThreadCreator }

end.
