unit App.Testes.Config.ModuRetag;

interface

uses
  App.Testes.Config.ModuRetag.Acesso //
  , App.Testes.Config.ModuRetag.Est //
  , App.Testes.Config.ModuRetag.Fin //
  , App.Testes.Config.ModuRetag.Ajuda //
  ;

type
  ITesteConfigModuRetag = interface(IInterface)
    ['{FD4958D5-E6DF-4AE6-B9C3-B2D619113A5C}']
    function GetAcesso: ITesteConfigModuRetagAcesso;
    property Acesso: ITesteConfigModuRetagAcesso read GetAcesso;

    function GetEst: ITesteConfigModuRetagEst;
    property Est: ITesteConfigModuRetagEst read GetEst;

    function GetFin: ITesteConfigModuRetagFin;
    property Fin: ITesteConfigModuRetagFin read GetFin;

    function GetAjuda: ITesteConfigModuRetagAjuda;
    property Ajuda: ITesteConfigModuRetagAjuda read GetAjuda;
  end;

implementation

end.
