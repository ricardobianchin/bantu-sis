unit EstSaldo_u_ProdSaldoRecord;

interface

uses Sis.Types;

type
  TProdSaldo = record
    ProdId: TId;
    Qtd: Currency;
    QtdGravada: Currency;
    ExisteGravada: Boolean;
    procedure Inicializar(pProdId: TId; pQtd: Currency = 0);
  end;

implementation

{ TProdSaldo }

procedure TProdSaldo.Inicializar(pProdId: TId; pQtd: Currency);
begin
  ProdId := pProdId;
  Qtd := pQtd;
  QtdGravada := 0;
  ExisteGravada := False;
end;

end.
