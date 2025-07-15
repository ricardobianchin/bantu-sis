unit Sis.DB.DataSet.Utils;

interface

uses
  FireDAC.Comp.Client, Vcl.DBGrids, Data.DB, Sis.Sis.Constants, System.Variants,
  System.Classes, Sis.DB.DBTypes;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid; pIndexIni: integer = 0;
  pIndexFin: integer = INDEX_ILIMITADO);

procedure RecordToVarArray(out pVarArray: variant; pQ: TDataSet;
  out pDataSetWasEmpty: Boolean);

procedure FDMemTableAppendDataSet(pOrigem: TDataSet; pDestino: TFDMemTable;
  pApagaDestinoAntes: Boolean = True);

procedure RecordToFDMemTable(pOrigem: TDataSet; pDestino: TFDMemTable); inline;

procedure ListaSelectPreencher(pOrigem: TDataSet; pDestinoSL: TStrings);

function RecordToFielNamesStr(pDataSet: TDataSet): string;
function RecordToCSVStr(pDataSet: TDataSet): string;
function RecordToIni(pDataSet: TDataSet): string;
function FieldToString(pField: TField): string;

procedure DataSetForEach(pDataSet: TDataSet; pProcLeReg: TProcDataSetOfObject);

implementation

uses Sis.DB.FDDataSetManager, Sis.DB.Factory, System.SysUtils, Sis.Types.Bool_u,
  Sis.Types.Floats;

procedure DefCamposSL(DefsSL: TStringList; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid);
var
  oFDDataSetManager: IFDDataSetManager;
begin
  oFDDataSetManager := FDDataSetManagerCreate(pFDMemTable, pDBGrid);
  oFDDataSetManager.DefinaCampos(DefsSL);
end;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid; pIndexIni: integer = 0;
  pIndexFin: integer = INDEX_ILIMITADO);
const
  QTD_LINHAS_TITULO = 2;
var
  DefsSL: TStringList;
  QtdLinhasIniciaisAExcluir: integer;
  i: integer;
begin
  if not FileExists(pNomeArq) then
  begin
    raise Exception.Create('Definindo campos, arquivo nao encontrado ' +
      pNomeArq);
  end;

  DefsSL := TStringList.Create;
  try
    DefsSL.LoadFromFile(pNomeArq);
    if pIndexFin <> INDEX_ILIMITADO then
    begin
      while DefsSL.Count < (pIndexFin + 1) do
      begin
        DefsSL.Delete(DefsSL.Count - 1);
      end;
    end;

    QtdLinhasIniciaisAExcluir := QTD_LINHAS_TITULO + pIndexIni;

    if (QtdLinhasIniciaisAExcluir > 0) and
      (QtdLinhasIniciaisAExcluir <= DefsSL.Count) then
    begin
      for i := 0 to QtdLinhasIniciaisAExcluir - 1 do
        DefsSL.Delete(0); // Exclui a primeira linha repetidamente
    end;

    DefCamposSL(DefsSL, pFDMemTable, pDBGrid);
  finally
    DefsSL.Free;
  end;
end;

procedure RecordToVarArray(out pVarArray: variant; pQ: TDataSet;
  out pDataSetWasEmpty: Boolean);
var
  iQtdCampos: integer;
  iFieldIndex: integer;
  Resultado: Boolean;
begin
  pDataSetWasEmpty := True;
  try
    Resultado := Assigned(pQ);

    if not Resultado then
      exit;

    pDataSetWasEmpty := pQ.IsEmpty;
    Resultado := not pDataSetWasEmpty;

    if not Resultado then
      exit;

    Resultado := pQ.Active;
    if not Resultado then
      exit;

    iQtdCampos := pQ.fieldcount;

    Resultado := iQtdCampos > 0;

    if not Resultado then
      exit;
  finally
    if Resultado then
    begin
      pVarArray := VarArrayCreate([0, iQtdCampos - 1], varVariant);

      for iFieldIndex := 0 to iQtdCampos - 1 do
      begin
        pVarArray[iFieldIndex] := pQ.Fields[iFieldIndex].Value;
      end;
    end
    else
    begin
      pVarArray := VarArrayCreate([1, 0], varVariant);
    end;
  end;
end;

procedure FDMemTableAppendDataSet(pOrigem: TDataSet; pDestino: TFDMemTable;
  pApagaDestinoAntes: Boolean);
