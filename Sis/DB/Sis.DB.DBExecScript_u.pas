unit Sis.DB.DBExecScript_u;

interface

uses
  FireDAC.Stan.Param, System.Classes, Data.DB, Sis.DB.DBSQLOperation_u,
  Sis.DB.DBTypes, System.SysUtils, Sis.Types, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog.Registrador,
  Sis.Threads.Crit.FixedCriticalSection_u;

type
  TDBExecScript = class(TDBSqlOperation, IDBExecScript)
  private
    FThreadSafe: Boolean;
    FCritcalSection: TFixedCriticalSection;
    FProcExecute: TProcedureOfObject;

    function GetThreadSafe: Boolean;
    procedure SetThreadSafe(const Value: Boolean);

    function GetExecute: TProcedureOfObject;
    procedure SetExecute(const Value: TProcedureOfObject);

    property ProcExecute: TProcedureOfObject read GetExecute write SetExecute;

    procedure ExecuteSafe;
  protected
    procedure ExecuteNormal; virtual; abstract;

  public
    procedure Execute;
    procedure PegueComando(pComando: string); virtual; abstract;
    property ThreadSafe: Boolean read GetThreadSafe write SetThreadSafe;
    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pProcessLog: IProcessLog; pOutput: IOutput;
      pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean = True);
  end;

implementation

{ TDBExecScript }

constructor TDBExecScript.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog; pOutput: IOutput;
  pCritcalSection: TFixedCriticalSection; pThreadSafe: Boolean);
begin
  inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput);

  FCritcalSection := pCritcalSection;
  if FCritcalSection = nil then
    pThreadSafe := False;

  SetThreadSafe(pThreadSafe);
end;

procedure TDBExecScript.Execute;
begin
  ProcExecute;
end;

procedure TDBExecScript.ExecuteSafe;
begin
  FCritcalSection.Acquire;
  try
    ExecuteNormal;
  finally
    FCritcalSection.Release;
  end;
end;

function TDBExecScript.GetExecute: TProcedureOfObject;
begin
  Result := FProcExecute;
end;

function TDBExecScript.GetThreadSafe: Boolean;
begin
  Result := FThreadSafe;
end;

procedure TDBExecScript.SetExecute(const Value: TProcedureOfObject);
begin
  FProcExecute := Value;
end;

procedure TDBExecScript.SetThreadSafe(const Value: Boolean);
begin
  FThreadSafe := Value;
  if Value then
    FProcExecute := ExecuteSafe
  else
    FProcExecute := ExecuteNormal;
end;

end.
