unit App.Config.Ambi.Terminal.DBI.Grava_u;

interface

uses Sis.DBI_u, App.Config.Ambi.Terminal.DBI, FireDAC.Comp.Client, Data.DB,
  Sis.Usuario, App.AppObj, Sis.DB.DBTypes;

type
  TConfigAmbiTerminalDBIGrava = class(TDBI, IConfigAmbiTerminalDBI)
  private
    FDMemTable: TFDMemTable;
    FUsuarioAdmin: IUsuario;
    FAppObj: IAppObj;

    procedure LeRegEInsere(q: TDataSet; pRecNo: integer);
    procedure Garantir(pDMemTable: TFDMemTable);
  protected
    function GetSqlForEach(pValues: Variant): string; override;

  public
    procedure PreenchaDataSet(pDMemTable: TFDMemTable);
    procedure Inserir(pDMemTable: TFDMemTable);
    procedure Alterar(pDMemTable: TFDMemTable);

    constructor Create(pDBConnection: IDBConnection; pUsuarioAdmin: IUsuario;
      pAppObj: IAppObj);
  end;

implementation

uses Sis.DB.DataSet.Utils, System.SysUtils, Sis.DB.SqlUtils_u,
  Sis.Win.Utils_u, Sis.Types.Bool_u;

{ TConfigAmbiTerminalDBIGrava }

procedure TConfigAmbiTerminalDBIGrava.Alterar(pDMemTable: TFDMemTable);
begin
  Garantir(pDMemTable);
end;

constructor TConfigAmbiTerminalDBIGrava.Create(pDBConnection: IDBConnection;
  pUsuarioAdmin: IUsuario; pAppObj: IAppObj);
begin
  inherited Create(pDBConnection);
  FUsuarioAdmin := pUsuarioAdmin;
  FAppObj := pAppObj;
end;

procedure TConfigAmbiTerminalDBIGrava.Garantir(pDMemTable: TFDMemTable);
var
  sSql: string;
  sMens: string;
  T: TFDMemTable;
  sLetraDrive: string;
begin
  T := pDMemTable;

  sLetraDrive := T.FieldByName('LETRA_DO_DRIVE').AsString;
  if sLetraDrive = '' then
    sLetraDrive := 'C'
  else
    sLetraDrive := sLetraDrive[1];

  sSql := //
    'EXECUTE PROCEDURE TERMINAL_PA.GARANTIR (' //

    + T.FieldByName('TERMINAL_ID').AsInteger.ToString //

    + ', ' + T.FieldByName('APELIDO').AsString.QuotedString //
    + ', ' + T.FieldByName('NOME_NA_REDE').AsString.QuotedString //
    + ', ' + T.FieldByName('IP').AsString.QuotedString //

    + ', ' + sLetraDrive.QuotedString //

    + ', ' + T.FieldByName('NF_SERIE').AsInteger.ToString //

    + ', ' + BooleanToStrSQL(T.FieldByName('GAVETA_TEM').AsBoolean) //
    + ', ' + T.FieldByName('GAVETA_COMANDO').AsString.QuotedString //

    + ', ' + T.FieldByName('BALANCA_MODO_ID').AsInteger.ToString //
    + ', ' + T.FieldByName('BALANCA_ID').AsInteger.ToString //

    + ', ' + T.FieldByName('BARRAS_COD_INI').AsInteger.ToString //
    + ', ' + T.FieldByName('BARRAS_COD_TAM').AsInteger.ToString //

    + ', ' + T.FieldByName('IMPRESSORA_MODO_ID').AsInteger.ToString //
    + ', ' + T.FieldByName('CUPOM_NLINS_FINAL').AsInteger.ToString //

    + ', ' + BooleanToStrSQL(T.FieldByName('SEMPRE_OFFLINE').AsBoolean) //
    + ', ' + BooleanToStrSQL(T.FieldByName('ATIVO').AsBoolean) //

    + ', ' + FAppObj.Loja.Id.ToString // LOG_LOJA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FAppObj.SisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID

    + ');'; //

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  ExecuteSQL(sSql, sMens);
end;

function TConfigAmbiTerminalDBIGrava.GetSqlForEach(pValues: Variant): string;
begin
  Result := 'SELECT'#13#10 //

    + '  T.TERMINAL_ID'#13#10 //

    + '  , T.APELIDO'#13#10 //
    + '  , T.NOME_NA_REDE'#13#10 //
    + '  , T.IP'#13#10 //
    + '  , T.LETRA_DO_DRIVE || '':'' LETRADRIVE'#13#10 //

    + '  , T.NF_SERIE'#13#10 //

    + '  , T.GAVETA_TEM'#13#10 //
    + '  , T.GAVETA_COMANDO'#13#10 //

    + '  , T.BALANCA_MODO_ID'#13#10 //
    + '  , T.BALANCA_ID'#13#10 //
    + '  , BM.DESCR AS BALANCA_DESCR'#13#10 //

    + '  , T.BARRAS_COD_INI'#13#10 //
    + '  , T.BARRAS_COD_TAM'#13#10 //

    + '  , T.IMPRESSORA_MODO_ID'#13#10 //
    + '  , IM.DESCR IMPRESSORA_MODO_DESCR'#13#10 //
    + '  , T.CUPOM_NLINS_FINAL'#13#10 //

    + '  , T.SEMPRE_OFFLINE'#13#10 //
    + '  , T.ATIVO'#13#10 //

    + 'FROM TERMINAL T'#13#10 //

    + 'JOIN BALANCA_MODO BM ON'#13#10 //
    + 'T.BALANCA_MODO_ID = BM.BALANCA_MODO_ID'#13#10 //

    + 'JOIN BALANCA B ON'#13#10 //
    + 'T.BALANCA_ID = B.BALANCA_ID'#13#10 //

    + 'JOIN IMPRESSORA_MODO IM ON'#13#10 //
    + 'IM.IMPRESSORA_MODO_ID = T.IMPRESSORA_MODO_ID'#13#10 //

    + 'WHERE T.TERMINAL_ID > 0'#13#10 //
    + 'ORDER BY T.TERMINAL_ID'#13#10 //
    ;
end;

procedure TConfigAmbiTerminalDBIGrava.Inserir(pDMemTable: TFDMemTable);
begin
  Garantir(pDMemTable);
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
