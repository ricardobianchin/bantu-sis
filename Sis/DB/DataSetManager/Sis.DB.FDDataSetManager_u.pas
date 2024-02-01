unit Sis.DB.FDDataSetManager_u;

interface

uses Sis.DB.FDDataSetManager, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFDDataSetManager = class(TInterfacedObject, IFDDataSetManager)
  private
    FFDMemTable: TFDMemTable;
    procedure ZereDefs;
  public
    procedure DefinaCampos(pDefStr: string);
    constructor Create(pFDMemTable: TFDMemTable);
  end;

implementation

uses System.Classes;

{ TFDDataSetManager }

constructor TFDDataSetManager.Create(pFDMemTable: TFDMemTable);
begin
  FFDMemTable := pFDMemTable;
end;

procedure TFDDataSetManager.DefinaCampos(pDefStr: string);
var
  SL: TStringList;
  sLinhaAtual: string;
  I: Integer;
begin
  ZereDefs;
  SL := TStringList.Create;
  try
    for I := 0 to SL.Count - 1 do
    begin
      sLinhaAtual := SL[I];

    end;
  finally
    SL.Free;
  end;
end;

procedure TFDDataSetManager.ZereDefs;
begin
  FFDMemTable.ClearFields;
end;

end.
