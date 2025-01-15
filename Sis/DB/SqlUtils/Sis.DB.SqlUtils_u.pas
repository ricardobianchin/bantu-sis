unit Sis.DB.SqlUtils_u;

interface

uses Data.DB, System.Generics.Collections, System.Generics.Defaults;

/// <summary>
/// Converts a TField value to its corresponding SQL constant representation.
/// </summary>
/// <param name="pField">The field to convert.</param>
/// <returns>A string representing the SQL constant.</returns>
function FieldToSqlConstant(pField: TField): string;

/// <summary>
/// Generates an SQL insert into statement for a dataset.
/// </summary>
/// <param name="q">The dataset containing the data.</param>
/// <param name="pNomeTabela">The name of the table.</param>
/// <returns>An SQL insert into statement as a string.</returns>
function DataSetToSqlInsertInto(q: TDataSet; pNomeTabela: string): string;

/// <summary>
/// Generates an SQL statement to update or insert data into a table.
/// </summary>
/// <param name="q">The dataset containing the data.</param>
/// <param name="pNomeTabela">The name of the table.</param>
/// <param name="pPrimaryKeyFieldNames">The primary key field names.</param>
/// <returns>An SQL statement as a string.</returns>
function DataSetToSqlGarantir(q: TDataSet;
  pNomeTabela, pPrimaryKeyFieldNames: string): string; overload;

/// <summary>
/// Generates an SQL statement to update or insert data into a table.
/// </summary>
/// <param name="q">The dataset containing the data.</param>
/// <param name="pNomeTabela">The name of the table.</param>
/// <param name="pPrimaryKeyFieldNames">The primary key field names.</param>
/// <param name="pFieldIndexes">The indexes of the fields to include in the statement.</param>
/// <returns>An SQL statement as a string.</returns>
function DataSetToSqlGarantir(q: TDataSet; pNomeTabela: string;
  pPrimaryKeyFieldNames: string; pFieldIndexes: TArray<Integer>)
  : string; overload;

/// <summary>
/// Generates an SQL update statement for a dataset.
/// </summary>
/// <param name="q">The dataset containing the data.</param>
/// <param name="pNomeTabela">The name of the table.</param>
/// <param name="pPrimaryKeyFieldIndexes">The indexes of the primary key fields.</param>
/// <returns>An SQL update statement as a string.</returns>
function DataSetToSqlUpdate(q: TDataSet; pNomeTabela: string;
  pPrimaryKeyFieldIndexes: TArray<Integer>): string; overload;

/// <summary>
/// Generates an SQL update statement for a dataset.
/// </summary>
/// <param name="q">The dataset containing the data.</param>
/// <param name="pNomeTabela">The name of the table.</param>
/// <param name="pFieldIndexes">The indexes of the fields to include in the update statement.</param>
/// <param name="pPrimaryKeyFieldIndexes">The indexes of the primary key fields.</param>
/// <returns>An SQL update statement as a string.</returns>
function DataSetToSqlUpdate(q: TDataSet; pNomeTabela: string;
  pFieldIndexes: TArray<Integer>; pPrimaryKeyFieldIndexes: TArray<Integer>)
  : string; overload;

implementation

uses System.SysUtils, Sis.Types.Bool_u, Sis.Types.Dates,
  Sis.Types.Arrays.ArrayUtils_u, Sis.Types.Floats;

function FieldToSqlConstant(pField: TField): string;
var
  sName: string;
