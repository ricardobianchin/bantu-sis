unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes, Sis.UI.Frame.Bas.FiltroParams_u;

type
  IEntDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSet(pFiltroParamsFrame: TFiltroParamsFrame; pProcLeReg: TProcDataSetOfObject);
    function IdByDescr(pDescr: string): integer;
    function GarantirRegId: boolean;
  end;

implementation

end.
