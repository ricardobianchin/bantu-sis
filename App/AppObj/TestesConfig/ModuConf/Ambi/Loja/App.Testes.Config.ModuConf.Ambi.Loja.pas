unit App.Testes.Config.ModuConf.Ambi.Loja;

interface

type
  ITesteConfigModuConfAmbiLoja = interface(IInterface)
    ['{C0C35B10-A0B2-4CC5-8971-D4A548F35CD0}']
    function GetAutoExec: Boolean;
    procedure SetAutoExec(Value: Boolean);
    property AutoExec: Boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