begin
  Result := '';
  sName := pField.FieldName;
  if pField.IsNull then
  begin
    Result := 'NULL';
    exit;
  end;

  case pField.DataType of
    ftString, ftFixedChar:
      begin
        Result := QuotedStr(pField.AsString);
      end;

    ftSmallint, ftInteger, ftWord, ftWideString, ftLargeint, ftAutoInc,
      ftShortint, ftByte:
      begin
        Result := pField.AsString;
      end;

    ftBoolean:
      begin
        Result := Iif(pField.AsBoolean, 'TRUE', 'FALSE');
      end;

    ftFloat:
      begin
        Result := pField.AsFloat.ToString;
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftCurrency:
      begin
        Result := CurrencyToStrPonto(pField.AsCurrency);
        // Result := Format('%0.4f', [pField.AsCurrency]);
        // Result := pField.AsCurrency.ToString;
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftFMTBcd:
      begin
        Result := CurrencyToStrPonto(pField.AsCurrency);
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftBCD:
      begin
        Result := CurrencyToStrPonto(pField.AsCurrency);
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftSingle:
      begin
        Result := pField.AsSingle.ToString;
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftExtended:
      begin
        Result := pField.AsExtended.ToString;
        Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftDate:
      begin
        Result := DataSQLFirebird(pField.AsDateTime)
      end;

    ftTime:
      begin
        Result := HoraSQLFirebird(pField.AsDateTime);
      end;

    ftDateTime, ftTimeStamp:
      begin
        Result := DataHoraSQLFirebird(pField.AsDateTime);
      end;

  else
    raise Exception.Create('FieldToSqlConstant: Tipo nao programado. Campo ' +
      pField.FieldName + ' tipo:' + FieldTypeNames[pField.DataType]);

    {
      ftUnknown: ;
      ftBytes: ;
      ftVarBytes: ;
      ftBlob: ;
      ftMemo: ;
      ftGraphic: ;
      ftFmtMemo: ;
      ftParadoxOle: ;
      ftDBaseOle: ;
      ftTypedBinary: ;
      ftCursor: ;
      ftADT: ;
      ftArray: ;
      ftReference: ;
      ftDataSet: ;
      ftOraBlob: ;
      ftOraClob: ;
      ftVariant: ;
      ftInterface: ;
      ftIDispatch: ;
      ftGuid: ;
      ftFMTBcd: ;
      ftFixedWideChar: ;
      ftWideMemo: ;
      ftOraTimeStamp: ;
      ftOraInterval: ;
      ftLongWord: ;
      ftConnection: ;
      ftParams: ;
      ftStream: ;
      ftTimeStampOffset: ;
      ftObject: ;
    }
  end;
end;

function DataSetToSqlInsertInto(q: TDataSet; pNomeTabela: string): string;
var
  i: Integer;
  oField: TField;
  FieldNames, SqlConstants: string;
begin
  FieldNames := '';
  SqlConstants := '';

  for i := 0 to q.FieldCount - 1 do
  begin
    oField := q.Fields[i];
    if FieldNames <> '' then
    begin
      FieldNames := FieldNames + ',';
      SqlConstants := SqlConstants + ',';
    end;
    FieldNames := FieldNames + oField.FieldName;
    SqlConstants := SqlConstants + FieldToSqlConstant(oField);
  end;

  Result := 'INSERT INTO ' + pNomeTabela + ' (' + FieldNames + ') VALUES (' + SqlConstants + ');';
end;

function DataSetToSqlGarantir(q: TDataSet;
  pNomeTabela, pPrimaryKeyFieldNames: string): string; overload;
var
  i: Integer;
  oField: TField;
  FieldNames, SqlConstants: string;
begin
  FieldNames := '';
  SqlConstants := '';

  for i := 0 to q.FieldCount - 1 do
  begin
    oField := q.Fields[i];
    if FieldNames <> '' then
    begin
      FieldNames := FieldNames + ',';
      SqlConstants := SqlConstants + ',';
    end;
    FieldNames := FieldNames + oField.FieldName;
    SqlConstants := SqlConstants + FieldToSqlConstant(oField);
  end;

  Result := 'UPDATE OR INSERT INTO ' + pNomeTabela + //
    ' (' + FieldNames + ')' + //
    ' VALUES ' + //
    ' (' + SqlConstants + ')' + //
    ' MATCHING (' + pPrimaryKeyFieldNames + ');'; //
end;

