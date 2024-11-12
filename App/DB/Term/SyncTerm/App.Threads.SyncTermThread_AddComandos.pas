unit App.Threads.SyncTermThread_AddComandos;

interface

type
  ISyncTermAddComandos = interface(IInterface)
    ['{0B174213-641B-482C-901A-B803371B8B40}']
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64);
  end;

implementation

end.
