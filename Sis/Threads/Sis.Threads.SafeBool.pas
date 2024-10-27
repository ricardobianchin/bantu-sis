unit Sis.Threads.SafeBool;

interface

type
  ISafeBool = interface(IInterface)
    ['{FA60C24F-C789-43FC-BD66-9F8DD0014EA2}']
    function GetAsBoolean: Boolean;
    procedure SetAsBolean(Value: Boolean);
    property AsBoolean: Boolean read GetAsBoolean write SetAsBolean;
  end;

implementation

end.
