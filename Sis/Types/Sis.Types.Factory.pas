unit Sis.Types.Factory;

interface

uses Sis.Types.strings.Stack, Sis.Types.Contador;

function StrStackCreate: IStrStack;
function ContadorCreate: IContador;

implementation

uses Sis.Types.strings.Stack_u, Sis.Types.Contador_u;

function StrStackCreate: IStrStack;
begin
  Result := TStrStack.Create;
end;

function ContadorCreate: IContador;
begin
  Result := TContador.Create;
end;

end.
