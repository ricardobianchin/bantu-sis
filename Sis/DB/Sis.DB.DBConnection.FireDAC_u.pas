unit Sis.DB.DBConnection.FireDAC_u;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  System.Variants, Sis.DB.DBConnection_u, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, FireDAC.Stan.Async;

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

    constructor Create(pNomeComponente: string; pDBMSInfo: IDBMSInfo;
      pDBConnectionParams: TDBConnectionParams; pProcessLog: IProcessLog;
      pOutput: IOutput);
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u;

{ TDBConnectionFireDAC }

function TDBConnectionFireDAC.AbrirConnectionObject: boolean;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBConnectionFireDAC.AbrirConnectionObject');
  try
    Result := false;
    try
      sLog := 'FFDConnection.Open';
      FFDConnection.Open;
    except
      on e: exception do
      begin
        sLog := e.ClassName + ',' + e.Message + ' ao conectar a ' +
          DBConnectionParams.Database;
      end;
    end;
  finally
    sLog := 'vai testar FFDConnection.Connected,' +
      FFDConnection.Params.CommaText;

    Result := FFDConnection.Connected;
    if Result then
      sLog := sLog + ',Conectou'
    else
      sLog := sLog + ',Nao conectou';

    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnectionFireDAC.Commit;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBConnectionFireDAC.Commit');
  try
    sLog := 'vai commit';
    FFDConnection.Commit;
    sLog := sLog + ',retornou do commit';
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

function TDBConnectionFireDAC.ConnectionObjectAberto: boolean;
begin
  Result := FFDConnection.Connected;
end;

constructor TDBConnectionFireDAC.Create(pNomeComponente: string;
  pDBMSInfo: IDBMSInfo; pDBConnectionParams: TDBConnectionParams;
  pProcessLog: IProcessLog; pOutput: IOutput);
var
  sDriver: string;
  s: string;
begin
  FDManager.SilentMode := true;
  pProcessLog.PegueLocal('TDBConnectionFireDAC.Create');
  try
    inherited Create(pNomeComponente, pDBConnectionParams, pProcessLog,
      pOutput);
    DBLog.Registre('voltou de inherited Create');

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
      DBConnectionParams.Server + #13#10 + 'Database=' + DBConnectionParams.Arq
      + #13#10 + 'Password=masterkey'#13#10 + 'User_Name=sysdba'#13#10 +
      'Protocol=TCPIP';
  finally
    DBLog.Registre('Params='#13#10 + FFDConnection.Params.Text);
    ProcessLog.RetorneLocal;
  end;
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
  sLog: string;
begin
  inherited;
  ProcessLog.PegueLocal('TDBConnectionFireDAC.ExecuteSQL');
  try
    sLog := 'Vai executar'#13#10 + pSql;

    DBLog.Registre(pSql);

    try
      Result := FFDConnection.ExecSQL(pSql);
    except
      on e: exception do
      begin
        sLog := sLog + ',' + e.ClassName + ' ' + e.Message;
        raise;
      end;
    end;
  finally
    sLog := sLog + ',Result=' + Result.ToString;

    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnectionFireDAC.FecharConnectionObject;
var
  sLog: string;
begin
  inherited;
  ProcessLog.PegueLocal('TDBConnectionFireDAC.FecharConnectionObject');
  try
    sLog := 'Vai FFDConnection.Close';
    FFDConnection.Close;
    sLog := sLog + ',retornou';
  finally
    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

function TDBConnectionFireDAC.GetConnectionObject: TObject;
begin
  Result := FFDConnection;
end;

function TDBConnectionFireDAC.GetValue(pSql: string): Variant;
var
  sLog: string;
begin
  inherited;
  ProcessLog.PegueLocal('TDBConnectionFireDAC.GetValue');
  try
    sLog := 'FFDConnection.ExecSQLScalar,' + #13#10 + pSql + #13#10;

    sLog := sLog + 'Vai Abrir';
    Abrir;
    sLog := sLog + ',retornou,vai FFDConnection.ExecSQLScalar';
    try
      try
        Result := FFDConnection.ExecSQLScalar(pSql);
      except
        on e: exception do
        begin
          sLog := sLog + #13#10 + e.ClassName + ' ' + e.Message + #13#10;
          raise;
        end;
      end;
    finally
      sLog := sLog + 'Result=' + VarToStrDef(Result, 'nil') + ', vai fechar';
      Fechar;
      sLog := sLog + 'Retornou';
    end;
  finally
    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnectionFireDAC.QueryDataSet(pSql: string;
  var pDataSet: TDataSet);
var
  sLog: string;
begin
  inherited;
  ProcessLog.PegueLocal('TDBConnectionFireDAC.QueryDataSet');
  try
    sLog := #13#10 + pSql + #13#10'vai executar FFDConnection.ExecSQL';
    try
      FFDConnection.ExecSQL(pSql, pDataSet);
    except
      on e: exception do
      begin
        sLog := sLog + #13#10 + e.ClassName + ' ' + e.Message + #13#10;
        raise;
      end;
    end;
    sLog := sLog + 'Retornou,Assigned(pDataSet)=' +
      BooleanToStr(Assigned(pDataSet));
  finally
    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnectionFireDAC.Rollback;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBConnectionFireDAC.Rollback');
  try
    sLog := 'vai FFDConnection.Rollback';
    FFDConnection.Rollback;
    sLog := sLog + ',retornou';
  finally
    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnectionFireDAC.StartTransaction;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBConnectionFireDAC.StartTransaction');
  try
    sLog := 'vai FFDConnection.StartTransaction';
    FFDConnection.StartTransaction;
    sLog := sLog + ',retornou';
  finally
    DBLog.Registre(sLog);

    ProcessLog.RetorneLocal;
  end;
end;

end.
