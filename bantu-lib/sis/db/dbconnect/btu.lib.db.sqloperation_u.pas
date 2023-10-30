unit btu.lib.db.sqloperation_u;

interface

uses btu.lib.db.types, System.Classes, FireDAC.Stan.Param, sis.ui.io.LogProcess,
  sis.ui.io.output;

type
  TDBSqlOperation = class(TInterfacedObject, IDBSqlOperation)
  private
    FUltimoErro: string;
    FDBConnection: IDBConnection;
    FLogProcess: ILogProcess;
    FOutput: IOutput;

    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);
  protected
    function GetParams: TFDParams; virtual; abstract;
    function GetSQL: string; virtual; abstract;
    procedure  SetSQL(Value: string); virtual; abstract;
    property DBConnection: IDBConnection read FDBConnection;
    property SQL: string read GetSQL write SetSQL;
    property LogProcess: ILogProcess read FLogProcess;
    property output: IOutput read FOutput;

    function GetPrepared: boolean; virtual; abstract;
    procedure SetPrepared(Value: boolean); virtual; abstract;
  public
    property Params: TFDParams read GetParams;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    procedure Prepare; virtual; abstract;
    procedure Unprepare; virtual; abstract;
    property Prepared: boolean read GetPrepared write SetPrepared;

    constructor Create(pDBConnection: IDBConnection; pLogProcess: ILogProcess;
      pOutput: IOutput);
  end;

implementation

{ TDBCommand }

constructor TDBSqlOperation.Create(pDBConnection: IDBConnection; pLogProcess: ILogProcess;
  pOutput: IOutput);
begin
  FDBConnection := pDBConnection;
  FLogProcess := pLogProcess;
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
