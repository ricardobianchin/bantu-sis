unit Sis.DBI_u;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  TDBI = class(TInterfacedObject, IDBI)
  private
    FDBConnection: IDBConnection;
    function GetDBConnection: IDBConnection;
  public
    constructor Create(pDBConnection: IDBConnection);
    property DBConnection: IDBConnection read GetDBConnection;
  end;

implementation

{ TDBI }

constructor TDBI.Create(pDBConnection: IDBConnection);
begin
  FDBConnection := pDBConnection;
end;

function TDBI.GetDBConnection: IDBConnection;
begin
  Result := FDBConnection;
end;

end.
