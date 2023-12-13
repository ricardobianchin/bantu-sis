unit Sis.Lists.HashItemList_u;

interface

uses Sis.Lists.HashItemList, System.Classes, Sis.Lists.HashItem
  , Sis.Lists.IdItemList, Sis.Lists.IdItemList_u;

type
  THashItemList = class(TIdItemList, IHashItemList)
  public
    ///  melhor quando dispomos da lista
    ///  apos carregar, pode executar o inherited PreencherCods; que preencherá quem ainda estiver com codigos zerado
    function PegarHash(pDescr:string=''; pId:integer=0; pEvitaRepeditos:boolean=false):IHashItem;
    function DescrToHashItem(pDescr:string):IHashItem;
    ///  melhor usado quando nao dispomos dos codigos e vamos criar a lista
    function GarantaDescr(pDescr:string; pCreatProc:TFunctionHashItemCreateRef):IHashItem;

    function GetHashItemList(Index:integer):IHashItemList;
    property HashItemList[Index:integer]:IHashItemList read GetHashItemList;default;
  end;

implementation

{ THashItemList }

uses Sis.Lists.Factory;

function THashItemList.DescrToHashItem(pDescr: string): IHashItem;
var
  t:integer;
  h:IHashItem;
begin
  result:=nil;
  for t := 0 to count-1 do
  begin
    H:=IHashItem(IdItem[t]);
    if h.Descr=pDescr then
    begin
      result:=h;
      break;
    end;
  end;
end;

function THashItemList.GarantaDescr(pDescr: string;
  pCreatProc: TFunctionHashItemCreateRef): IHashItem;
var
  h:IHashItem;
begin
  h:=DescrToHashItem(pDescr);
  if h=nil then
  begin
    h:=pCreatProc(pDescr, MaiorId+1 );
    Add(h);
  end;
  result:=h;
end;

function THashItemList.GetHashItemList(Index: integer): IHashItemList;
begin
  result := IHashItemList(Items[index]);
end;

function THashItemList.PegarHash(pDescr: string; pId: integer; pEvitaRepeditos:boolean): IHashItem;
begin
  if pEvitaRepeditos then
  begin
    result:=DescrToHashItem(pDescr);
    if result=nil then
    begin
      result:=HashItemCreate(pDescr, pId);
      Add(result);
    end;
  end
  else
  begin
    result:=HashItemCreate(pDescr, pId);
      Add(result);
  end;

end;

end.
