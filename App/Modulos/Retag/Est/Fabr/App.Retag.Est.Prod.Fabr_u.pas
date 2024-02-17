unit App.Retag.Est.Prod.Fabr_u;

interface

uses Data.DB, App.Entidade.Ed.Id.Descr_u;

type
  TProdFabr = class(TEntIdDescr)
  private
  protected
    function GetNome: string; override;
    function GetTitulo: string; override;
  public
  end;

implementation

{ TProdFabr }

function TProdFabr.GetNome: string;
begin
  Result := 'Fabricante';
end;

function TProdFabr.GetTitulo: string;
begin
  Result := 'Fabricantes';
end;

end.
