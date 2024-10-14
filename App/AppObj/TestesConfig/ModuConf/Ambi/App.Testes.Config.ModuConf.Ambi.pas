unit App.Testes.Config.ModuConf.Ambi;

interface

uses //
  App.Testes.Config.ModuConf.Ambi.Loja //
  ; //

type
  ITesteConfigModuConfAmbi = interface(IInterface)
    ['{308D5540-8933-4A64-BA7B-57B771F81241}']
    function GetLoja: ITesteConfigModuConfAmbiLoja;
    property Loja: ITesteConfigModuConfAmbiLoja read GetLoja;
  end;

implementation

end.
