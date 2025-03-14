unit App.Retag.Fin.DespTipo.Ent_u;

interface

uses Data.DB, App.Ent.Ed.Id.Descr_u, App.Retag.Fin.DespTipo.Ent;

type
  TDespTipoEnt = class(TEntIdDescr, IDespTipoEnt)
  private
    FLojaId: smallint;
    FUsuarioId: integer;
    FMachineIdentId: smallint;
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
    function GetDescrCaption: string; override;
    function GetLojaId: smallint;
    function GetUsuarioId: integer;
    function GetMachineIdentId: smallint;
  public
    property LojaId: smallint read GetLojaId;
    property UsuarioId: integer read GetUsuarioId;
    property MachineIdentId: smallint read GetMachineIdentId;

    constructor Create(pLojaId: smallint; pUsuarioId: integer;
      pMachineIdentId: smallint; pState: TDataSetState = dsBrowse;
      pId: integer = 0; pDescr: string = '');
  end;

implementation

{ TDespTipoEnt }

constructor TDespTipoEnt.Create(pLojaId: smallint; pUsuarioId: integer;
  pMachineIdentId: smallint; pState: TDataSetState; pId: integer;
  pDescr: string);
begin
  inherited Create(pState, pId, pDescr);
  FLojaId := pLojaId;
  FUsuarioId := pUsuarioId;
  FMachineIdentId := pMachineIdentId;
end;

function TDespTipoEnt.GetDescrCaption: string;
begin
  Result := 'Descrição';
end;

function TDespTipoEnt.GetLojaId: smallint;
begin
  Result := FLojaId;
end;

function TDespTipoEnt.GetMachineIdentId: smallint;
begin
  Result := FMachineIdentId;
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

function TDespTipoEnt.GetUsuarioId: integer;
begin
  Result := FUsuarioId;
end;

end.
