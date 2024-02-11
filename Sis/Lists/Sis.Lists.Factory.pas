unit Sis.Lists.Factory;

interface

uses Sis.Lists.IdItem, Sis.Lists.HashItem, Sis.Lists.TextoItem,
  Sis.Lists.TextoList, Sis.Lists.AlignmentList, Sis.Lists.IntegerList;

{$REGION 'Id List'}
function IdItemCreate(pId: integer = 0): IIdItem;
function HashItemCreate(pDescr: string = ''; pId: integer = 0): IHashItem;
{$ENDREGION}
{$REGION 'Types List'}
function AlignmentListCreate: IAlignmentList;
function IntegerListCreate: IIntegerList;
{$ENDREGION}
{$REGION 'TextoList'}
function TextoItemCreate(pTitulo: string = ''; pTexto: string = ''): ITextoItem;
function TextoListCreate: ITextoList;
{$ENDREGION}

implementation

uses Sis.Lists.IdItem_u, Sis.Lists.HashItem_u, Sis.Lists.TextoItem_u,
  Sis.Lists.TextoList_u, Sis.Lists.AlignmentList_u, Sis.Lists.IntegerList_u;

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
{$REGION 'Types List'}
function AlignmentListCreate: IAlignmentList;
begin
  Result := TAlignmentList.Create;
end;
function IntegerListCreate: IIntegerList;
begin
  Result := TIntegerList.Create;
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
