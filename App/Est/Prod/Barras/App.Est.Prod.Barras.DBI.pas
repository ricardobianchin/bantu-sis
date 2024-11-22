unit App.Est.Prod.Barras.DBI;

interface

uses Sis.DBI;

type
  IBarrasDBI = interface(IDBI)
    ['{ADC6B912-7AF9-4D57-A87D-F6E78DC3C44B}']
    function CodBarrasToProdId(pCodBarras: string; pProdIdExceto: integer): integer;
  end;

implementation

end.
