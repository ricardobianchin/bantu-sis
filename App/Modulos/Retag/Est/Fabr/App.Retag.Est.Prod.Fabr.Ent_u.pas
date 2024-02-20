unit App.Retag.Est.Prod.Fabr.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Retag.Est.Prod.Fabr.Ent;

type
  TProdFabrEnt = class(TEntIdDescr, IProdFabrEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetDescrCaption: string; override;
  public
  end;

implementation

{ TProdFabrEnt }

function TProdFabrEnt.GetNomeEntAbrev: string;
begin
  Result := 'Fabr';
end;

function TProdFabrEnt.GetDescrCaption: string;
begin
  Result := 'Nome';
end;

function TProdFabrEnt.GetNomeEnt: string;
begin
  Result := 'Fabricante';
end;

function TProdFabrEnt.GetTitulo: string;
begin
  Result := 'Fabricantes';
end;

end.
