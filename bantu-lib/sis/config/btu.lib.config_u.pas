unit btu.lib.config_u;

interface

uses btu.lib.config.machineid, btu.lib.config, btu.lib.win.VersionInfo;

type
  TISisConfig = class(TInterfacedObject, ISisConfig)
  private
    FLocalMachineId: IMachineId;
    FLocalMachineIsServer: boolean;
    FServerMachineId: IMachineId;
    FWinVersionInfo: IWinVersionInfo;

    function GetLocalMachineId: IMachineId;

    function GetLocalMachineIsServer: boolean;
    procedure SetLocalMachineIsServer(const Value: boolean);

    function GetServerMachineId: IMachineId;

    function GetWinVersionInfo: IWinVersionInfo;
  public
    property LocalMachineId: IMachineId read GetLocalMachineId;
    property LocalMachineIsServer: boolean read GetLocalMachineIsServer write SetLocalMachineIsServer;
    property ServerMachineId: IMachineId read GetServerMachineId;

    property WinVersionInfo: IWinVersionInfo read GetWinVersionInfo;


    constructor Create( pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo);
  end;

implementation

{ TISisConfig }

constructor TISisConfig.Create(pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo);
begin
  FLocalMachineId := pLocalMachineId;
  FLocalMachineIsServer := false;
  FServerMachineId := pServerMachineId;
  FWinVersionInfo := pWinVersionInfo;
end;

function TISisConfig.GetLocalMachineId: IMachineId;
begin
  result := FLocalMachineId;
end;

function TISisConfig.GetLocalMachineIsServer: boolean;
begin
  result := FLocalMachineIsServer;
end;

function TISisConfig.GetServerMachineId: IMachineId;
begin
  result := FServerMachineId;
end;

function TISisConfig.GetWinVersionInfo: IWinVersionInfo;
begin
  result := FWinVersionInfo;
end;

procedure TISisConfig.SetLocalMachineIsServer(const Value: boolean);
begin
  FLocalMachineIsServer := Value;
end;

end.
