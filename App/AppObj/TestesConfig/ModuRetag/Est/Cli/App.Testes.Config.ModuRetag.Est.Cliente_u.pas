unit App.Testes.Config.ModuRetag.Est.Cliente_u;

interface

uses App.Testes.Config.ModuRetag.Est.Cliente;

type
  TTesteConfigModuRetagEstCliente = class(TInterfacedObject, ITesteConfigModuRetagEstCliente)
  private
    FAutoExec: boolean;
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagEstCliente }

constructor TTesteConfigModuRetagEstCliente.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuRetagEstCliente.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuRetagEstCliente.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
