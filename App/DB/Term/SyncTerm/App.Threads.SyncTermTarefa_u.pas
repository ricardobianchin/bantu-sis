unit App.Threads.SyncTermTarefa_u;

interface

uses App.Threads.TermTarefa_u, Sis.UI.Frame.Status.Thread_u, App.AppObj,
  Sis.Entities.Terminal, Sis.DB.DBTypes, FireDAC.Comp.Client;

type
  TSyncTermTarefa = class(TAppTermTarefa)
  private
    FServDBConnectionParams: TDBConnectionParams;
    FTermDBConnectionParams: TDBConnectionParams;
    FServFDConnection: TFDConnection;
    FTermFDConnection: TFDConnection;
  protected
    procedure DoThreadTerminate(Sender: TObject); override;
    property ServFDConnection: TFDConnection read FServFDConnection;
    property TermFDConnection: TFDConnection read FTermFDConnection;

  public
    constructor Create(pServDBConnectionParams: TDBConnectionParams;
      pTermDBConnectionParams: TDBConnectionParams; pTerminal: ITerminal;
      pAppObj: IAppObj; pFrame: TThreadStatusFrame);
    destructor Destroy; override;
    procedure Execute; override;
  end;

implementation

uses Sis.Config.SisConfig;

{ TSyncTermTarefa }

constructor TSyncTermTarefa.Create(pServDBConnectionParams,
  pTermDBConnectionParams: TDBConnectionParams; pTerminal: ITerminal;
  pAppObj: IAppObj; pFrame: TThreadStatusFrame);
var
  s: ISisConfig;
  sDriver: string;
begin
  inherited Create(pTerminal, pAppObj, pFrame);
  s := AppObj.SisConfig;

  FServDBConnectionParams := pServDBConnectionParams;
  FTermDBConnectionParams := pTermDBConnectionParams;

  FServFDConnection := TFDConnection.Create(nil);
  FServFDConnection.LoginPrompt := false;
  sDriver := 'FB';

  FServFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + FServDBConnectionParams.Server + #13#10 //
    + 'Database=' + FServDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';

  FTermFDConnection := TFDConnection.Create(nil);
  FTermFDConnection.LoginPrompt := false;
  sDriver := 'FB';

  FTermFDConnection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + FTermDBConnectionParams.Server + #13#10 //
    + 'Database=' + FTermDBConnectionParams.Arq + #13#10 +
    'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 + 'Protocol=TCPIP';

end;

destructor TSyncTermTarefa.Destroy;
begin
  FServFDConnection.Free;
  FTermFDConnection.Free;
  inherited;
end;

procedure TSyncTermTarefa.DoThreadTerminate(Sender: TObject);
begin
  FServFDConnection.Close;
  FTermFDConnection.Close;
  inherited;

end;

procedure TSyncTermTarefa.Execute;
begin
  FServFDConnection.Open;
  FTermFDConnection.Open;
  inherited;

end;

end.
