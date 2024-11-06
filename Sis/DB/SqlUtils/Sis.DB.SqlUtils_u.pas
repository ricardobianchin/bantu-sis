unit Sis.DB.SqlUtils_u;

interface

uses Data.DB;

function FieldToSqlConstant(pField: TField): string;
function DataSetToSqlGarantir(q: TDataSet; pNomeTabela, pPrimaryKeyFieldNames: string): string; overload;
function DataSetToSqlGarantir(q: TDataSet; pNomeTabela: string; pPrimaryKeyFieldNames: string; pFieldIndexes: TArray<Integer>): string; overload;

implementation

uses System.SysUtils, Sis.Types.Bool_u, Sis.Types.Dates;

function FieldToSqlConstant(pField: TField): string;
begin
  Result := '';
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
        Result := pField.AsCurrency.ToString;
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
      ftBCD: ;
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

function DataSetToSqlGarantir(q: TDataSet; pNomeTabela, pPrimaryKeyFieldNames: string): string; overload;
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

  Result :=  'UPDATE OR INSERT INTO ' + pNomeTabela + //
             ' ('+ FieldNames + ')' + //
             ' VALUES ' + //
             ' ('+ SqlConstants + ')' + //
             ' MATCHING ('+ pPrimaryKeyFieldNames +');'; //
end;

function DataSetToSqlGarantir(q: TDataSet; pNomeTabela: string; pPrimaryKeyFieldNames: string; pFieldIndexes: TArray<Integer>): string; overload;
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

  Result :=  'UPDATE OR INSERT INTO ' + pNomeTabela + //
             ' ('+ FieldNames + ')' + //
             ' VALUES ' + //
             ' ('+ SqlConstants + ')' + //
             ' MATCHING ('+ pPrimaryKeyFieldNames +');'; //
end;

end.

