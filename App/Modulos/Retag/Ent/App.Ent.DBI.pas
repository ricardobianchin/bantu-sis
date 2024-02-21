unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes;

type
  IEntDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSet(pValues: variant; pProcLeReg: TProcDataSetOfObject);
    function GetExistente(pValues: variant): variant;
    function GarantirReg: boolean;
  end;

implementation

end.
