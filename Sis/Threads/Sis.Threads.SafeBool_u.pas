unit Sis.Threads.SafeBool_u;

interface

uses Sis.Threads.FixedCriticalSection_u,
  Sis.Threads.SafeBool;

type
  TSafeBool = class(TInterfacedObject, ISafeBool)
  private
    FFixedCriticalSection: TFixedCriticalSection;
    FAsBoolean: Boolean;

    function GetAsBoolean: Boolean;
    procedure SetAsBolean(Value: Boolean);
  public
    property AsBoolean: Boolean read GetAsBoolean write SetAsBolean;
    destructor Destroy; override;
    constructor Create(pValorInicial: Boolean = false);
  end;

implementation

{ TSafeBool }

constructor TSafeBool.Create(pValorInicial: Boolean);
begin
  FFixedCriticalSection := TFixedCriticalSection.Create;
  FAsBoolean := pValorInicial;
end;

destructor TSafeBool.Destroy;
begin
  FFixedCriticalSection.Free;
  inherited;
end;

function TSafeBool.GetAsBoolean: Boolean;
begin
  FFixedCriticalSection.Acquire;
  try
    result := FAsBoolean;
  finally
    FFixedCriticalSection.Release;
  end;
end;

procedure TSafeBool.SetAsBolean(Value: Boolean);
begin
  FFixedCriticalSection.Acquire;
  try
    FAsBoolean := Value;
  finally
    FFixedCriticalSection.Release;
  end;
end;

end.
