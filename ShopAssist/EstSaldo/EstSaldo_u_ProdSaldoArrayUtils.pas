unit EstSaldo_u_ProdSaldoArrayUtils;

interface

uses EstSaldo_u_ProdSaldoArrayType, Sis.Types;

function ProdIdToIndex(pProdId: TId; pProdSaldoArray: TProdSaldoArray): integer;
procedure ZereQtds(pProdSaldoArray: TProdSaldoArray);

implementation

//uses EstSaldo_u_dbi;

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
begin
  for i := 0 to Length(pProdSaldoArray) - 1 do
  begin
    pProdSaldoArray[i].Qtd := 0;
  end;
end;

end.
