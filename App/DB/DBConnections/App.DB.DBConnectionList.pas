unit App.DB.DBConnectionList;

interface

uses System.Classes, Sis.DB.DBTypes;

type
  IDBConnectionList = interface(IInterfaceList)
    ['{17508D93-8271-477B-93AD-512AFF95ECB6}']
    function GetDBConnection(Index: integer): IDBConnection;
    property DBConnection[Index: integer]: IDBConnection read GetDBConnection;
  end;

implementation

end.
