unit Sis.DBI_u;

interface

uses Sis.DBI, Sis.DB.DBTypes;

type
  TDBI = class(TInterfacedObject, IDBI)
  private
    FDBConnection: IDBConnection;
  public
    constructor Create(pDBConnection: IDBConnection);
    property DBConnection: IDBConnection read FDBConnection;
  end;

implementation

{ TDBI }

constructor TDBI.Create(pDBConnection: IDBConnection);
begin
  FDBConnection := pDBConnection;
end;

end.
