unit App.Testes.Config.ModuConf;

interface

uses App.Testes.Config.ModuConf.Ambi;

type
  ITesteConfigModuConf = interface(IInterface)
    ['{989B7672-E12A-44AE-B89B-2FBC90DEFC4B}']
    function GetAmbi: ITesteConfigModuConfAmbi;
    property Ambi: ITesteConfigModuConfAmbi read GetAmbi;
  end;

implementation

end.
