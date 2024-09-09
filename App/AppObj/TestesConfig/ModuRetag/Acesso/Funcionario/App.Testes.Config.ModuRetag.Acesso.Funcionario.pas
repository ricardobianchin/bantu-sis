unit App.Testes.Config.ModuRetag.Acesso.Funcionario;

interface

type
  ITesteConfigModuRetagAcessoFuncionario = interface(IInterface)
    ['{7C7399E8-AA36-4173-8C1F-0B1EF18E0EFB}']
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
  end;


implementation

end.
