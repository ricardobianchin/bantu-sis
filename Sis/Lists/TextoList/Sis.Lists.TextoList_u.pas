unit Sis.Lists.TextoList_u;

interface

uses Sis.Lists.TextoList, System.Classes, Sis.Lists.TextoItem;

type
  TTextoList = class(TInterfaceList, ITextoList)
  private
    function GetTextos(pTitulo: string): string;
    function GetTextoItem(Index: integer): ITextoItem;
    function GetTitulosComVirgulas: string;
  protected
  public
    property TextoItem[Index: integer]: ITextoItem read GetTextoItem; default;
    procedure PegarTextoItem(pTextoItem: ITextoItem);
    property Textos[pTitulo: string]: string read GetTextos;
    property TitulosComVirgulas: string read GetTitulosComVirgulas;
  end;

implementation

{ TTextoList }

function TTextoList.GetTextoItem(Index: integer): ITextoItem;
begin
  Result := ITextoItem(Items[Index]);
end;

function TTextoList.GetTextos(pTitulo: string): string;
var
  I: integer;
  oTextoItem: ITextoItem;
begin
  Result := '';
  for I := 0 to Count - 1 do
  begin
    oTextoItem := GetTextoItem(I);
    if oTextoItem.Titulo = pTitulo then
    begin
      Result := oTextoItem.Texto;
      break;
    end;
  end;
end;

function TTextoList.GetTitulosComVirgulas: string;
var
  I: integer;
  oTextoItem: ITextoItem;
begin
  Result := '';
  for I := 0 to Count - 1 do
  begin
    oTextoItem := GetTextoItem(I);
    if Result <> '' then
      Result := Result +', ';

    Result := Result + oTextoItem.Titulo;
  end;
end;

procedure TTextoList.PegarTextoItem(pTextoItem: ITextoItem);
begin
  Add(pTextoItem);
end;

end.
