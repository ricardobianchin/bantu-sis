unit App.AppObj.CriticalSections_u;

interface

uses Sis.Threads.FixedCriticalSection_u;

type
  TCriticalSections = record
    ServerDB: TFixedCriticalSection;
    procedure Inicialize;
    procedure Libere;
  end;

implementation

{ TCriticalSections }

procedure TCriticalSections.Inicialize;
begin
  ServerDB := TFixedCriticalSection.Create;
end;

procedure TCriticalSections.Libere;
begin
  ServerDB.Free;
end;

end.
