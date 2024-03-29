unit btu.lib.db.exec.firedac_u;

interface

uses
  btu.lib.db.exec_u, FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.db,
  btu.lib.db.types, sis.UI.io.LogProcess, sis.UI.io.output;

type
  TDBExecFireDac = class(TDBExec)
  private
    FDCommand: TFDCommand;

  protected
    function GetParams: TFDParams; override;
    procedure SetSQL(Value: string); override;
    function GetSQL: string; override;

    function GetPrepared: boolean; override;
    procedure SetPrepared(Value: boolean); override;
  public
    procedure Execute; override;
    constructor Create(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
      pOutput: IOutput);
    destructor Destroy; override;
    procedure Prepare; override;
    procedure Unprepare; override;
  end;


implementation

uses System.SysUtils;

{ TDBExecFireDac }

constructor TDBExecFireDac.Create(pDBConnection: IDBConnection; pSql: string;
  pLogProcess: ILogProcess; pOutput: IOutput);
var
  s: string;
begin
  inherited Create(pDBConnection, pLogProcess, pOutput);
  FDCommand := TFDCommand.Create(nil);
  FDCommand.Connection := TFDConnection( pDBConnection.ConnectionObject);
  Sql := pSql;
  s := 'TDBExecFireDac.Create,'#13#10+pSql+#13#10;
  LogProcess.Exibir(s);
end;

destructor TDBExecFireDac.Destroy;
begin
  LogProcess.Exibir('TDBExecFireDac.Destroy');
  FreeAndNil(FDCommand);
  inherited;
end;

procedure TDBExecFireDac.Execute;
begin
  inherited;
  LogProcess.Exibir('Executar�'#13#10+SQL+#13#10+GetParamsAsStr);
  FDCommand.Execute;
end;

function TDBExecFireDac.GetParams: TFDParams;
begin
  Result := FDCommand.Params;
end;

function TDBExecFireDac.GetPrepared: boolean;
begin
  Result := FDCommand.Prepared;
end;

function TDBExecFireDac.GetSQL: string;
begin
  Result := FDCommand.CommandText.Text;
end;

procedure TDBExecFireDac.Prepare;
begin
  inherited;
  if not FDCommand.Prepared then
  begin
    LogProcess.Exibir('TDBExecFireDac.Prepare,FDCommand.Prepare');
    FDCommand.Prepare;
  end;
end;

procedure TDBExecFireDac.SetPrepared(Value: boolean);
begin
  inherited;
  FDCommand.Prepared := Value;
end;

procedure TDBExecFireDac.SetSql(Value: string);
begin
  inherited;
  FDCommand.CommandText.Text := Value;
end;

procedure TDBExecFireDac.Unprepare;
begin
  inherited;
  if FDCommand.Prepared then
  begin
    LogProcess.Exibir('TDBExecFireDac.Unprepare,FDCommand.Unprepare');
    FDCommand.Unprepare;
  end;
end;

end.
