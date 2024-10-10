unit App.Testes.Config.ModuRetag.Ajuda.BemVindo;

interface

uses App.Testes.Config.ModuRetag.Ajuda.BemVindo.Terminais;

type
  ITesteConfigModuRetagAjudaBemVindo = interface(IInterface)
    ['{BE2B3E1D-F871-4C96-B973-B7093558A431}']

    function GetTerminais: ITesteConfigModuRetagAjudaBemVindoTerminais;
    property Terminais: ITesteConfigModuRetagAjudaBemVindoTerminais read GetTerminais;
  end;

implementation

end.
