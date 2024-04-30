unit Sis.DB.DataSet.Utils;

interface

uses
  FireDAC.Comp.Client, Vcl.DBGrids, Data.DB;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid);

procedure QueryToFDMemTable(pFDMemTable: TFDMemTable; pQ: TDataSet);

implementation

uses System.Classes, Sis.DB.FDDataSetManager, Sis.DB.Factory;

procedure DefCamposSL(DefsSL: TStringList; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid);
var
  oFDDataSetManager: IFDDataSetManager;
begin
  oFDDataSetManager := FDDataSetManagerCreate(pFDMemTable, pDBGrid);
  oFDDataSetManager.DefinaCampos(DefsSL);
end;

procedure DefCamposArq(pNomeArq: string; pFDMemTable: TFDMemTable;
  pDBGrid: TDBGrid);
var
  DefsSL: TStringList;
begin
  DefsSL := TStringList.Create;
  try
    DefsSL.LoadFromFile(pNomeArq);
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


end.
