unit Sis.DB.DataSet.Utils;

interface

uses
  FireDAC.Comp.Client, Vcl.DBGrids, Data.DB, Sis.Sis.Constants, System.Variants;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid; pIndexIni: integer = 0; pIndexFin: integer = INDEX_ILIMITADO);

procedure QueryToFDMemTable(pFDMemTable: TFDMemTable; pQ: TDataSet);
function RecordToVarArray(out pVarArray: variant; pQ: TDataSet): variant;

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
  pDBGrid: TDBGrid; pIndexIni: integer = 0; pIndexFin: integer = INDEX_ILIMITADO);
const
  QTD_LINHAS_TITULO = 2;
var
  DefsSL: TStringList;
  QtdLinhasIniciaisAExcluir: integer;
  i: integer;
begin
  if not FileExists(pNomeArq) then
  begin
    raise Exception.Create('Definindo campos, arquivo nao encontrado '+pNomeArq);
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

    if (QtdLinhasIniciaisAExcluir > 0) and (QtdLinhasIniciaisAExcluir <= DefsSL.Count) then
    begin
      for i := 0 to QtdLinhasIniciaisAExcluir - 1 do
        DefsSL.Delete(0); // Exclui a primeira linha repetidamente
    end;

    DefCamposSL(DefsSL, pFDMemTable, pDBGrid);
  finally
    DefsSL.Free;
  end;
end;

procedure QueryToFDMemTable(pFDMemTable: TFDMemTable; pQ: TDataSet);
var
  I: integer;
begin
  for I := 0 to pFDMemTable.fieldcount - 1 do
  begin
    pFDMemTable.Fields[I].Value := pQ.Fields[I].Value;
  end;
end;

function RecordToVarArray(out pVarArray: variant; pQ: TDataSet): variant;
var
  iQtdCampos: integer;
  iFieldIndex: integer;
begin
  pVarArray := vaNull;

  Result := Assigned(pQ);
  if not Result then
    exit;

  Result := pQ.Active;
  if not Result then
    exit;

  iQtdCampos := pQ.FieldCount;

  Result := iQtdCampos > 0;
  if not Result then
    exit;

  pVarArray := VarArrayCreate([0, iQtdCampos - 1], varVariant);

  for iFieldIndex := 0 to iQtdCampos - 1 do
  begin
    pVarArray[iFieldIndex] := pQ.Fields[iFieldIndex].Value;
  end;
end;

end.
