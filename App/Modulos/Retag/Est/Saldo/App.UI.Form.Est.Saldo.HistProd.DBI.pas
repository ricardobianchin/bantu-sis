unit App.UI.Form.Est.Saldo.HistProd.DBI;

interface

uses Sis.DBI;

type
  IEstSaldoHistProdFormDBI = interface(IDBI)
    ['{124E6394-5D7A-4F81-916A-32A5E48754F9}']
    function GetSqlForEach(pValues: variant): string;
    function GetNomeArqTabView(pValues: variant): string;
  end;

implementation

end.
