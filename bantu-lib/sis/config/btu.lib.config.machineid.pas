unit btu.lib.config.machineid;

interface

type
  IMachineId = interface(IInterface)
    ['{EDAB2A13-A361-4539-ABAD-E7D254D3AA96}']
    procedure SetName(const Value: string);
    function GetName: string;
    property Name: string read GetName write SetName;

    procedure SetIP(const Value: string);
    function GetIP: string;
    property IP: string read GetIP write SetIP;

    procedure Zerar;

    function GetIsDataOk: boolean;
    property IsDataOk: boolean read GetIsDataOk;

    function GetServerName: string;
  end;

implementation

end.
