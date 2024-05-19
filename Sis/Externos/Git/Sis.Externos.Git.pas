unit Sis.Externos.Git;

interface

type
  IGit = interface(IInterface)
    ['{2F39146A-60A6-4393-B54A-57A66117ED55}']

    function GetDescribe: string;
    property Describe: string read GetDescribe;
  end;

implementation

end.
