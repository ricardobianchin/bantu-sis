unit App.DB.DBConnectionList_u;

interface

uses App.DB.DBConnectionList, System.Classes, Sis.DB.DBTypes;

type
  TDBConnectionList = class(TInterfaceList, IDBConnectionList)
  private
    function GetDBConnection(Index: integer): IDBConnection;
  public
    property DBConnection[Index: integer]: IDBConnection read GetDBConnection;
  end;

implementation

{ TDBConnectionList }

function TDBConnectionList.GetDBConnection(Index: integer): IDBConnection;
begin
  Result := IDBConnection(Items[Index]);
end;

end.
