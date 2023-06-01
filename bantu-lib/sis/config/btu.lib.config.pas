unit btu.lib.config;

interface

uses btu.lib.config.machineid, btu.lib.win.VersionInfo;

type
  ISisConfig = interface(IInterface)
    ['{B12F1478-8D0D-4124-9147-44B8773881B2}']
    function GetLocalMachineId: IMachineId;
    property LocalMachineId: IMachineId read GetLocalMachineId;

    function GetLocalMachineIsServer: boolean;
    procedure SetLocalMachineIsServer(const Value: boolean);
    property LocalMachineIsServer: boolean read GetLocalMachineIsServer write SetLocalMachineIsServer;

    function GetServerMachineId: IMachineId;
    property ServerMachineId: IMachineId read GetServerMachineId;

    function GetWinVersionInfo: IWinVersionInfo;
    property WinVersionInfo: IWinVersionInfo read GetWinVersionInfo;
  end;

implementation

end.
