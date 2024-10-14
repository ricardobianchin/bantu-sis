unit App.Testes.Config.ModuRetag.Ajuda_u;

interface

uses App.Testes.Config.ModuRetag.Ajuda, App.Testes.Config.ModuRetag.Ajuda.BemVindo;

type
  TTesteConfigModuRetagAjuda = class(TInterfacedObject, ITesteConfigModuRetagAjuda)
  private
    FBemVindo: ITesteConfigModuRetagAjudaBemVindo;

    function GetBemVindo: ITesteConfigModuRetagAjudaBemVindo;
  public
    property BemVindo: ITesteConfigModuRetagAjudaBemVindo read GetBemVindo;

    constructor Create;
  end;

implementation

{ TTesteConfigModuRetagAjuda }

uses App.Testes.Config.Factory;

constructor TTesteConfigModuRetagAjuda.Create;
begin
  FBemVindo := ModuRetagAjudaBemVindoCreate;
end;

function TTesteConfigModuRetagAjuda.GetBemVindo: ITesteConfigModuRetagAjudaBemVindo;
begin
  Result := FBemVindo
end;

end.
