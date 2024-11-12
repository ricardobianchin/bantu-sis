unit Sis.DB.SqlCreator_u;

interface

uses Sis.DB.SqlCreator, Sis.DB.SqlUtils_u, Sis.Types.Bool_u, Data.DB;

type
  TSqlCreator = class(TInterfacedObject, ISqlCreator)
  private
    FSqlText: string;
    function GetSqlText: string;
    procedure SetSqlText(const Value: string);

  public
    function ParamSetStr(pNomeParam: string; pValor: string): ISqlCreator;
    function ParamSetInt(pNomeParam: string; pValor: Int64): ISqlCreator;
    function ParamSetBool(pNomeParam: string; pValor: Boolean): ISqlCreator;

    function ParamSetData(pNomeParam: string; pValor: TDateTime): ISqlCreator;
    function ParamSetDataHora(pNomeParam: string; pValor: TDateTime)
      : ISqlCreator;

    property SqlText: string read GetSqlText write SetSqlText;
    function PreencherPeloDataSet(q:TDataSet): string;
    constructor Create(pSqlText: string);
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.Types.Dates, Sis.Types.Floats;

{ TSqlCreator }

constructor TSqlCreator.Create(pSqlText: string);
begin
  SqlText := pSqlText;
end;

function TSqlCreator.ParamSetStr(pNomeParam, pValor: string): ISqlCreator;
begin
  pNomeParam := ':' + AnsiUpperCase(pNomeParam);
  FSqlText := ReplaceStr(FSqlText, pNomeParam, QuotedStr(pValor));
  Result := Self;
end;

function TSqlCreator.PreencherPeloDataSet(q: TDataSet): string;
var
  I: integer;
  oField: TField;
  sParamName: string;
  sSqlConstant: string;

begin
  Result := GetSqlText;

  for I := 0 to q.FieldCount - 1 do
  begin
    oField := q.Fields[I];
    sParamName := ':' + oField.FieldName;
    sSqlConstant := FieldToSqlConstant(oField);
    Result := ReplaceStr(Result, sParamName, sSqlConstant);
  end;
end;

function TSqlCreator.GetSqlText: string;
begin
  Result := FSqlText;
end;

procedure TSqlCreator.SetSqlText(const Value: string);
begin
  FSqlText := AnsiUpperCase(Value);
end;

function TSqlCreator.ParamSetBool(pNomeParam: string; pValor: Boolean)
  : ISqlCreator;
begin
  pNomeParam := ':' + AnsiUpperCase(pNomeParam);
  FSqlText := ReplaceStr(FSqlText, pNomeParam, Iif(pValor, 'TRUE', 'FALSE'));
  Result := Self;
end;

function TSqlCreator.ParamSetData(pNomeParam: string; pValor: TDateTime)
  : ISqlCreator;
begin
  pNomeParam := ':' + AnsiUpperCase(pNomeParam);
  FSqlText := ReplaceStr(FSqlText, pNomeParam, DataSQLFirebird(pValor));
  Result := Self;
end;

function TSqlCreator.ParamSetDataHora(pNomeParam: string; pValor: TDateTime)
  : ISqlCreator;
begin
  pNomeParam := ':' + AnsiUpperCase(pNomeParam);
  FSqlText := ReplaceStr(FSqlText, pNomeParam, DataHoraSQLFirebird(pValor));
  Result := Self;
end;

function TSqlCreator.ParamSetInt(pNomeParam: string; pValor: Int64)
  : ISqlCreator;
begin
  pNomeParam := ':' + AnsiUpperCase(pNomeParam);
  FSqlText := ReplaceStr(FSqlText, pNomeParam, pValor.ToString);
  Result := Self;
end;

end.
