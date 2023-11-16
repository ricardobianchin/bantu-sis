unit Sis.Config.SisConfig;

interface

uses Sis.Config.MachineId, sis.win.VersionInfo, Sis.DB.DBTypes;

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
