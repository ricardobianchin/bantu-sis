unit App.Retag.Est.Prod.Fabr.DBI;

interface

uses Sis.DBI, Data.DB;

type
  IProdFabrDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSet(var pDataSet: TDataSet; pStrBusca: string);
  end;

implementation

end.
