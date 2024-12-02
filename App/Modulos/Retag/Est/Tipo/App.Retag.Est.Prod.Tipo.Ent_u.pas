unit App.Retag.Est.Prod.Tipo.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Retag.Est.Prod.Tipo.Ent;

type
  TProdTipoEnt = class(TEntIdDescr, IProdTipoEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
  public
  end;

implementation

{ TProdTipoEnt }

function TProdTipoEnt.GetNomeEntAbrev: string;
begin
  Result := 'ProdTipo';
end;

function TProdTipoEnt.GetNomeEnt: string;
begin
  Result := 'Tipo';
end;

function TProdTipoEnt.GetTitulo: string;
begin
  Result := 'Tipos';
end;

end.
