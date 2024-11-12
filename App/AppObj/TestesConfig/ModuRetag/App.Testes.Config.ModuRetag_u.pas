unit App.Testes.Config.ModuRetag_u;

interface

uses
  App.Testes.Config.ModuRetag //
  , App.Testes.Config.ModuRetag.Acesso //
  , App.Testes.Config.ModuRetag.Est //
  , App.Testes.Config.ModuRetag.Fin //
  , App.Testes.Config.ModuRetag.Ajuda //
  ;

type
  TTesteConfigModuRetag = class(TInterfacedObject, ITesteConfigModuRetag)
  private
    FAcesso: ITesteConfigModuRetagAcesso;
    FEst: ITesteConfigModuRetagEst;
    FFin: ITesteConfigModuRetagFin;
    FAjuda: ITesteConfigModuRetagAjuda;

    function GetAcesso: ITesteConfigModuRetagAcesso;
    function GetEst: ITesteConfigModuRetagEst;
    function GetFin: ITesteConfigModuRetagFin;
    function GetAjuda: ITesteConfigModuRetagAjuda;
  public
    property Acesso: ITesteConfigModuRetagAcesso read GetAcesso;
    property Est: ITesteConfigModuRetagEst read GetEst;
    property Fin: ITesteConfigModuRetagFin read GetFin;
    property Ajuda: ITesteConfigModuRetagAjuda read GetAjuda;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuRetag }

constructor TTesteConfigModuRetag.Create;
begin
  FAcesso := ModuRetagAcessoCreate;
  FEst := ModuRetagEstCreate;
  FFin := ModuRetagFinCreate;
  FAjuda := ModuRetagAjudaCreate;
end;

function TTesteConfigModuRetag.GetAcesso: ITesteConfigModuRetagAcesso;
begin
  Result := FAcesso;
end;

function TTesteConfigModuRetag.GetAjuda: ITesteConfigModuRetagAjuda;
begin
  Result := FAjuda;
end;

function TTesteConfigModuRetag.GetEst: ITesteConfigModuRetagEst;
begin
  Result := FEst;
end;

function TTesteConfigModuRetag.GetFin: ITesteConfigModuRetagFin;
begin
  Result := FFin;
end;

end.
