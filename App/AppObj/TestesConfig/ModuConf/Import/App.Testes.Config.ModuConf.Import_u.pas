unit App.Testes.Config.ModuConf.Import_u;

interface

uses App.Testes.Config.ModuConf.Import;

type
  TTesteConfigModuConfImport = class(TInterfacedObject, ITesteConfigModuConfImport)
  private
    FAutoExec: boolean;
    FOrigem: string;

    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);

    function GetOrigem: string;
    procedure SetOrigem(Value: string);
  public
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
    property Origem: string read GetOrigem write SetOrigem;
    constructor Create;
  end;

implementation

{ TTesteConfigModuConfImport }

constructor TTesteConfigModuConfImport.Create;
begin
  FOrigem := 'PLUBASE';
end;

function TTesteConfigModuConfImport.GetAutoExec: boolean;
begin
  Result := FAutoExec;
end;

function TTesteConfigModuConfImport.GetOrigem: string;
begin
  Result := FOrigem;
end;

procedure TTesteConfigModuConfImport.SetAutoExec(Value: boolean);
begin
  FAutoExec := Value;
end;

procedure TTesteConfigModuConfImport.SetOrigem(Value: string);
begin
  FOrigem := Value;
end;

end.
