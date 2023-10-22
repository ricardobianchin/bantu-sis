unit btu.lib.config;

interface

uses btu.lib.config.machineid, sis.win.VersionInfo, btu.lib.db.types;

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

    function GetDBMSInfo: IDBMSInfo;
    property DBMSInfo: IDBMSInfo read GetDBMSInfo;

    function GetPastaProduto: string;
    property PastaProduto: string read GetPastaProduto;

  end;

implementation

end.
