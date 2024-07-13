unit App.Testes.Config.ModuConf_u;

interface

uses App.Testes.Config.ModuConf, App.Testes.Config.ModuConf.Ambi;

type
  TTesteConfigModuConf = class(TInterfacedObject, ITesteConfigModuConf)
  private
    FAmbi: ITesteConfigModuConfAmbi;

    function GetAmbi: ITesteConfigModuConfAmbi;
  public
    property Ambi: ITesteConfigModuConfAmbi read GetAmbi;

    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuConf }

constructor TTesteConfigModuConf.Create;
begin
  FAmbi := ModuConfAmbiCreate;
end;

function TTesteConfigModuConf.GetAmbi: ITesteConfigModuConfAmbi;
begin
  Result := FAmbi;
end;

end.
