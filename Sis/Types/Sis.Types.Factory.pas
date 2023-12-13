unit Sis.Types.Factory;

interface

uses Sis.Types.strings.Stack;

function StrStackCreate: IStrStack;

implementation

uses Sis.Types.strings.Stack_u;

function StrStackCreate: IStrStack;
begin
  Result := TStrStack.Create;
end;

end.
