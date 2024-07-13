unit App.Testes.Config.App;

interface

type
  ITesteConfigApp = interface(IInterface)
    ['{989B7672-E12A-44AE-B89B-2FBC90DEFC4B}']
    function GetExecsAtu: boolean;
    procedure SetExecsAtu(Value: boolean);
    property ExecsAtu: boolean read GetExecsAtu write SetExecsAtu;
  end;

implementation

end.
