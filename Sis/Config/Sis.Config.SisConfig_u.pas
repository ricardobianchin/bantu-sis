unit Sis.Config.SisConfig_u;

interface

uses Sis.Config.MachineId, Sis.Config.SisConfig, Sis.Win.VersionInfo,
  Sis.DB.DBTypes;

type
  TSisConfig = class(TInterfacedObject, ISisConfig)
  private
    FLocalMachineId: IMachineId;
    FLocalMachineIsServer: boolean;
    FServerMachineId: IMachineId;
    FWinVersionInfo: IWinVersionInfo;
    FDBMSInfo: IDBMSInfo;
    FPastaProduto: string;
    FServerLetraDoDrive: char;

    function GetLocalMachineId: IMachineId;

    function GetLocalMachineIsServer: boolean;
    procedure SetLocalMachineIsServer(const Value: boolean);

    function GetServerMachineId: IMachineId;

    function GetWinVersionInfo: IWinVersionInfo;

    function GetDBMSInfo: IDBMSInfo;

    function GetPastaProduto: string;

    function GetServerLetraDoDrive: char;
    procedure SetServerLetraDoDrive(Value: char);
  public
    property LocalMachineId: IMachineId read GetLocalMachineId;
    property LocalMachineIsServer: boolean read GetLocalMachineIsServer write SetLocalMachineIsServer;
    property ServerMachineId: IMachineId read GetServerMachineId;
    property WinVersionInfo: IWinVersionInfo read GetWinVersionInfo;
    property DBMSInfo: IDBMSInfo read GetDBMSInfo;
    property PastaProduto: string read GetPastaProduto;
    property ServerLetraDoDrive: char read GetServerLetraDoDrive write SetServerLetraDoDrive;

    constructor Create( pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo; pDBMSInfo: IDBMSInfo);
  end;

implementation

{ TSisConfig }

uses Sis.UI.IO.Files;

constructor TSisConfig.Create(pLocalMachineId, pServerMachineId: IMachineId; pWinVersionInfo: IWinVersionInfo; pDBMSInfo: IDBMSInfo);
begin
  FServerLetraDoDrive := 'C';
  FLocalMachineId := pLocalMachineId;
  FLocalMachineIsServer := false;
  FServerMachineId := pServerMachineId;
  FWinVersionInfo := pWinVersionInfo;
  FDBMSInfo := pDBMSInfo;
  FPastaProduto := PastaAcima(PastaAtual);
end;

function TSisConfig.GetDBMSInfo: IDBMSInfo;
begin
  result := FDBMSInfo;
end;

function TSisConfig.GetLocalMachineId: IMachineId;
begin
  result := FLocalMachineId;
end;

function TSisConfig.GetLocalMachineIsServer: boolean;
begin
  result := FLocalMachineIsServer;
end;

function TSisConfig.GetPastaProduto: string;
begin
  result := FPastaProduto;
end;

function TSisConfig.GetServerLetraDoDrive: char;
begin
  Result := FServerLetraDoDrive;
end;

function TSisConfig.GetServerMachineId: IMachineId;
begin
  result := FServerMachineId;
end;

function TSisConfig.GetWinVersionInfo: IWinVersionInfo;
begin
  result := FWinVersionInfo;
end;

procedure TSisConfig.SetLocalMachineIsServer(const Value: boolean);
begin
  FLocalMachineIsServer := Value;
end;

procedure TSisConfig.SetServerLetraDoDrive(Value: char);
begin
  FServerLetraDoDrive := Value;
end;

end.
