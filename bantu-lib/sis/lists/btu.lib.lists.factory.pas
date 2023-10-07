unit btu.lib.lists.factory;

interface

uses btu.lib.lists.IdItem_i, btu.lib.lists.HashItem_i, btu.lib.lists.TextoItem,
  btu.lib.lists.TextoList;

{$REGION 'Id List'}
  function IdItemCreate(pId: integer=0): IIdItem;
  function HashItemCreate(pDescr:string=''; pId:integer=0): IHashItem;
{$ENDREGION}

{$REGION 'TextoList'}
  function TextoItemCreate(pTitulo: string = ''; pTexto: string = ''): ITextoItem;
  function TextoListCreate: ITextoList;
{$ENDREGION}

implementation

uses btu.lib.lists.IdItem_u, btu.lib.lists.HashItem_u,
  btu.lib.lists.TextoItem_u, btu.lib.lists.TextoList_u;

{$REGION 'Id List implementation'}
  function IdItemCreate(pId: integer=0): IIdItem;
  begin
     result := TIdItem.Create(pId);
  end;

  function HashItemCreate(pDescr:string; pId:integer): IHashItem;
  begin
    result := THashItem.Create(pDescr, pId);
  end;
{$ENDREGION}

{$REGION 'TextoList implementation'}
function TextoItemCreate(pTitulo: string = ''; pTexto: string = ''): ITextoItem;
begin
  Result := TTextoItem.Create(pTitulo, pTexto);
end;

function TextoListCreate: ITextoList;
begin
  Result := TTextoList.Create;
end;
{$ENDREGION}

end.
