unit btu.lib.db.connection.firedac_u;

interface

uses btu.lib.db.connection_u
  , FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, btu.sis.ui.io.log,
  btu.sis.ui.io.output, btu.lib.db.types, Data.DB, FireDAC.DApt
  ;

type
  TDBConnectionFireDAC = class(TDBConnection)
  private
    FFDConnection: TFDConnection;
    FDBConnectionParams: TDBConnectionParams;
  protected
    function GetConnectionObject:TObject; override;
    function ConnectionObjectAberto:boolean; override;
    function AbrirConnectionObject:boolean; override;
    procedure FecharConnectionObject; override;

  public
    procedure StartTransaction; override;
    procedure Commit; override;
    procedure Rollback; override;

    function GetValue(pSql: string): Variant; override;

    constructor Create(pDBMSInfo: IDBMSInfo; pDBConnectionParams: TDBConnectionParams; pLog: ILog;
    pOutput: IOutput);
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet); override;
  end;

implementation

uses System.SysUtils;

{ TDBConnectionFireDAC }

function TDBConnectionFireDAC.AbrirConnectionObject: boolean;
begin
  try
    Result := false;
    try
      FFDConnection.Open;
    except on e: exception do
      Log.Exibir('Erro ' + e.ClassName + ',' + e.Message +' ao conectar a '+ FDBConnectionParams.Database);
    end;
  finally
    result := FFDConnection.Connected;
  end;
end;

procedure TDBConnectionFireDAC.Commit;
begin
  FFDConnection.Commit;
end;

function TDBConnectionFireDAC.ConnectionObjectAberto: boolean;
begin
  Result := FFDConnection.Connected;
end;

constructor TDBConnectionFireDAC.Create(pDBMSInfo: IDBMSInfo; pDBConnectionParams: TDBConnectionParams; pLog: ILog; pOutput: IOutput);
var
  sDriver: string;
begin
  inherited Create(pDBConnectionParams, pLog, pOutput);

  FDBConnectionParams := pDBConnectionParams;

  FFDConnection:=TFDConnection.Create(nil);
  FFDConnection.LoginPrompt := false;

  case pDBMSInfo.DatabaseType of
    dbmstUnknown: ;
    dbmstFirebird: sDriver := 'FB';
    dbmstMySQL: ;
    dbmstPostgreSQL: ;
    dbmstOracle: ;
    dbmstSQLServer: ;
    dbmstSQLite: ;
  end;

  FFDConnection.Params.Text:=
    'DriverID='+sDriver+#13#10
    +'Server='+FDBConnectionParams.Server+#13#10
    +'Database='+FDBConnectionParams.Arq+#13#10
    +'Password=masterkey'#13#10
    +'User_Name=sysdba'#13#10
    +'Protocol=TCPIP'#13#10
    ;

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

  //FFDConnection.TxOptions.AutoCommit:=true;
end;

procedure TDBConnectionFireDAC.FecharConnectionObject;
begin
  inherited;
  FFDConnection.Close;
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
end;

procedure TDBConnectionFireDAC.StartTransaction;
begin
  FFDConnection.StartTransaction;
end;

end.
