unit App.Testes.Config.ModuRetag.Fin_u;

interface

uses App.Testes.Config.ModuRetag.Fin, App.Testes.Config.ModuRetag.Fin.PagamentoForma;

type
  TTesteConfigModuRetagFin = class(TInterfacedObject, ITesteConfigModuRetagFin)
  private
    FPagamentoForma: ITesteConfigModuRetagFinPagamentoForma;

    function GetPagamentoForma: ITesteConfigModuRetagFinPagamentoForma;
  public
    property PagamentoForma: ITesteConfigModuRetagFinPagamentoForma read GetPagamentoForma;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTFineConfigModuRetagFin }

constructor TTesteConfigModuRetagFin.Create;
begin
  FPagamentoForma := ModuRetagFinPagamentoFormaCreate;
end;

function TTesteConfigModuRetagFin.GetPagamentoForma: ITesteConfigModuRetagFinPagamentoForma;
begin
  Result := FPagamentoForma;
end;

end.
