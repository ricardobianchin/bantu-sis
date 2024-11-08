unit App.Testes.Config.ModuRetag.Fin.PagamentoForma_u;

interface

uses App.Testes.Config.ModuRetag.Fin.PagamentoForma;

type
  TTesteConfigModuRetagFinPagamentoForma = class(TInterfacedObject, ITesteConfigModuRetagFinPagamentoForma)
  private
    FAutoExec: boolean;
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagFinPagamentoForma }

constructor TTesteConfigModuRetagFinPagamentoForma.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuRetagFinPagamentoForma.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuRetagFinPagamentoForma.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
