unit App.Testes.Config.ModuRetag_u;

interface

uses App.Testes.Config.ModuRetag, App.Testes.Config.ModuRetag.Acesso;

type
  TTesteConfigModuRetag = class(TInterfacedObject, ITesteConfigModuRetag)
  private
    FAcesso: ITesteConfigModuRetagAcesso;
    function GetAcesso: ITesteConfigModuRetagAcesso;
  public
    property Acesso: ITesteConfigModuRetagAcesso read GetAcesso;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetag }

constructor TTesteConfigModuRetag.Create;
begin
  FAcesso := ModuRetagAcessoCreate;
end;

function TTesteConfigModuRetag.GetAcesso: ITesteConfigModuRetagAcesso;
begin
  Result := FAcesso;
end;

end.
