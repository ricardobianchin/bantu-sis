unit Sis.Threads.ThreadCreator;

interface

uses Sis.Threads.ThreadBas_u;

type
  IThreadCreator = interface(IInterface)
    ['{EE68214D-0152-4967-8992-B4AA39721AEC}']
    function ThreadBasCreate: TThreadBas;
  end;

implementation

end.