function DataSetToSqlGarantir(q: TDataSet; pNomeTabela: string;
  pPrimaryKeyFieldNames: string; pFieldIndexes: TArray<Integer>)
  : string; overload;
var
  i: Integer;
  oField: TField;
  FieldNames, SqlConstants: string;
begin
  FieldNames := '';
  SqlConstants := '';

  for i in pFieldIndexes do
  begin
    if (i >= 0) and (i < q.FieldCount) then
    begin
      oField := q.Fields[i];
      if FieldNames <> '' then
      begin
        FieldNames := FieldNames + ',';
        SqlConstants := SqlConstants + ',';
      end;
      FieldNames := FieldNames + oField.FieldName;
      SqlConstants := SqlConstants + FieldToSqlConstant(oField);
    end;
  end;

  Result := 'UPDATE OR INSERT INTO ' + pNomeTabela + //
    ' (' + FieldNames + ')' + //
    ' VALUES ' + //
    ' (' + SqlConstants + ')' + //
    ' MATCHING (' + pPrimaryKeyFieldNames + ');'; //
end;

function DataSetToSqlUpdate(q: TDataSet; pNomeTabela: string;
  pPrimaryKeyFieldIndexes: TArray<Integer>): string; overload;
var
  i: Integer;
  oField: TField;
  UpdatePairs, WhereClause: string;
  IsPrimaryKey: Boolean;
begin
  UpdatePairs := '';
  WhereClause := '';

  for i := 0 to q.FieldCount - 1 do
  begin
    IsPrimaryKey := False;
    if Length(pPrimaryKeyFieldIndexes) > 0 then
    begin
      for var j in pPrimaryKeyFieldIndexes do
      begin
        if i = j then
        begin
          IsPrimaryKey := True;
          if WhereClause <> '' then
            WhereClause := WhereClause + ' AND ';
          oField := q.Fields[i];
          WhereClause := WhereClause + oField.FieldName + '=' +
            FieldToSqlConstant(oField);
          Break;
        end;
      end;
    end;

    if not IsPrimaryKey then
    begin
      oField := q.Fields[i];
      if UpdatePairs <> '' then
        UpdatePairs := UpdatePairs + ', ';
      UpdatePairs := UpdatePairs + oField.FieldName + '=' +
        FieldToSqlConstant(oField);
    end;
  end;

  Result := 'UPDATE ' + pNomeTabela + ' SET ' + UpdatePairs + ' WHERE ' +
    WhereClause + ';';
end;

function DataSetToSqlUpdate(q: TDataSet; pNomeTabela: string;
  pFieldIndexes: TArray<Integer>; pPrimaryKeyFieldIndexes: TArray<Integer>)
  : string; overload;
var
  i, j: Integer;
  oField: TField;
  UpdatePairs, WhereClause: string;
begin
  // Validate field indexes
  if Length(pFieldIndexes) = 0 then
    raise Exception.Create('No fields specified for update');
  if Length(pPrimaryKeyFieldIndexes) = 0 then
    raise Exception.Create('No primary key fields specified');

  UpdatePairs := '';
  WhereClause := '';

  for i in pFieldIndexes do
  begin
    if (i >= 0) and (i < q.FieldCount) then
    begin
      oField := q.Fields[i];
      if UpdatePairs <> '' then
        UpdatePairs := UpdatePairs + ', ';
      UpdatePairs := UpdatePairs + oField.FieldName + '=' +
        FieldToSqlConstant(oField);
    end;
  end;

  for j in pPrimaryKeyFieldIndexes do
  begin
    if (j >= 0) and (j < q.FieldCount) then
    begin
      oField := q.Fields[j];
      if WhereClause <> '' then
        WhereClause := WhereClause + ' AND ';
      WhereClause := WhereClause + oField.FieldName + '=' +
        FieldToSqlConstant(oField);
    end;
  end;

  Result := 'UPDATE ' + pNomeTabela + ' SET ' + UpdatePairs + ' WHERE ' +
    WhereClause + ';';
end;

end.
