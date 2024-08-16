unit App.Acesso.PerfilDeUso.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Acesso.PerfilDeUso.Ent;

type
  TPerfilDeUsoEnt = class(TEntIdDescr, IPerfilDeUsoEnt)
  private
    FDeSistema: boolean;
    FUsuariosApelidos: string;

    function GetDeSistema: boolean;
    procedure SetDeSistema(Value: boolean);

    function GetUsuariosApelidos: string;
    procedure SetUsuariosApelidos(Value: string);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetDescrCaption: string; override;

  public
    procedure LimparEnt; override;

    property DeSistema: boolean read GetDeSistema write SetDeSistema;
    property UsuariosApelidos: string read GetUsuariosApelidos write SetUsuariosApelidos;
  end;

implementation

{ TPerfilDeUsoEnt }

function TPerfilDeUsoEnt.GetDescrCaption: string;
begin
  Result := 'Perfil de Uso';
end;

function TPerfilDeUsoEnt.GetDeSistema: boolean;
begin
  Result := FDeSistema;
end;

function TPerfilDeUsoEnt.GetNomeEnt: string;
begin
  Result := 'PerfilDeUso';
end;

function TPerfilDeUsoEnt.GetNomeEntAbrev: string;
begin
  Result := 'PerfilDeUso';
end;

function TPerfilDeUsoEnt.GetTitulo: string;
begin
  Result := 'Perfis de Uso';
end;

function TPerfilDeUsoEnt.GetUsuariosApelidos: string;
begin
  Result := FUsuariosApelidos;
end;

procedure TPerfilDeUsoEnt.LimparEnt;
begin
  inherited;
  FDeSistema := False;
  FUsuariosApelidos := '';
end;

procedure TPerfilDeUsoEnt.SetDeSistema(Value: boolean);
begin
  FDeSistema := Value;
end;

procedure TPerfilDeUsoEnt.SetUsuariosApelidos(Value: string);
begin
  FUsuariosApelidos := Value;
end;

end.
