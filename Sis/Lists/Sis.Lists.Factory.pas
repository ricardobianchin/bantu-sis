unit Sis.Lists.Factory;

interface

uses Sis.Lists.IdItem, Sis.Lists.HashItem, Sis.Lists.TextoItem,
  Sis.Lists.TextoList;

{$REGION 'Id List'}
function IdItemCreate(pId: integer = 0): IIdItem;
function HashItemCreate(pDescr: string = ''; pId: integer = 0): IHashItem;
{$ENDREGION}
{$REGION 'TextoList'}
function TextoItemCreate(pTitulo: string = ''; pTexto: string = ''): ITextoItem;
function TextoListCreate: ITextoList;
{$ENDREGION}

implementation

uses Sis.Lists.IdItem_u, Sis.Lists.HashItem_u, Sis.Lists.TextoItem_u,
  Sis.Lists.TextoList_u;

{$REGION 'Id List implementation'}
function IdItemCreate(pId: integer = 0): IIdItem;
begin
  result := TIdItem.Create(pId);
end;

function HashItemCreate(pDescr: string; pId: integer): IHashItem;
begin
  result := THashItem.Create(pDescr, pId);
end;
{$ENDREGION}

{$REGION 'TextoList implementation'}
function TextoItemCreate(pTitulo: string = ''; pTexto: string = ''): ITextoItem;
begin
  result := TTextoItem.Create(pTitulo, pTexto);
end;

function TextoListCreate: ITextoList;
begin
  result := TTextoList.Create;
end;
{$ENDREGION}

end.
