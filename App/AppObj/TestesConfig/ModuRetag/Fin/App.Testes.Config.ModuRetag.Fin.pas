unit App.Testes.Config.ModuRetag.Fin;

interface

uses App.Testes.Config.ModuRetag.Fin.PagamentoForma;

type
  ITesteConfigModuRetagFin = interface(IInterface)
    ['{720BC4B5-9060-45AD-ABD6-9D8F8E0C94CB}']
    function GetPagamentoForma: ITesteConfigModuRetagFinPagamentoForma;
    property PagamentoForma: ITesteConfigModuRetagFinPagamentoForma read GetPagamentoForma;
  end;

implementation

end.
