unit Sis.DB.DBExec.FireDAC_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  Sis.DB.DBExec_u, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output;

type
  TDBExecFireDac = class(TDBExec)
  private
    FFDCommand: TFDCommand;

  protected
    function GetParams: TFDParams; override;
    procedure SetSQL(Value: string); override;
    function GetSQL: string; override;

    function GetPrepared: boolean; override;
    procedure SetPrepared(Value: boolean); override;
  public
    procedure Execute; override;
    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pSql: string; pProcessLog: IProcessLog; pOutput: IOutput);
    destructor Destroy; override;
    procedure Prepare; override;
    procedure Unprepare; override;
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u;

{ TDBExecFireDac }

constructor TDBExecFireDac.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pSql: string; pProcessLog: IProcessLog;
  pOutput: IOutput);
var
  sLog: string;
begin
  pProcessLog.PegueLocal('TDBExecFireDac.Create');
  try
    inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput);
    sLog := 'retornou de inherited Create,vai FFDCommand := TFDCommand.Create';
    FFDCommand := TFDCommand.Create(nil);
    FFDCommand.Connection := TFDConnection(pDBConnection.ConnectionObject);
    Sql := pSql;
    sLog := sLog + ','#13#10 + pSql + #13#10;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

destructor TDBExecFireDac.Destroy;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBExecFireDac.Destroy');
  try
    DBLog.Registre('vai FreeAndNil(FDCommand)');
    FreeAndNil(FFDCommand);
    inherited;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecFireDac.Execute;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBExecFireDac.Execute');
  try
    inherited;
    try
      sLog := Sql + ',' + GetParamsAsStr + ', vai FFDCommand.Execute';

      FFDCommand.Execute;
    except
      on e: exception do
      begin
        UltimoErro := 'TDBExecFireDac.Execute Erro'#13#10#13#10 + e.classname +
          #13#10 + e.message + #13#10 + #13#10 +
          'ao tentar executar:'#13#10#13#10 + Sql;
        sLog := sLog + ',' + UltimoErro;
        Output.Exibir(UltimoErro);
        raise exception.Create(UltimoErro);
      end;
    end;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

function TDBExecFireDac.GetParams: TFDParams;
begin
  Result := FFDCommand.Params;
end;

function TDBExecFireDac.GetPrepared: boolean;
begin
  Result := FFDCommand.Prepared;
end;

function TDBExecFireDac.GetSQL: string;
begin
  Result := FFDCommand.CommandText.Text;
end;

procedure TDBExecFireDac.Prepare;
var
  sLog: string;
begin
  ProcessLog.PegueLocal('TDBExecFireDac.Prepare');
  try
    inherited;
    if not FFDCommand.Prepared then
    begin
      DBLog.Registre('vai FDCommand.Prepare');
      FFDCommand.Prepare;
    end;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecFireDac.SetPrepared(Value: boolean);
begin
  ProcessLog.PegueLocal('TDBExecFireDac.SetPrepared');
  try
    DBLog.Registre('Value=' + BooleanToStr(Value));
    if FFDCommand.Prepared = Value then
      exit;
    FFDCommand.Prepared := Value;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBExecFireDac.SetSQL(Value: string);
begin
  inherited;
  FFDCommand.CommandText.Text := Value;
end;

procedure TDBExecFireDac.Unprepare;
begin
  ProcessLog.PegueLocal('TDBExecFireDac.Unprepare');
  try
    inherited;
    if FFDCommand.Prepared then
    begin
      DBLog.Registre('vai FDCommand.Unprepare');
      FFDCommand.Unprepare;
    end;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

end.
