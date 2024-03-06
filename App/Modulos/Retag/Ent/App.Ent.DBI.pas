unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes, System.Classes;

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
    function GetPackageName: string;
    property PackageName: string read GetPackageName;

    function ById(pId: variant; out pValores: variant): boolean;
    procedure ListaSelectGet(pSL: TStrings; pDBConnection: IDBConnection = nil);
    function AtivoSet(const pId: integer; Value: boolean): boolean;
  end;

implementation

end.
