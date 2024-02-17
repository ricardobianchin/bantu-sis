unit Sis.Lists.IntegerList_u;

interface

uses Sis.Lists.IntegerList, System.Classes, Sis.Lists.ListaList_u;

type
  TIntegerList = class(TListaList, IIntegerList)
  private
    function GetInteger(Index: integer): integer;
  public
    function Add(Valor: integer): integer;
    property Integers[Index: integer]: integer read GetInteger; default;
  end;

implementation

{ TIntegerList }

function TIntegerList.Add(Valor: integer): integer;
begin
  Result := List.Add(pointer(Valor));
end;

function TIntegerList.GetInteger(Index: integer): integer;
begin
  Result := integer(List.Items[Index]);
end;

end.
