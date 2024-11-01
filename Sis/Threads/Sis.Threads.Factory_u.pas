unit Sis.Threads.Factory_u;

interface

uses Sis.Threads.SafeBool;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;

implementation

uses Sis.Threads.SafeBool_u;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;
begin
  Result := TSafeBool.Create(pValorInicial);
end;

end.
