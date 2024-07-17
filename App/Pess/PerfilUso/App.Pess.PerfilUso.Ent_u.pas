unit App.Pess.PerfilUso.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Pess.PerfilUso.Ent;

type
  TProdFabrEnt = class(TEntIdDescr, IPessPerfilUso)
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

function TProdFabrEnt.GetDescrCaption: string;
begin
  Result := 'Perfil de Uso';
end;

function TProdFabrEnt.GetNomeEnt: string;
begin
  Result := 'PerfilUso';
end;

function TProdFabrEnt.GetNomeEntAbrev: string;
begin
  Result := 'PerfilUso';
end;

function TProdFabrEnt.GetTitulo: string;
begin
  Result := 'Perfis de Uso';
end;

end.
