unit App.Testes.Config.ModuRetag.Acesso.Funcionario_u;

interface

uses App.Testes.Config.ModuRetag.Acesso.Funcionario;

type
  TTesteConfigModuRetagAcessoFuncionario = class(TInterfacedObject, ITesteConfigModuRetagAcessoFuncionario)
  private
    FAutoExec: boolean;
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagAcessoFuncionario }

constructor TTesteConfigModuRetagAcessoFuncionario.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuRetagAcessoFuncionario.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuRetagAcessoFuncionario.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
