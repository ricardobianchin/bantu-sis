unit App.Testes.Config.ModuRetag.Est.Produtos_u;

interface

uses App.Testes.Config.ModuRetag.Est.Produtos;

type
  TTesteConfigModuRetagEstProdutos = class(TInterfacedObject, ITesteConfigModuRetagEstProdutos)
  private
    FAutoExec: boolean;
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagEstProdutos }

constructor TTesteConfigModuRetagEstProdutos.Create;
begin
  FAutoExec := False;
end;

function TTesteConfigModuRetagEstProdutos.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

procedure TTesteConfigModuRetagEstProdutos.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

end.
