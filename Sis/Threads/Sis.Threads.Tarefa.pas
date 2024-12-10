unit Sis.Threads.Tarefa;

interface

type
  ITarefa = interface(IInterface)
    ['{96FD48B4-7170-40BC-9E8F-343FE3DACEF7}']
    procedure Execute;
    procedure Terminate;
    procedure EspereTerminar;
  end;

  TTarefaProcedure = reference to procedure(pTarefa: ITarefa);

implementation

end.
