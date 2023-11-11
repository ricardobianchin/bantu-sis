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
    procedure SetSQL(Value: string); virtual; abstract;
    property DBConnection: IDBConnection read FDBConnection;
    property SQL: string read GetSQL write SetSQL;
    property LogProcess: ILogProcess read FLogProcess;
    property output: IOutput read FOutput;

    function GetPrepared: boolean; virtual; abstract;
    procedure SetPrepared(Value: boolean); virtual; abstract;
    function GetParamsAsStr: string;
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

uses System.Variants;

{ TDBCommand }

constructor TDBSqlOperation.Create(pDBConnection: IDBConnection;
  pLogProcess: ILogProcess; pOutput: IOutput);
var
  s: string;
begin
  FDBConnection := pDBConnection;
  FLogProcess := pLogProcess;
  FOutput := pOutput;

  s := 'TDBSqlOperation.Create';
  FLogProcess.Exibir(s);
end;

function TDBSqlOperation.GetParamsAsStr: string;
var
  s: string;
  I: integer;
  Param: TFDParam;
begin
  s := '';

  for I := 0 to Params.Count - 1 do
  begin
    Param := Params[I];

    if s <> '' then
      s := s + ',';

    s := s + '[' + Param.Name + ' = ' + VarToStrDef(Param.Value, 'NULL') + ']';
  end;

  Result := s;
end;

function TDBSqlOperation.GetUltimoErro: string;
begin
  Result := FUltimoErro;
end;

procedure TDBSqlOperation.SetUltimoErro(Value: string);
begin
  FUltimoErro := Value;
end;

end.
