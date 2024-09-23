unit App.Testes.Config.ModuRetag.Est.Cliente;

interface

type
  ITesteConfigModuRetagEstCliente = interface(IInterface)
    ['{BE22C48C-A7FC-4E25-8FDD-37C6FC21FEAA}']
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
