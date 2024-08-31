unit App.Pess.Cliente.Ent_u;

interface

uses App.Pess.Cliente.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessClienteEnt = class(TPessEnt, IPessClienteEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
  public
  end;

implementation

uses Data.DB;

{ TPessClienteEnt }

function TPessClienteEnt.GetNomeEnt: string;
begin
  Result := 'Cliente';
end;

function TPessClienteEnt.GetNomeEntAbrev: string;
begin
  Result := 'Cli';
end;

function TPessClienteEnt.GetTitulo: string;
begin
  Result := 'Clientes';
end;

end.