begin
  pDestino.BeginBatch;
  pDestino.DisableControls;
  try
    if pApagaDestinoAntes then
      pDestino.EmptyDataSet;

    while not pOrigem.Eof do
    begin
      pDestino.Append;
      try
        RecordToFDMemTable(pOrigem, pDestino);
      finally
        pDestino.Post;
      end;
      pOrigem.Next;
    end;
  finally
    pDestino.First;
    pDestino.EnableControls;
    pDestino.EndBatch;
  end;
end;

procedure RecordToFDMemTable(pOrigem: TDataSet; pDestino: TFDMemTable); inline;
var
//  s: string;
  oOriField: TField;
begin
  //s := '';
  for var i: integer := 0 to pOrigem.fieldcount - 1 do
  begin
    oOriField := pOrigem.Fields[i];
    //s := s + i.ToString + ': ' + oOriField.FieldName + '=' +
      //FieldToString(oOriField) + #13#10;

    pDestino.Fields[i].Value := oOriField.Value;
    //s := s + #13#10;
  end;
end;

procedure ListaSelectPreencher(pOrigem: TDataSet; pDestinoSL: TStrings);
var
  iId: integer;
  p: Pointer;
  sDescr: string;
begin
  while not pOrigem.Eof do
  begin
    sDescr := Trim(pOrigem.Fields[1].AsString);
    iId := pOrigem.Fields[0].AsInteger;

    if iId < 1 then
    begin
      pDestinoSL.Add(sDescr);
      continue;
    end;

    p := Pointer(iId);
    pDestinoSL.AddObject(sDescr, p);

    pOrigem.Next;
  end;
end;

function RecordToFielNamesStr(pDataSet: TDataSet): string;
var
  iQtdCampos: integer;
begin
  Result := '';
  if not pDataSet.Active then
    exit;

  iQtdCampos := pDataSet.fieldcount;
  for var i := 0 to iQtdCampos - 1 do
    Result := Result + 'q.Fields[' + i.ToString + '] // ' + pDataSet.Fields[i]
      .FieldName + #13#10;
end;

function RecordToCSVStr(pDataSet: TDataSet): string;
var
  iQtdCampos: integer;
begin
  Result := '';
  if not pDataSet.Active then
    exit;

  iQtdCampos := pDataSet.fieldcount;
  for var i := 0 to iQtdCampos - 1 do
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + pDataSet.Fields[i].AsString;
  end;
end;

function RecordToIni(pDataSet: TDataSet): string;
var
  iQtdCampos: integer;
begin
  Result := '';
  if not pDataSet.Active then
    exit;

  iQtdCampos := pDataSet.fieldcount;
  for var i := 0 to iQtdCampos - 1 do
  begin
    Result := Result + pDataSet.Fields[i].FieldName + '=' +
      FieldToString(pDataSet.Fields[i]) + #13#10;
  end;
end;

procedure DataSetForEach(pDataSet: TDataSet; pProcLeReg: TProcDataSetOfObject);
var
  EhFDMemTable: Boolean;
  bm: TBookmark;
  iRecNo: integer;
begin
  EhFDMemTable := pDataSet is TFDMemTable;

  bm := pDataSet.GetBookmark;
  pDataSet.DisableControls;
  if EhFDMemTable then
    (pDataSet as TFDMemTable).BeginBatch;
  try
    pDataSet.First;
    iRecNo := 0;
    while not pDataSet.Eof do
    begin
      inc(iRecNo);
      pProcLeReg(pDataSet, iRecNo);
      pDataSet.Next;
    end;
    pProcLeReg(pDataSet, -1);
  finally
    pDataSet.GoToBookmark(bm);
    pDataSet.FreeBookmark(bm);
    pDataSet.EnableControls;
    if EhFDMemTable then
      (pDataSet as TFDMemTable).EndBatch;
  end;
end;

function FieldToString(pField: TField): string;
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
    ftString, ftFixedChar, ftSmallint, ftInteger, ftWord, ftWideString,
      ftLargeint, ftAutoInc, ftShortint, ftByte:
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
        // Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftBCD:
      begin
        Result := CurrencyToStrPonto(pField.AsCurrency);
        // Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftSingle:
      begin
        Result := pField.AsSingle.ToString;
        // Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftExtended:
      begin
        Result := pField.AsExtended.ToString;
        // Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
      end;

    ftDate:
      begin
        Result := DateToStr(pField.AsDateTime)
      end;

    ftTime:
      begin
        Result := TimeToStr(pField.AsDateTime);
      end;

    ftDateTime, ftTimeStamp:
      begin
        Result := DateTimeToStr(pField.AsDateTime);
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

end.
