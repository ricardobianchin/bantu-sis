unit App.Testes.Config.ModuRetag.Est_u;

interface

uses App.Testes.Config.ModuRetag.Est
  , App.Testes.Config.ModuRetag.Est.Cliente
  , App.Testes.Config.ModuRetag.Est.Produtos
  ;

type
  TTesteConfigModuRetagEst = class(TInterfacedObject, ITesteConfigModuRetagEst)
  private
    FCliente: ITesteConfigModuRetagEstCliente;
    FProdutos: ITesteConfigModuRetagEstProdutos;

    function GetCliente: ITesteConfigModuRetagEstCliente;
    function GetProdutos: ITesteConfigModuRetagEstProdutos;
  public
    property Cliente: ITesteConfigModuRetagEstCliente read GetCliente;
    property Produtos: ITesteConfigModuRetagEstProdutos read GetProdutos;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetagEst }

constructor TTesteConfigModuRetagEst.Create;
begin
  FCliente := ModuRetagEstClienteCreate;
  FProdutos := ModuRetagEstProdutosCreate;
end;

function TTesteConfigModuRetagEst.GetCliente: ITesteConfigModuRetagEstCliente;
begin
  Result := FCliente;
end;

function TTesteConfigModuRetagEst.GetProdutos: ITesteConfigModuRetagEstProdutos;
begin
  Result := FProdutos;
end;

end.
