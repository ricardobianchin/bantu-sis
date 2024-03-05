unit Sis.DBI;

interface

uses Sis.DB.DBTypes;

type
  IDBI = interface(IInterface)
    ['{3DF3FC1F-5402-416A-94D5-D56DAE945182}']
    function GetDBConnection: IDBConnection;
    property DBConnection: IDBConnection read GetDBConnection;
  end;

implementation

end.
