unit App.Testes.Config.ModuRetag;

interface

uses App.Testes.Config.ModuRetag.Acesso;

type
  ITesteConfigModuRetag = interface(IInterface)
    ['{FD4958D5-E6DF-4AE6-B9C3-B2D619113A5C}']
    function GetAcesso: ITesteConfigModuRetagAcesso;
    property Acesso: ITesteConfigModuRetagAcesso read GetAcesso;
  end;

implementation

end.
