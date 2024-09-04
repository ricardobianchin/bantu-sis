unit App.Testes.Config.ModuRetag_u;

interface

uses
  App.Testes.Config.ModuRetag //
  , App.Testes.Config.ModuRetag.Acesso //
  , App.Testes.Config.ModuRetag.Est //
  ;

type
  TTesteConfigModuRetag = class(TInterfacedObject, ITesteConfigModuRetag)
  private
    FAcesso: ITesteConfigModuRetagAcesso;
    FEst: ITesteConfigModuRetagEst;

    function GetAcesso: ITesteConfigModuRetagAcesso;
    function GetEst: ITesteConfigModuRetagEst;
  public
    property Acesso: ITesteConfigModuRetagAcesso read GetAcesso;
    property Est: ITesteConfigModuRetagEst read GetEst;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetag }

constructor TTesteConfigModuRetag.Create;
begin
  FAcesso := ModuRetagAcessoCreate;
  FEst := ModuRetagEstCreate;
end;

function TTesteConfigModuRetag.GetAcesso: ITesteConfigModuRetagAcesso;
begin
  Result := FAcesso;
end;

function TTesteConfigModuRetag.GetEst: ITesteConfigModuRetagEst;
begin
  Result := FEst;
end;

end.
