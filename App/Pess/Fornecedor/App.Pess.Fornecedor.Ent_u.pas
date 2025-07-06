unit App.Pess.Fornecedor.Ent_u;

interface

uses App.Pess.Fornecedor.Ent, App.Pess.Ent_u, App.PessEnder.List,
  App.Pess.Utils;

type
  TPessFornecedorEnt = class(TPessEnt, IPessFornecedorEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetCObrigatorio: boolean; override;
  public
  end;

implementation

uses Data.DB;

{ TPessFornecedorEnt }

function TPessFornecedorEnt.GetCObrigatorio: boolean;
begin
  Result := True;
end;

function TPessFornecedorEnt.GetNomeEnt: string;
begin
  Result := 'Fornecedor';
end;

function TPessFornecedorEnt.GetNomeEntAbrev: string;
begin
  Result := 'Fornec';
end;

function TPessFornecedorEnt.GetTitulo: string;
begin
  Result := 'Fornecedores';
end;

end.
