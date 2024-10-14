unit App.Testes.Config.ModuConf_u;

interface

uses App.Testes.Config.ModuConf //
  , App.Testes.Config.ModuConf.Ambi //
  , App.Testes.Config.ModuConf.Import //
  ; //

type
  TTesteConfigModuConf = class(TInterfacedObject, ITesteConfigModuConf)
  private
    FAmbi: ITesteConfigModuConfAmbi;
    FImport: ITesteConfigModuConfImport;

    function GetAmbi: ITesteConfigModuConfAmbi;
    function GetImport: ITesteConfigModuConfImport;
  public
    property Ambi: ITesteConfigModuConfAmbi read GetAmbi;
    property Import: ITesteConfigModuConfImport read GetImport;

    constructor Create;
  end;

implementation

uses App.Testes.Config.Factory;

{ TTesteConfigModuConf }

constructor TTesteConfigModuConf.Create;
begin
  FAmbi := ModuConfAmbiCreate;
  FImport := ModuConfImportCreate;
end;

function TTesteConfigModuConf.GetAmbi: ITesteConfigModuConfAmbi;
begin
  Result := FAmbi;
end;

function TTesteConfigModuConf.GetImport: ITesteConfigModuConfImport;
begin
  Result := FImport;
end;

end.
