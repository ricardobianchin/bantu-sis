unit btu.lib.db.sqloperation_u;

interface

uses btu.lib.db.types, System.Classes, FireDAC.Stan.Param, btu.sis.ui.io.log,
  btu.sis.ui.io.output;

type
  TDBSqlOperation = class(TInterfacedObject, IDBSqlOperation)
  private
    FUltimoErro: string;
    FDBConnection: IDBConnection;
    FLog: ILog;
    FOutput: IOutput;

    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);
  protected
    function GetParams: TFDParams; virtual; abstract;
    function GetSql: string; virtual; abstract;
    procedure  SetSql(Value: string); virtual; abstract;
    property DBConnection: IDBConnection read FDBConnection;
    property Sql: string read GetSql write SetSql;
    property log: ILog read FLog;
    property output: IOutput read FOutput;

    function GetPrepared: boolean; virtual; abstract;
    procedure SetPrepared(Value: boolean); virtual; abstract;
  public
    property Params: TFDParams read GetParams;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    procedure Prepare; virtual; abstract;
    procedure Unprepare; virtual; abstract;
    property Prepared: boolean read GetPrepared write SetPrepared;

    constructor Create(pDBConnection: IDBConnection; pLog: ILog;
      pOutput: IOutput);
  end;

implementation

{ TDBCommand }

constructor TDBSqlOperation.Create(pDBConnection: IDBConnection; pLog: ILog;
  pOutput: IOutput);
begin
  FDBConnection := pDBConnection;
  FLog := pLog;
  FOutput := pOutput;
end;

function TDBSqlOperation.GetUltimoErro: string;
begin
  result := FUltimoErro;
end;

procedure TDBSqlOperation.SetUltimoErro(Value: string);
begin
  FUltimoErro := Value;
end;

end.
