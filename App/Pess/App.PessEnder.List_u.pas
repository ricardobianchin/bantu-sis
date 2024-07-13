unit App.PessEnder.List_u;

interface

uses App.PessEnder.List, App.PessEnder, System.Classes;

type
  TPessEnderList = class(TInterfaceList, IPessEnderList)
  private
    function GetPessEnder(Index: integer): IPessEnder;
  public
    property PessEnder[Index: integer]: IPessEnder read GetPessEnder; default;
  end;

implementation

{ TPessEnderList }

function TPessEnderList.GetPessEnder(Index: integer): IPessEnder;
begin
  Result := IPessEnder(Items[Index]);
end;

end.
