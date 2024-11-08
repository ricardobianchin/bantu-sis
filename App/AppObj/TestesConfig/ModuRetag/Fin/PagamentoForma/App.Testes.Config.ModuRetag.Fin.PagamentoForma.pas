unit App.Testes.Config.ModuRetag.Fin.PagamentoForma;

interface

type
  ITesteConfigModuRetagFinPagamentoForma = interface(IInterface)
    ['{399725AC-9E05-49B9-9FCA-AFDA1C4E7B21}']
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
