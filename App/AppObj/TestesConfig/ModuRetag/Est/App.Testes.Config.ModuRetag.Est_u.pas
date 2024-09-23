unit App.Testes.Config.ModuRetag.Est_u;

interface

uses App.Testes.Config.ModuRetag.Est, App.Testes.Config.ModuRetag.Est.Cliente;

type
  TTesteConfigModuRetagEst = class(TInterfacedObject, ITesteConfigModuRetagEst)
  private
    FCliente: ITesteConfigModuRetagEstCliente;

    function GetCliente: ITesteConfigModuRetagEstCliente;
  public
    property Cliente: ITesteConfigModuRetagEstCliente read GetCliente;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetagEst }

constructor TTesteConfigModuRetagEst.Create;
begin
  FCliente := ModuRetagEstClienteCreate;
end;

function TTesteConfigModuRetagEst.GetCliente: ITesteConfigModuRetagEstCliente;
begin
  Result := FCliente;
end;

end.
