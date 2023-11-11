unit btu.lib.types.classes.utils;

interface

function ClassIsDescendent(pClassNameFilha, pClassNameMae: string): boolean;

implementation

uses System.Classes;

function ClassIsDescendent(pClassNameFilha, pClassNameMae: string): boolean;
var
  ClassMae, ClassFilha: TClass;
begin
  ClassMae := GetClass(pClassNameMae);
  result := assigned(ClassMae);
  if not result then
    exit;

  ClassFilha := GetClass(pClassNameFilha);
  result := assigned(ClassFilha);
  if not result then
    exit;

  result := ClassFilha.InheritsFrom(ClassMae);
end;

end.
