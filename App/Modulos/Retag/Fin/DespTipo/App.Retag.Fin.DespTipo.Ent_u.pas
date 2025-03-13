unit App.Retag.Fin.DespTipo.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Retag.Fin.DespTipo.Ent;

type
  TDespTipoEnt = class(TEntIdDescr, IDespTipoEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetDescrCaption: string; override;
  public
  end;

implementation

{ TDespTipoEnt }

function TDespTipoEnt.GetDescrCaption: string;
begin
  Result := 'Descrição';
end;

function TDespTipoEnt.GetNomeEnt: string;
begin
  Result := 'Tipo de Despesas';
end;

function TDespTipoEnt.GetNomeEntAbrev: string;
begin
  Result := 'DespTipo';
end;

function TDespTipoEnt.GetTitulo: string;
begin
  Result := 'Tipos de Despesas';
end;

end.
