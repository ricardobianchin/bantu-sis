unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes;

type
  IEntDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']
    procedure PreencherDataSet(pValues: variant;
      pProcLeReg: TProcDataSetOfObject);
    function GetExistente(pValues: variant; out pRetorno: string): variant;
    function GarantirReg: boolean;

    //recebe uma id ou array de loja term id
    //retorna array com os valores do reg
    //retorna true se o id existia
    function ById(pId: variant; out pValores: variant): boolean;
  end;

implementation

end.
