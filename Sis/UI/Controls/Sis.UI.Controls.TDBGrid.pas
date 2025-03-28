unit Sis.UI.Controls.TDBGrid;

interface

uses Vcl.DBGrids;

function DBGridGetPrimColumnVisible(pDBGrid: TDBGrid): integer;
procedure DBGridPosicioneColumnVisible(pDBGrid: TDBGrid);
function DBGridColumnByFieldName(pGrid: TDBGrid; const pFieldName: String): TColumn;
function GetTextoSelecionado(pDBGrid: TDBGrid): string;
procedure CopyTextoSelecionado(pDBGrid: TDBGrid);
procedure DBGridColumnWidthsGet(pDBGrid: TDBGrid; out pLargs: string);

implementation

uses System.SysUtils, Data.DB, Sis.Win.Utils_u;

function DBGridGetPrimColumnVisible(pDBGrid: TDBGrid): integer;
var
  I: integer;
  c: TColumn;
begin
  Result := -1;
  for I := 0 to pDBGrid.Columns.Count - 1 do
  begin
    c := pDBGrid.Columns[I];
    if c.Visible then
    begin
      Result := I;
      break;
    end;
  end;
end;

procedure DBGridPosicioneColumnVisible(pDBGrid: TDBGrid);
var
  I: integer;
begin
  I := DBGridGetPrimColumnVisible(pDBGrid);
  if I = -1 then
    exit;

  pDBGrid.SelectedIndex := I;
end;

function DBGridColumnByFieldName(pGrid: TDBGrid; const pFieldName: String): TColumn;
var
  I: integer;
begin
  Result := Nil;
  for I := 0 to pGrid.Columns.Count - 1 do
  begin
    if (pGrid.Columns[I].Field <> Nil) and
      (CompareText(pGrid.Columns[I].FieldName, pFieldName) = 0) then
    begin
      Result := pGrid.Columns[I];
      exit;
    end;
  end;
end;

function GetTextoSelecionado(pDBGrid: TDBGrid): string;
var
  oField: TField;
begin
  Result := '';

  oField := pDBGrid.SelectedField;
  if oField = nil then
    exit;

  Result := oField.AsString;
end;

procedure CopyTextoSelecionado(pDBGrid: TDBGrid);
var
  sValorCelula: string;
begin
  sValorCelula := GetTextoSelecionado(pDBGrid);
  if sValorCelula = '' then
    exit;

  SetClipboardText(sValorCelula);
end;

procedure DBGridColumnWidthsGet(pDBGrid: TDBGrid; out pLargs: string);
var
  i: Integer;
begin
  pLargs := '';
  for i := 0 to pDBGrid.Columns.Count - 1 do
  begin
    pLargs := pLargs + IntToStr(pDBGrid.Columns[i].Width);
    if i < pDBGrid.Columns.Count - 1 then
      pLargs := pLargs + ';';
  end;
end;

end.
