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
    constructor Create(pState: TDataSetState; pId: integer = 0; pDescr: string = '');
  end;

implementation

{ TProdFabr }

constructor TProdFabr.Create(pState: TDataSetState; pId: integer;
  pDescr: string);
begin
  inherited Create(pState, pId, pDescr);
end;

function TProdFabr.GetNome: string;
begin
  Result := 'Fabricante';
end;

function TProdFabr.GetTitulo: string;
begin
  Result := 'Fabricantes';
end;

end.
