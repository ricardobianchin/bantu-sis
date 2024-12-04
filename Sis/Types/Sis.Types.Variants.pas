unit Sis.Types.Variants;

interface

function VarToVarArray(const Value: Variant): Variant;
function ValuesToVarArray(const Values: array of Variant): Variant;
function VarArrayVazia(const Value: Variant): Boolean;

implementation

uses System.Variants;

function VarToVarArray(const Value: Variant): Variant;
begin
  Result := VarArrayCreate([0, 0], varVariant);
  Result[0] := Value;
end;

function ValuesToVarArray(const Values: array of Variant): Variant;
var
  i: Integer;
begin
  Result := VarArrayCreate([0, High(Values)], varVariant);
  for i := Low(Values) to High(Values) do
  begin
    Result[i] := Values[i];
  end;
end;

function VarArrayVazia(const Value: Variant): Boolean;
var
  iMaisBaixo: integer;
  iMaisAlto: integer;
begin
  Result := not VarIsArray(Value);
  if Result then
    exit;

  iMaisBaixo := VarArrayLowBound(Value, 1);
  iMaisAlto := VarArrayHighBound(Value, 1);

  Result := iMaisBaixo > iMaisAlto;
end;

end.
