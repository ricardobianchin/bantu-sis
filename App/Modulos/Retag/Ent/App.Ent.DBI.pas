unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes;

type
  IEntDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSetIdDescr(pStrBusca: string; pLeReg: TProcDataSetRef);
    function IdByDescr(pDescr: string): integer;
    function GarantirRegId: boolean;
  end;

implementation

end.
