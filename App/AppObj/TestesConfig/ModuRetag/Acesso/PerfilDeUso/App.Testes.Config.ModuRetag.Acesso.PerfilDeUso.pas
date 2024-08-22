unit App.Testes.Config.ModuRetag.Acesso.PerfilDeUso;

interface

type
  ITesteConfigModuRetagAcessoPerfilDeUso = interface(IInterface)
    ['{CFF49061-0DEE-439C-A36F-B0AD40DF0438}']
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
