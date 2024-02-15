unit App.UI.Decorator.Form.Excl.Fabr_u;

interface

uses App.UI.Decorator.Form.Excl_u, App.Retag.Est.Prod.Fabr;

type
  TDecoratorExclFabr = class(TDecoratorExcl)
  private
    FProdFabr: IProdFabr;
  public
    function GetValues: string; override;
    function GetNome: string; override;
    constructor Create(pProdFabr: IProdFabr);
  end;

implementation

{ TDecoratorExclFabr }

constructor TDecoratorExclFabr.Create(pProdFabr: IProdFabr);
begin
  inherited Create;
  FProdFabr := pProdFabr;
end;

function TDecoratorExclFabr.GetNome: string;
begin
  Result := 'Fabricante';
end;

function TDecoratorExclFabr.GetValues: string;
begin
  Result := FProdFabr.AsString;
end;

end.
