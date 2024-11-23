unit Sis.Lists.IdItemList;

interface

uses System.Classes, Sis.Lists.IdItem;

type
  IIdItemList = interface(IInterfaceList)
    function GetMaiorId: integer;
    function IdToIdItem(pId: integer): IIdItem;
    function PegarId(pId: integer = 0;
      pEvitaRepeditos: boolean = false): IIdItem;
    property MaiorId: integer read GetMaiorId;
    procedure PreencherIds;

    function GetIdItem(Index: integer): IIdItem;
    property IdItem[Index: integer]: IIdItem read GetIdItem; default;
  end;

implementation

end.
