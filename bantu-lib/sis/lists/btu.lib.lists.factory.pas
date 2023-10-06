unit btu.lib.lists.factory;

interface

uses btu.lib.lists.IdItem_i, btu.lib.lists.HashItem_i;

function IdItemCreate(pId: integer=0): IIdItem;
function HashItemCreate(pDescr:string=''; pId:integer=0): IHashItem;

implementation

uses btu.lib.lists.IdItem_u, btu.lib.lists.HashItem_u;

function IdItemCreate(pId: integer=0): IIdItem;
begin
   result := TIdItem.Create(pId);
end;

function HashItemCreate(pDescr:string; pId:integer): IHashItem;
begin
  result := THashItem.Create(pDescr, pId);
end;

end.
