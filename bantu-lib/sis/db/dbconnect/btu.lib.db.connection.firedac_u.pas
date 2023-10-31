unit btu.lib.db.connection.firedac_u;

interface

uses btu.lib.db.connection_u, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, sis.UI.io.LogProcess,
  sis.UI.io.output, btu.lib.db.types, Data.db, FireDAC.DApt;

type
  TDBConnectionFireDAC = class(TDBConnection)
  private
    FFDConnection: TFDConnection;
    // FDBConnectionParams: TDBConnectionParams;
  protected
    function GetConnectionObject: TObject; override;
    function ConnectionObjectAberto: boolean; override;
    function AbrirConnectionObject: boolean; override;
    procedure FecharConnectionObject; override;

  public
    procedure StartTransaction; override;
    procedure Commit; override;
    procedure Rollback; override;

    function GetValue(pSql: string): Variant; override;
    function ExecuteSQL(pSql: string): LongInt; override;
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet); override;

    constructor Create(pDBMSInfo: IDBMSInfo;
      pDBConnectionParams: TDBConnectionParams; pLogProcess: ILogProcess;
      pOutput: IOutput);
  end;

implementation

uses System.SysUtils;

{ TDBConnectionFireDAC }

function TDBConnectionFireDAC.AbrirConnectionObject: boolean;
var
  sLog: string;
begin
  try
    Result := false;
    try
      FFDConnection.Open;
    except
      on e: exception do
        LogProcess.Exibir('TDBConnectionFireDAC.AbrirConnectionObject Erro ' +
          e.ClassName + ',' + e.Message + ' ao conectar a ' +
          DBConnectionParams.Database);
    end;
  finally
    Result := FFDConnection.Connected;
    if Result then
      sLog := 'Conectou'
    else
      sLog := 'Nao conectou';

    sLog := sLog + FFDConnection.Params.CommaText;
    LogProcess.Exibir(sLog);
  end;
end;

procedure TDBConnectionFireDAC.Commit;
begin
  FFDConnection.Commit;
  FFDConnection.TxOptions.AutoCommit := false;
end;

function TDBConnectionFireDAC.ConnectionObjectAberto: boolean;
begin
  Result := FFDConnection.Connected;
end;

constructor TDBConnectionFireDAC.Create(pDBMSInfo: IDBMSInfo;
  pDBConnectionParams: TDBConnectionParams; pLogProcess: ILogProcess;
  pOutput: IOutput);
var
  sDriver: string;
begin
  inherited Create(pDBConnectionParams, pLogProcess, pOutput);

  // FDBConnectionParams := pDBConnectionParams;

  FFDConnection := TFDConnection.Create(nil);
  FFDConnection.LoginPrompt := false;

  case pDBMSInfo.DatabaseType of
    dbmstUnknown:
      ;
    dbmstFirebird:
      sDriver := 'FB';
    dbmstMySQL:
      ;
    dbmstPostgreSQL:
      ;
    dbmstOracle:
      ;
    dbmstSQLServer:
      ;
    dbmstSQLite:
      ;
  end;

  FFDConnection.Params.Text := 'DriverID=' + sDriver + #13#10 + 'Server=' +
    DBConnectionParams.Server + #13#10 + 'Database=' + DBConnectionParams.Arq +
    #13#10 + 'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 +
    'Protocol=TCPIP'#13#10;

  (*
    object FDConnection1: TFDConnection
    Params.Strings = (
    'Database=C:\Pr\app\bantu\bantu-sis\exe\dados\RETAG.FDB'
    'User_Name=sysdba'
    'Password=masterkey'
    'Protocol=TCPIP'
    'Server=DELPHI-BTU'
    'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 304
    Top = 224
    end
  *)

  // FFDConnection.TxOptions.AutoCommit:=true;
end;

function TDBConnectionFireDAC.ExecuteSQL(pSql: string): LongInt;
begin
  inherited;
  Result := FFDConnection.ExecSQL(pSql);
end;

procedure TDBConnectionFireDAC.FecharConnectionObject;
begin
  inherited;
  FFDConnection.Close;
  LogProcess.Exibir('Desconectou,' + FFDConnection.Params.CommaText);
end;

function TDBConnectionFireDAC.GetConnectionObject: TObject;
begin
  Result := FFDConnection;
end;

function TDBConnectionFireDAC.GetValue(pSql: string): Variant;
begin
  Abrir;
  try
    Result := FFDConnection.ExecSQLScalar(pSql);
  finally
    Fechar;
  end;
end;

procedure TDBConnectionFireDAC.QueryDataSet(pSql: string;
  var pDataSet: TDataSet);
begin
  FFDConnection.ExecSQL(pSql, pDataSet);
end;

procedure TDBConnectionFireDAC.Rollback;
begin
  FFDConnection.Rollback;
  FFDConnection.TxOptions.AutoCommit := false;
end;

procedure TDBConnectionFireDAC.StartTransaction;
begin
  FFDConnection.TxOptions.AutoCommit := true;
  FFDConnection.StartTransaction;
end;

end.
