unit Sis.Threads.Factory_u;

interface

uses Sis.Threads.SafeBool, Sis.Threads.Crit.CriticalSections;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;
function CriticalSectionsCreate: ICriticalSections;

implementation

uses Sis.Threads.SafeBool_u, Sis.Threads.Crit.CriticalSections_u;

function SafeBoolCreate(pValorInicial: Boolean = false): ISafeBool;
begin
  Result := TSafeBool.Create(pValorInicial);
end;

function CriticalSectionsCreate: ICriticalSections;
begin
  Result := TCriticalSections.Create;
end;

end.
