unit Sis.Lists.IntegerList_u;

interface

uses Sis.Lists.IntegerList, System.Classes, Sis.Lists.ListaList_u;

type
  TIntegerList = class(TListaList, IIntegerList)
  private
    FAceitaRepetidos: boolean;

    function GetAceitaRepetidos: boolean;
    procedure SetAceitaRepetidos(Value: boolean);

    function GetInteger(Index: integer): integer;
  public
    function Add(Valor: integer): integer;

    function ValueToIndex(Value: integer): integer;

    property AceitaRepetidos: boolean read GetAceitaRepetidos
      write SetAceitaRepetidos;
    property Integers[Index: integer]: integer read GetInteger; default;

    constructor Create(pAceitaRepetidos: boolean = True);
  end;

implementation

{ TIntegerList }

function TIntegerList.Add(Valor: integer): integer;
var
  iExistengeIndex: integer;
begin
  if not FAceitaRepetidos then
  begin
    iExistengeIndex := ValueToIndex(Valor);
    if iExistengeIndex > -1 then
    begin
      Result := iExistengeIndex;
      exit;
    end;
  end;

  Result := List.Add(pointer(Valor));
end;

constructor TIntegerList.Create(pAceitaRepetidos: boolean);
begin
  inherited Create;
  FAceitaRepetidos := pAceitaRepetidos;
end;

function TIntegerList.GetAceitaRepetidos: boolean;
begin
  Result := FAceitaRepetidos;
end;

function TIntegerList.GetInteger(Index: integer): integer;
begin
  Result := integer(List.Items[Index]);
end;

procedure TIntegerList.SetAceitaRepetidos(Value: boolean);
begin
  FAceitaRepetidos := Value;
end;

function TIntegerList.ValueToIndex(Value: integer): integer;
var
  I: integer;
  iValue: integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    iValue := GetInteger(I);
    if Value = iValue then
    begin
      Result := I;
      break;
    end;
  end;
end;

end.
