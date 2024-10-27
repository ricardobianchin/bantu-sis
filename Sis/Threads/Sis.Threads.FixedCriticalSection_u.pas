unit Sis.Threads.FixedCriticalSection_u;

interface

uses System.SyncObjs;

type
  TFixedCriticalSection = class(TCriticalSection)
  private
    {$HINTS OFF}
    FDummy : array [0..95] of Byte;
    {$HINTS ON}
  public

  end;

implementation

end.
