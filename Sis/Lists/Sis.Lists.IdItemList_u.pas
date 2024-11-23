unit Sis.Lists.IdItemList_u;

interface

uses Sis.Lists.IdItem, System.Classes, Sis.Lists.IdItemList;

type
  TIdItemList = class(TInterfaceList, IIdItemList)
  private
    function GetIdItem(Index: integer): IIdItem;
    function GetMaiorId: integer;
  public
    function PegarId(pId: integer = 0;
      pEvitaRepeditos: boolean = false): IIdItem;
    property MaiorId: integer read GetMaiorId;
    procedure PreencherIds;

    function IdToIdItem(pId: integer): IIdItem;
    property IdItem[Index: integer]: IIdItem read GetIdItem; default;
  end;

implementation

{ TIdItemList }

uses Sis.Lists.Factory;

function TIdItemList.IdToIdItem(pId: integer): IIdItem;
var
  t: integer;
  i: IIdItem;
begin
  result := nil;
  for t := 0 to count - 1 do
  begin
    i := IdItem[t];
    if i.Id = pId then
    begin
      result := i;
      break;
    end;
  end;
end;

function TIdItemList.GetIdItem(Index: integer): IIdItem;
begin
  result := IIdItem(Items[Index]);
end;

function TIdItemList.GetMaiorId: integer;
var
  t: integer;
  i: IIdItem;
begin
  result := 0;
  for t := 0 to count - 1 do
  begin
    i := IdItem[t];
    if result < i.Id then
    begin
      result := i.Id;
    end;
  end;
end;

function TIdItemList.PegarId(pId: integer = 0;
  pEvitaRepeditos: boolean = false): IIdItem;
begin
  if pEvitaRepeditos then
  begin
    result := IdToIdItem(pId);
    if result <> nil then
      result := IdItemCreate(pId);

  end
  else
    result := IdItemCreate(pId);

  Add(result);
end;

procedure TIdItemList.PreencherIds;
var
  t: integer;
  Item, ItemEncontrado: IIdItem;
  UltimoId: integer;
begin
  UltimoId := 0;
  for t := 0 to count - 1 do
  begin
    Item := IdItem[t];
    if Item.Id = 0 then
    begin
      repeat
        inc(UltimoId);
        ItemEncontrado := IdToIdItem(UltimoId);
      until ItemEncontrado = nil;
      Item.Id := UltimoId;
    end;
  end;
end;

end.
