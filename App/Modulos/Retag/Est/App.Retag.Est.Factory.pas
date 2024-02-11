unit App.Retag.Est.Factory;

interface

uses App.Retag.Est.Prod.Fabr;

function RetagEstProdFabrCreate: IProdFabr;

implementation

uses App.Retag.Est.Prod.Fabr_u;

function RetagEstProdFabrCreate: IProdFabr;
begin
  Result := TProdFabr.Create;
end;

end.
