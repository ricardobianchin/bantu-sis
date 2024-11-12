unit Sis.Types.Arrays.ArrayUtils_u;

interface

uses
  System.SysUtils;

type
  TArrayUtils = class
    class function TemRepetido<T>(const pArray1, pArray2: TArray<T>): Boolean;
  end;

implementation

class function TArrayUtils.TemRepetido<T>(const pArray1, pArray2: TArray<T>): Boolean;
begin
  Result := False;

  for var i in pArray1 do
  begin
    for var j in pArray2 do
    begin
      if i = j then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

{
uses
  Sis.Types.Arrays.Utils_u, System.SysUtils;

var
  Arr1, Arr2: TArray<Integer>;
  HasIntersection: Boolean;
begin
  Arr1 := [1, 2, 3, 4, 5];
  Arr2 := [5, 6, 7, 8, 9];

  HasIntersection := TArrayUtils.TemRepetido<Integer>(Arr1, Arr2);

  if HasIntersection then
    Writeln('Há pelo menos um item comum em ambos os arrays.')
  else
    Writeln('Não há itens comuns em ambos os arrays.');
end.

}

end.

