unit Sis.DBI;

interface

uses Sis.DB.DBTypes;

type
  IDBI = interface(IInterface)
    ['{3DF3FC1F-5402-416A-94D5-D56DAE945182}']
    function GetDBConnection: IDBConnection;
    property DBConnection: IDBConnection read GetDBConnection;
    function ExecuteSQL(pComandoSQL: string; out pMens: string): boolean;

    function GetValue(pConsultaSQL: string; out pMens: string): variant;
    function GetValueInteger(pConsultaSQL: string; out pMens: string): integer;

    procedure PreencherDataSet(pValues: variant;
      pProcLeReg: TProcDataSetOfObject);

    function GetNomeArqTabView(pValues: variant): string;
  end;

implementation

end.
