unit App.Testes.Config.ModuConf.Ambi_u;

interface

uses App.Testes.Config.ModuConf.Ambi, //
     App.Testes.Config.ModuConf.Ambi.Loja //
     ; //

type
  TTesteConfigModuConfAmbi = class(TInterfacedObject, ITesteConfigModuConfAmbi)
  private
    FLoja: ITesteConfigModuConfAmbiLoja;
    function GetLoja: ITesteConfigModuConfAmbiLoja;
  public
    property Loja: ITesteConfigModuConfAmbiLoja read GetLoja;
    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuConfAmbi }

constructor TTesteConfigModuConfAmbi.Create;
begin
  FLoja := ModuConfAmbiLojaCreate;
end;

function TTesteConfigModuConfAmbi.GetLoja: ITesteConfigModuConfAmbiLoja;
begin
  Result := FLoja;
end;

end.
