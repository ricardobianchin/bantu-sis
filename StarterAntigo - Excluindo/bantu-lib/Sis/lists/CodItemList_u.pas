unit CodItemList_u;

interface

uses btu.lib.lists.CodItemList_i, classes, btu.lib.lists.CodItem_i;

type
  TCodItemList = class(TInterfaceList, ICodItemList)
  private
    function GetCodItem(Index: integer): ICodItem;
    function GetMaiorCod:integer;
  public
    function CodToCodItem(pCod:integer):ICodItem;
    property CodItem[Index:integer]:ICodItem read GetCodItem;default;
    function PegarCod(pCod:integer=0; pEvitaRepeditos:boolean=false):ICodItem;
    property MaiorCod:integer read GetMaiorCod;
    procedure PreencherCods;
  end;

implementation

{ TCodItemList }

uses I9PDV_Factory;

function TCodItemList.CodToCodItem(pCod: integer): ICodItem;
var
  t:integer;
  i:ICodItem;
begin
  result:=nil;
  for t := 0 to count-1 do
  begin
    i:=CodItem[t];
    if i.Cod=pCod then
    begin
      result:=i;
      break;
    end;
  end;
end;

function TCodItemList.GetCodItem(Index: integer): ICodItem;
begin
  Result := ICodItem(Items[Index]);
end;

function TCodItemList.GetMaiorCod: integer;
var
  t:integer;
  i:ICodItem;
begin
  result:=0;
  for t := 0 to count-1 do
  begin
    i:=CodItem[t];
    if result<i.Cod then
    begin
      result:=i.Cod;
    end;
  end;
end;

function TCodItemList.PegarCod(pCod:integer=0; pEvitaRepeditos:boolean=false): ICodItem;
begin
  if pEvitaRepeditos then
  begin
    result:=CodToCodItem(pCod);
    if result<>nil then
      result:=CodItemCreate(pCod);

  end
  else
    result:=CodItemCreate(pCod);

  Add(result);
end;

procedure TCodItemList.PreencherCods;
var
  t:integer;
  Item, ItemEncontrado:ICodItem;
  UltimoCod:integer;
begin
  UltimoCod:=0;
  for t := 0 to Count-1 do
  begin
    Item:=CodItem[t];
    if Item.Cod=0 then
    begin
      repeat
        inc(UltimoCod);
        ItemEncontrado:=CodToCodItem(UltimoCod);
      until ItemEncontrado=nil;
      Item.Cod:=UltimoCod;
    end;
  end;
end;

end.
