unit Sis.DB.DataSet.Utils;

interface

uses
  FireDAC.Comp.Client, Vcl.DBGrids, Data.DB, Sis.Sis.Constants, System.Variants;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid; pIndexIni: integer = 0;
  pIndexFin: integer = INDEX_ILIMITADO);

procedure RecordToVarArray(out pVarArray: variant; pQ: TDataSet;
  out pDataSetWasEmpty: Boolean);
procedure FDMemTableAppendDataSet(pOrigem: TDataSet; pDestino: TFDMemTable;
  pApagaDestinoAntes: Boolean = True);
procedure RecordToFDMemTable(pOrigem: TDataSet; pDestino: TFDMemTable); inline;

implementation

uses System.Classes, Sis.DB.FDDataSetManager, Sis.DB.Factory, System.SysUtils;

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
begin
  for var i: integer := 0 to pOrigem.fieldcount - 1 do
    pDestino.Fields[i].Value := pOrigem.Fields[i].Value;
end;

end.
