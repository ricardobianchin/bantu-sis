unit Sis.UI.Controls.TDBGrid;

interface

uses Vcl.DBGrids;

function DBGridGetPrimColumnVisible(pDBGrid: TDBGrid): integer;
procedure DBGridPosicioneColumnVisible(pDBGrid: TDBGrid);
function DBGridColumnByFieldName(pGrid: TDBGrid; const pFieldName: String): TColumn;

implementation

uses System.SysUtils;

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

end.
