unit btu.lib.db.connection.firedac_u;

interface

uses btu.lib.db.connection_u, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, sis.UI.io.LogProcess,
  sis.UI.io.output, btu.lib.db.types, Data.db, FireDAC.DApt, System.Variants;

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

uses System.SysUtils, sis.types.bool.utils;

{ TDBConnectionFireDAC }

function TDBConnectionFireDAC.AbrirConnectionObject: boolean;
var
  sLog: string;
begin
  try
    Result := false;
    try
      sLog := 'TDBConnectionFireDAC.AbrirConnectionObject,'
        + 'FFDConnection.Open';
      FFDConnection.Open;
    except
      on e: exception do
    begin
        sLog := 'TDBConnectionFireDAC.AbrirConnectionObject,Erro ' + e.ClassName
          + ',' + e.Message + ' ao conectar a ' + DBConnectionParams.Database;
        LogProcess.Exibir(sLog);
    end;
    end;
  finally
    sLog := 'TDBConnectionFireDAC.AbrirConnectionObject,'
      +'vai testar FFDConnection.Connected,'
      + FFDConnection.Params.CommaText
      ;

    Result := FFDConnection.Connected;
    if Result then
      sLog := sLog + ',Conectou'
    else
      sLog := sLog + ',Nao conectou';

    LogProcess.Exibir(sLog);
  end;
end;

procedure TDBConnectionFireDAC.Commit;
begin
  FFDConnection.Commit;
  LogProcess.Exibir('TDBConnectionFireDAC.Commit,FFDConnection.Commit');

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
  s: string;
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
    'Protocol=TCPIP';

  LogProcess.Exibir('TDBConnectionFireDAC.Create'#13#10 +
    FFDConnection.Params.Text);
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
var
  s: string;
begin
  inherited;
  s :=
    'TDBConnectionFireDAC.ExecuteSQL'
    +',FFDConnection.ExecSQL,vai executar,'
    +#13#10+pSql+#13#10
    ;
  LogProcess.Exibir(s);
  try
    Result := FFDConnection.ExecSQL(pSql);
  finally
    s := 'Result='+Result.ToString;
    LogProcess.Exibir(s);
  end;
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
var
  s: string;
begin
  s :=
    'TDBConnectionFireDAC.GetValue'
    +',FFDConnection.ExecSQLScalar,'
    +#13#10+pSql+#13#10
    ;
  LogProcess.Exibir(s);

  LogProcess.Exibir('TDBConnectionFireDAC.GetValue,vai Abrir');
  Abrir;
  try
    Result := FFDConnection.ExecSQLScalar(pSql);
  finally
    s := 'Result='+VarToStrDef(Result, 'nil');
    LogProcess.Exibir(s);

    LogProcess.Exibir('TDBConnectionFireDAC.GetValue,vai Fechar');
    Fechar;
  end;
end;

procedure TDBConnectionFireDAC.QueryDataSet(pSql: string;
  var pDataSet: TDataSet);
var
  s: string;
begin
  s :='TDBConnectionFireDAC.QueryDataSet'
    +',FFDConnection.ExecSQL(pSql, pDataSet)'
    +#13#10+pSql+#13#10;
  LogProcess.Exibir(s);

  FFDConnection.ExecSQL(pSql, pDataSet);

  s := 'Assigned(pDataSet)='+BooleanToStr(Assigned(pDataSet));
  LogProcess.Exibir(s);
end;

procedure TDBConnectionFireDAC.Rollback;
begin
  LogProcess.Exibir('FFDConnection.Rollback');
  FFDConnection.Rollback;
end;

procedure TDBConnectionFireDAC.StartTransaction;
begin
  LogProcess.Exibir('FFDConnection.StartTransaction');
  FFDConnection.StartTransaction;
end;

end.
