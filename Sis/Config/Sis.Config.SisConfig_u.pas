unit Sis.Config.SisConfig_u;

interface

uses Sis.Config.MachineId, Sis.Config.SisConfig, Sis.Win.VersionInfo,
  Sis.DB.DBTypes;

type
  TISisConfig = class(TInterfacedObject, ISisConfig)
  private
    FLocalMachineId: IMachineId;
    FLocalMachineIsServer: boolean;
    FServerMachineId: IMachineId;
    FWinVersionInfo: IWinVersionInfo;
    FDBMSInfo: IDBMSInfo;
    FPastaProduto: string;

    function GetLocalMachineId: IMachineId;

    function GetLocalMachineIsServer: boolean;
    procedure SetLocalMachineIsServer(const Value: boolean);

    function GetServerMachineId: IMachineId;

    function GetWinVersionInfo: IWinVersionInfo;

    function GetDBMSInfo: IDBMSInfo;

    function GetPastaProduto: string;
  public
    property LocalMachineId: IMachineId read GetLocalMachineId;
    property LocalMachineIsServer: boolean read GetLocalMachineIsServer write SetLocalMachineIsServer;
    property ServerMachineId: IMachineId read GetServerMachineId;
    property WinVersionInfo: IWinVersionInfo read GetWinVersionInfo;
    property DBMSInfo: IDBMSInfo read GetDBMSInfo;
    property PastaProduto: string read GetPastaProduto;

    constructor Create( pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo; pDBMSInfo: IDBMSInfo);
  end;

implementation

{ TISisConfig }

uses Sis.UI.IO.Files;

constructor TISisConfig.Create(pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo; pDBMSInfo: IDBMSInfo);
begin
  FLocalMachineId := pLocalMachineId;
  FLocalMachineIsServer := false;
  FServerMachineId := pServerMachineId;
  FWinVersionInfo := pWinVersionInfo;
  FDBMSInfo := pDBMSInfo;
  FPastaProduto := PastaAcima(PastaAtual);
end;

function TISisConfig.GetDBMSInfo: IDBMSInfo;
begin
  result := FDBMSInfo;
end;

function TISisConfig.GetLocalMachineId: IMachineId;
begin
  result := FLocalMachineId;
end;

function TISisConfig.GetLocalMachineIsServer: boolean;
begin
  result := FLocalMachineIsServer;
end;

function TISisConfig.GetPastaProduto: string;
begin
  result := FPastaProduto;
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
