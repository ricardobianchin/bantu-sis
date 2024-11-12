unit Sis.Threads.Crit.CriticalSections_u;

interface

uses Sis.Threads.Crit.CriticalSections, Sis.Threads.Crit.FixedCriticalSection_u;

type
  TCriticalSections = class(TInterfacedObject, ICriticalSections)
  private
    FDB: TFixedCriticalSection;
    FNF: TFixedCriticalSection;
    FFiles: TFixedCriticalSection;

    function GetDB: TFixedCriticalSection;
    function GetNF: TFixedCriticalSection;
    function GetFiles: TFixedCriticalSection;
  public
    property DB: TFixedCriticalSection read GetDB;
    property NF: TFixedCriticalSection read GetNF;
    property Files: TFixedCriticalSection read GetFiles;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TCriticalSections }

constructor TCriticalSections.Create;
begin
  FDB := TFixedCriticalSection.Create;
  FNF := TFixedCriticalSection.Create;
  FFiles := TFixedCriticalSection.Create;
end;

destructor TCriticalSections.Destroy;
begin
  FDB.Free;
  FNF.Free;
  FFiles.Free;
  inherited;
end;

function TCriticalSections.GetDB: TFixedCriticalSection;
begin
  Result := FDB;
end;

function TCriticalSections.GetFiles: TFixedCriticalSection;
begin
  Result := FFiles;
end;

function TCriticalSections.GetNF: TFixedCriticalSection;
begin
  Result := FNF;
end;

end.
