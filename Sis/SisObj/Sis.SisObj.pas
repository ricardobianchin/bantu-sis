unit Sis.SisObj;

interface

uses Sis.Types.Bool;

type
  ISisObj = interface(IInterface)
    ['{89214D82-BBC7-478A-B182-41ED49C115DB}']
    function GetBool: ISisBool;
    property Bool: ISisBool read GetBool;
  end;

implementation

end.
