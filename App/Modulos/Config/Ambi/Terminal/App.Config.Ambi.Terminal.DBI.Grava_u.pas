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

uses Sis.DB.DataSet.Utils, System.SysUtils;

{ TConfigAmbiTerminalDBIGrava }

procedure TConfigAmbiTerminalDBIGrava.Alterar(pDMemTable: TFDMemTable);
var
  sSql: string;
  T: TFDMemTable;
begin
  T := pDMemTable;

  sSql := 'UPDATE TERMINAL SET'
    + 'APELIDO = ' + QuotedStr(T.FieldByName('APELIDO').AsString)
    + ', NOME_NA_REDE = ' + QuotedStr(T.FieldByName('NOME_NA_REDE').AsString)
    + ', ' +
          'IP = ' + QuotedStr(T.FieldByName('IP').AsString) + ', ' +
          'NF_SERIE = ' + QuotedStr(T.FieldByName('NF_SERIE').AsString) + ', ' +
          'LETRA_DO_DRIVE = ' + QuotedStr(T.FieldByName('LETRA_DO_DRIVE').AsString) + ', ' +
          'GAVETA_TEM = ' + QuotedStr(T.FieldByName('GAVETA_TEM').AsString) + ', ' +
          'BALANCA_MODO_ID = ' + QuotedStr(T.FieldByName('BALANCA_MODO_ID').AsString) + ', ' +
          'BALANCA_ID = ' + QuotedStr(T.FieldByName('BALANCA_ID').AsString) + ', ' +
          'BARRAS_COD_INI = ' + QuotedStr(T.FieldByName('BARRAS_COD_INI').AsString) + ', ' +
          'BARRAS_COD_TAM = ' + QuotedStr(T.FieldByName('BARRAS_COD_TAM').AsString) + ', ' +
          'CUPOM_NLINS_FINAL = ' + QuotedStr(T.FieldByName('CUPOM_NLINS_FINAL').AsString) + ', ' +
          'SEMPRE_OFFLINE = ' + QuotedStr(T.FieldByName('SEMPRE_OFFLINE').AsString) + ', ' +
          'ATIVO = ' + QuotedStr(T.FieldByName('ATIVO').AsString) +
          ' WHERE TERMINAL_ID = ' + QuotedStr(T.FieldByName('TERMINAL_ID').AsString);
  ExecuteSQL(sSql);
end;
end;

procedure TConfigAmbiTerminalDBIGrava.Excluir(pDMemTable: TFDMemTable);
begin

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
  T: TFDMemTable;
begin
  T := pDMemTable;
  sSql := 'INSERT INTO TERMINAL (' +
          'TERMINAL_ID, APELIDO, NOME_NA_REDE, IP, NF_SERIE, LETRA_DO_DRIVE, ' +
          'GAVETA_TEM, BALANCA_MODO_ID, BALANCA_ID, BARRAS_COD_INI, BARRAS_COD_TAM, ' +
          'CUPOM_NLINS_FINAL, SEMPRE_OFFLINE, ATIVO) VALUES (' +
          QuotedStr(pDMemTable.FieldByName('TERMINAL_ID').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('APELIDO').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('NOME_NA_REDE').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('IP').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('NF_SERIE').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('LETRA_DO_DRIVE').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('GAVETA_TEM').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('BALANCA_MODO_ID').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('BALANCA_ID').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('BARRAS_COD_INI').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('BARRAS_COD_TAM').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('CUPOM_NLINS_FINAL').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('SEMPRE_OFFLINE').AsString) + ', ' +
          QuotedStr(pDMemTable.FieldByName('ATIVO').AsString) + ')';
  ExecuteSQL(sSql);
end;
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
