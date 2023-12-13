unit Sis.Lists.IdItemList;

interface

uses System.Classes, Sis.Lists.IdItem;

type
  IIdItemList = interface(IInterfaceList)
    function GetIdItem(Index: integer): IIdItem;
    function GetMaiorId:integer;
    function IdToIdItem(pId:integer):IIdItem;
    property IdItem[Index:integer]:IIdItem read GetIdItem;default;
    function PegarId(pId:integer=0; pEvitaRepeditos:boolean=false):IIdItem;
    property MaiorId:integer read GetMaiorId;
    procedure PreencherIds;
  end;

implementation

end.
