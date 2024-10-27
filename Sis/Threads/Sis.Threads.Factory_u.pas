unit Sis.Threads.Factory_u;

interface

uses Sis.Threads.SafeBool;

function SafeBoolCreate: ISafeBool;

implementation

uses Sis.Threads.SafeBool_u;

function SafeBoolCreate: ISafeBool;
begin
  Result := TSafeBool.Create;
end;

end.
