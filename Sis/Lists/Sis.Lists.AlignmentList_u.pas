unit Sis.Lists.AlignmentList_u;

interface

uses Sis.Lists.AlignmentList, System.Classes, Sis.Lists.ListaList_u;

type
  TAlignmentList = class(TListaList, IAlignmentList)
  private
    function GetAlignment(Index: integer): TAlignment;
  public
    function Add(Valor: TAlignment): integer;
    property Alignment[Index: integer]: TAlignment read GetAlignment; default;
  end;

implementation

{ TAlignmentList }

function TAlignmentList.Add(Valor: TAlignment): integer;
begin
  Result := List.Add(pointer(Valor));
end;

function TAlignmentList.GetAlignment(Index: integer): TAlignment;
begin
  Result := TAlignment(List.Items[Index]);
end;

end.
