unit App.Retag.Est.Prod.Tipo_u;

interface

uses Data.DB, App.Entidade.Ed.Id.Descr_u;

type
  TProdTipo = class(TEntIdDescr)
  private
  protected
    function GetNome: string; override;
    function GetTitulo: string; override;
  public
  end;

implementation

{ TProdTipo }

function TProdTipo.GetNome: string;
begin
  Result := 'Tipo de Item';
end;

function TProdTipo.GetTitulo: string;
begin
  Result := 'Tipos de Item';
end;

end.
