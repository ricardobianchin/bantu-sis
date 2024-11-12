unit Sis.DB.DBSQLOperation_u;

interface

uses System.Classes, FireDAC.Stan.Param, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog.Registrador;

type
  TDBSQLOperation = class(TInterfacedObject, IDBSQLOperation)
  private
    FUltimoErro: string;
    FDBConnection: IDBConnection;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FNome: string;
    FDBLog: IProcessLogRegistrador;

    function GetNome: string;

    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);
  protected
    function GetParams: TFDParams; virtual; abstract;
    function GetSQL: TStrings; virtual; abstract;
    property DBConnection: IDBConnection read FDBConnection;
    property SQL: TStrings read GetSQL;
    property ProcessLog: IProcessLog read FProcessLog;
    property output: IOutput read FOutput;

    function GetPrepared: boolean; virtual; abstract;
    procedure SetPrepared(Value: boolean); virtual; abstract;
    function GetParamsAsStr: string;
    property Nome: string read GetNome;
    property DBLog: IProcessLogRegistrador read FDBLog;
  public
    property Params: TFDParams read GetParams;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    procedure Prepare; virtual; abstract;
    procedure Unprepare; virtual; abstract;
    property Prepared: boolean read GetPrepared write SetPrepared;

    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection; pProcessLog: IProcessLog;
      pOutput: IOutput);
  end;

implementation

uses System.Variants, Sis.UI.IO.Output.ProcessLog.Factory, System.StrUtils;

{ TDBCommand }

constructor TDBSQLOperation.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pProcessLog: IProcessLog; pOutput: IOutput);
var
  s: string;
begin
  FDBConnection := pDBConnection;
  FProcessLog := pProcessLog;
  FOutput := pOutput;

  FProcessLog.PegueLocal('TDBSQLOperation.Create');
  try
    FNome := pNomeComponente;
    FDBLog := ProcessLogRegistradorCreate(FProcessLog, TProcessLogTipo.lptDB,
      FNome);
  finally
    FDBLog.Registre('Nome=' + Nome+',FDBConnection.Nome='+FDBConnection.Nome);
    FProcessLog.RetorneLocal;
  end;
end;

function TDBSQLOperation.GetNome: string;
begin
  Result := FNome;
end;

function TDBSQLOperation.GetParamsAsStr: string;
var
  sResult: string;
  L, I: integer;
  Param: TFDParam;
begin
  sResult := '';

  for I := 0 to Params.Count - 1 do
  begin
    Param := Params[I];

    sResult := sResult + '[' + Param.Name + '=' + VarToStrDef(Param.Value,
      'NULL') + '],';
  end;

  if sResult <> '' then
  begin
    L := Length(sResult);
    sResult :=LeftStr( sResult, L - 1);
  end;

  Result := sResult;
end;

function TDBSQLOperation.GetUltimoErro: string;
begin
  Result := FUltimoErro;
end;

procedure TDBSQLOperation.SetUltimoErro(Value: string);
begin
  FUltimoErro := Value;
end;

end.
