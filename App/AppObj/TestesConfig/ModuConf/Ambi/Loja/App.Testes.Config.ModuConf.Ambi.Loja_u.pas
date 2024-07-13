unit App.Testes.Config.ModuConf.Ambi.Loja_u;

interface

uses App.Testes.Config.ModuConf.Ambi.Loja;

type
  TTesteConfigModuConfAmbiLoja = class(TInterfacedObject, ITesteConfigModuConfAmbiLoja)
  private
    FAutoExec: boolean;

    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuConfAmbiLoja }

constructor TTesteConfigModuConfAmbiLoja.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuConfAmbiLoja.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuConfAmbiLoja.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
