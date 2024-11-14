unit Sis.Types.Variants;

interface

function VarToVarArray(const Value: Variant): Variant;

implementation

uses System.Variants;

function VarToVarArray(const Value: Variant): Variant;
begin
  Result := VarArrayCreate([0, 0], varVariant);
  Result[0] := Value;
end;

end.
