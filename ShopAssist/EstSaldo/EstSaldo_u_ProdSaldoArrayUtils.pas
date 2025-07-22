unit EstSaldo_u_ProdSaldoArrayUtils;

interface

uses EstSaldo_u_ProdSaldoArrayType, Sis.Types;

function ProdIdToIndex(pProdId: TId; pProdSaldoArray: TProdSaldoArray): integer;
procedure ZereQtds(pProdSaldoArray: TProdSaldoArray);
procedure ZereQtdsGravadas(pProdSaldoArray: TProdSaldoArray);

implementation

//uses EstSaldo_u_dbi;


uses EstSaldo_u_ProdSaldoRecord;
function ProdIdToIndex(pProdId: TId; pProdSaldoArray: TProdSaldoArray): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Length(pProdSaldoArray) - 1 do
  begin
    if pProdSaldoArray[i].ProdId = pProdId then
    begin
      Result := i;
      break;
    end;
  end;
end;

procedure ZereQtds(pProdSaldoArray: TProdSaldoArray);
var
  i: integer;
  rProdSaldo: TProdSaldo;
begin
  for i := 0 to Length(pProdSaldoArray) - 1 do
  begin
    rProdSaldo := pProdSaldoArray[i];
    rProdSaldo.Qtd := 0;
    rProdSaldo.QtdGravada := 0;
  end;
end;

procedure ZereQtdsGravadas(pProdSaldoArray: TProdSaldoArray);
var
  i: integer;
  rProdSaldo: TProdSaldo;
begin
  for i := 0 to Length(pProdSaldoArray) - 1 do
  begin
    rProdSaldo := pProdSaldoArray[i];
    rProdSaldo.QtdGravada := 0;
  end;
end;

end.
