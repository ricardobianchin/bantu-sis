unit App.Testes.Config.ModuRetag.Ajuda;

interface

uses App.Testes.Config.ModuRetag.Ajuda.BemVindo;

type
  ITesteConfigModuRetagAjuda = interface(IInterface)
    ['{2F4D55BB-AC78-49A8-8CCA-72D232C00AD3}']
    function GetBemVindo: ITesteConfigModuRetagAjudaBemVindo;
    property BemVindo: ITesteConfigModuRetagAjudaBemVindo read GetBemVindo;
  end;

implementation

end.
