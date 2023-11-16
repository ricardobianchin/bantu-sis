unit btu.lib.types.bool.ProcQueryBoolean;

interface

type
  // e se o nome fosse este? IFeedbackBoolean
  // nao confundiria com query sql...
  // por outro lado, nada impedue que um uso futuro seja ler de um sql...
  IProcQueryBoolean = interface(IInterface)
    ['{CBBD3FB1-EAC7-424E-A2D4-F3827E39E822}']
    function GetBoolean: boolean;
  end;

implementation

end.
