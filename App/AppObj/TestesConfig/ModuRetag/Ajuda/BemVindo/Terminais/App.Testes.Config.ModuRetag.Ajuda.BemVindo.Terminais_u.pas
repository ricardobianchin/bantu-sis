unit App.Testes.Config.ModuRetag.Ajuda.BemVindo.Terminais_u;

interface

uses App.Testes.Config.ModuRetag.Ajuda.BemVindo.Terminais;

type
  TTesteConfigModuRetagAjudaBemVindoTerminais = class(TInterfacedObject, ITesteConfigModuRetagAjudaBemVindoTerminais)
  private
    FSelectTerminalIds: string;
    FAutoExec: boolean;

    function GetSelectTerminalIds: string;
    procedure SetSelectTerminalIds(Value: string);

    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: Boolean);
  public
    property SelectTerminalIds: string read GetSelectTerminalIds write SetSelectTerminalIds;
    property AutoExec: Boolean read GetAutoExec write SetAutoExec;

    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagAjudaBemVindoTerminais }

constructor TTesteConfigModuRetagAjudaBemVindoTerminais.Create;
begin
  FSelectTerminalIds := '';
  FAutoExec := false;
end;

function TTesteConfigModuRetagAjudaBemVindoTerminais.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

function TTesteConfigModuRetagAjudaBemVindoTerminais.GetSelectTerminalIds: string;
begin
  Result := FSelectTerminalIds;
end;

procedure TTesteConfigModuRetagAjudaBemVindoTerminais.SetAutoExec(
  Value: Boolean);
begin
  FAutoExec := Value;
end;

procedure TTesteConfigModuRetagAjudaBemVindoTerminais.SetSelectTerminalIds(
  Value: string);
begin
  FSelectTerminalIds := Value;
end;

end.
