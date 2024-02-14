unit App.Retag.Est.Prod.Fabr.DBI;

interface

uses Sis.DBI, Data.DB;

type
  TProcDataSetRef = reference to procedure(q: TDataSet);
  IProdFabrDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSet(pStrBusca: string; pLeReg: TProcDataSetRef);
    function ByNome(pNome: string): integer;
    function Garantir: boolean;
  end;

implementation

end.
