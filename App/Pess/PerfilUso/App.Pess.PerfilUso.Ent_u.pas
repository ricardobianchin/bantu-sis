unit App.Pess.PerfilUso.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Pess.PerfilUso.Ent;

type
  TPerfilUsoEnt = class(TEntIdDescr, IPerfilUsoEnt)
  private
    FDeSistema: boolean;

    function GetDeSistema: boolean;
    procedure SetDeSistema(Value: boolean);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetDescrCaption: string; override;
  public
    property DeSistema: boolean read GetDeSistema write SetDeSistema;
  end;

implementation

{ TPerfilUsoEnt }

function TPerfilUsoEnt.GetDescrCaption: string;
begin
  Result := 'Perfil de Uso';
end;

function TPerfilUsoEnt.GetDeSistema: boolean;
begin
  Result := FDeSistema;
end;

function TPerfilUsoEnt.GetNomeEnt: string;
begin
  Result := 'PerfilUso';
end;

function TPerfilUsoEnt.GetNomeEntAbrev: string;
begin
  Result := 'PerfilUso';
end;

function TPerfilUsoEnt.GetTitulo: string;
begin
  Result := 'Perfis de Uso';
end;

procedure TPerfilUsoEnt.SetDeSistema(Value: boolean);
begin
  FDeSistema := Value;
end;

end.
