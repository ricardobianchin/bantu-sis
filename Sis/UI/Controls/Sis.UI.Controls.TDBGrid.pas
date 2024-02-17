unit Sis.UI.Controls.TDBGrid;

interface

uses Vcl.DBGrids;

function DBGridGetPrimColumnVisible(pDBGrid: TDBGrid): integer;
procedure DBGridPosicioneColumnVisible(pDBGrid: TDBGrid);

implementation

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
  i: integer;
begin
  i := DBGridGetPrimColumnVisible(pDBGrid);
  if i = -1 then
    exit;

  pDBGrid.SelectedIndex := i;
end;

end.
