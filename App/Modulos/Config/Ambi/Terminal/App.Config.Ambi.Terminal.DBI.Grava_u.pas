unit App.Config.Ambi.Terminal.DBI.Grava_u;

interface

uses Sis.DBI_u, App.Config.Ambi.Terminal.DBI, FireDAC.Comp.Client, Data.DB;

type
  TConfigAmbiTerminalDBIGrava = class(TDBI, IConfigAmbiTerminalDBI)
  private
    FDMemTable: TFDMemTable;
    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
  protected
    function GetSqlForEach(pValues: Variant): string; override;

  public
    procedure PreenchaDataSet(pDMemTable: TFDMemTable);
    procedure Inserir(pDMemTable: TFDMemTable);
    procedure Alterar(pDMemTable: TFDMemTable);

  end;

implementation

uses Sis.DB.DataSet.Utils, System.SysUtils, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

{ TConfigAmbiTerminalDBIGrava }

procedure TConfigAmbiTerminalDBIGrava.Alterar(pDMemTable: TFDMemTable);
var
  sSql: string;
  sMens: string;
begin
  sSql := DataSetToSqlUpdate(pDMemTable, 'TERMINAL', [0]);
{$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
{$ENDIF}
  ExecuteSQL(sSql, sMens);
end;

function TConfigAmbiTerminalDBIGrava.GetSqlForEach(pValues: Variant): string;
begin
  Result := 'SELECT'#13#10 //

    + '  T.TERMINAL_ID'#13#10 //
    + '  , T.APELIDO'#13#10 //
    + '  , T.NOME_NA_REDE'#13#10 //
    + '  , T.IP'#13#10 //
    + '  , T.NF_SERIE'#13#10 //
    + '  , T.LETRA_DO_DRIVE'#13#10 //
    + '  , T.GAVETA_TEM'#13#10 //
    + '  , T.BALANCA_MODO_ID'#13#10 //
    + '  , T.BALANCA_ID'#13#10 //
    + '  , BM.DESCR AS BALANCA_DESCR'#13#10 //
    + '  , T.BARRAS_COD_INI'#13#10 //
    + '  , T.BARRAS_COD_TAM'#13#10 //
    + '  , T.CUPOM_NLINS_FINAL'#13#10 //
    + '  , T.SEMPRE_OFFLINE'#13#10 //
    + '  , T.ATIVO'#13#10 //

    + 'FROM TERMINAL T'#13#10 //

    + 'JOIN BALANCA_MODO BM ON'#13#10 //
    + 'T.BALANCA_MODO_ID = BM.BALANCA_MODO_ID'#13#10 //

    + 'JOIN BALANCA B ON'#13#10 //
    + 'T.BALANCA_ID = B.BALANCA_ID'#13#10 //

    + 'WHERE T.TERMINAL_ID > 0'#13#10 //
    + 'ORDER BY T.TERMINAL_ID'#13#10 //
    ;
end;

procedure TConfigAmbiTerminalDBIGrava.Inserir(pDMemTable: TFDMemTable);
var
  sSql: string;
  sMens: string;
begin
  sSql := DataSetToSqlInsertInto(pDMemTable, 'TERMINAL');
{$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
{$ENDIF}
  ExecuteSQL(sSql, sMens);
end;

procedure TConfigAmbiTerminalDBIGrava.LeRegEInsere(q: TDataSet;
  pRecNo: integer);
begin
  if pRecNo = -1 then
    exit;

  FDMemTable.Append;
  RecordToFDMemTable(q, FDMemTable);
  (*
    FDMemTable.Fields[0 { TERMINAL_ID } ].AsInteger :=
    FDMemTable.Fields[1 { APELIDO } ].AsString :=
    FDMemTable.Fields[2 { NOME_NA_REDE } ].AsString :=
    FDMemTable.Fields[3 { IP } ].AsString :=
    FDMemTable.Fields[4 { NF_SERIE } ].AsInteger :=
    FDMemTable.Fields[5 { LETRA_DO_DRIVE } ].AsString :=
    FDMemTable.Fields[6 { GAVETA_TEM } ].AsBoolean :=
    FDMemTable.Fields[7 { BALANCA_MODO_ID } ]].AsInteger :=
    FDMemTable.Fields[8 { BALANCA_ID } ]].AsInteger :=
    FDMemTable.Fields[9 { BALANCA_DESCR } ].AsString :=
    FDMemTable.Fields[10 { BARRAS_COD_INI } ].AsInteger :=
    FDMemTable.Fields[11 { BARRAS_COD_TAM } ].AsInteger :=
    FDMemTable.Fields[12 { CUPOM_NLINS_FINAL } ].AsInteger :=
    FDMemTable.Fields[13 { SEMPRE_OFFLINE } ].AsBoolean :=
    FDMemTable.Fields[14 { ATIVO } ].AsBoolean :=
  *)
  FDMemTable.Post;

end;

procedure TConfigAmbiTerminalDBIGrava.PreenchaDataSet(pDMemTable: TFDMemTable);
var
  sSql: string;
begin
  FDMemTable := pDMemTable;
  FDMemTable.EmptyDataSet;
  ForEach(varNull, LeRegEInsere);
end;

end.
