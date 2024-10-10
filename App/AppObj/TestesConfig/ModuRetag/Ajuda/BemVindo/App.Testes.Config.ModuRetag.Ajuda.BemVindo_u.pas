unit App.Testes.Config.ModuRetag.Ajuda.BemVindo_u;

interface

uses App.Testes.Config.ModuRetag.Ajuda.BemVindo, App.Testes.Config.ModuRetag.Ajuda.BemVindo.Terminais;

type
  TTesteConfigModuRetagAjudaBemVindo = class(TInterfacedObject, ITesteConfigModuRetagAjudaBemVindo)
  private
    FTerminais: ITesteConfigModuRetagAjudaBemVindoTerminais;

    function GetTerminais: ITesteConfigModuRetagAjudaBemVindoTerminais;
  public
    property Terminais: ITesteConfigModuRetagAjudaBemVindoTerminais read GetTerminais;
    constructor Create;
  end;


implementation

{ TTesteConfigModuRetagAjudaBemVindo }

uses App.Testes.Config.Factory;

constructor TTesteConfigModuRetagAjudaBemVindo.Create;
begin
  FTerminais := ModuRetagAjudaBemVindoTerminaisCreate;
end;

function TTesteConfigModuRetagAjudaBemVindo.GetTerminais: ITesteConfigModuRetagAjudaBemVindoTerminais;
begin
  Result := FTerminais
end;

end.
