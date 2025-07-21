unit EstSaldo_u_ProdSaldoRecord;

interface

uses Sis.Types;

type
  TProdSaldo = record
    ProdId: TId;
    Qtd: Currency;
    procedure Inicializar(pProdId: TId; pQtd: Currency = 0);
  end;

implementation

{ TProdSaldo }

procedure TProdSaldo.Inicializar(pProdId: TId; pQtd: Currency);
begin
  ProdId := pProdId;
  Qtd := pQtd;
end;

end.
