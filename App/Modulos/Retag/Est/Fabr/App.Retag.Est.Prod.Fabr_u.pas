unit App.Retag.Est.Prod.Fabr_u;

interface

uses App.Retag.Est.Prod.Fabr, App.Entidade.Ed.Id.Descr, Data.DB,
  App.Entidade.Ed.Id.Descr_u;

type
  TProdFabr = class(TEntIdDescr, IProdFabr)
  private
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

end.
