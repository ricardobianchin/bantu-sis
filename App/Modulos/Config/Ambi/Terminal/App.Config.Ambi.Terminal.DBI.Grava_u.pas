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
    + ', ' + T.FieldByName('GAVETA_IMPR_NOME').AsString.QuotedString //

    + ', ' + T.FieldByName('BALANCA_MODO_USO_ID').AsInteger.ToString //
    + ', ' + T.FieldByName('BALANCA_ID').AsInteger.ToString //

    + ', ' + T.FieldByName('BARRAS_COD_INI').AsInteger.ToString //
    + ', ' + T.FieldByName('BARRAS_COD_TAM').AsInteger.ToString //

    + ', ' + T.FieldByName('IMPRESSORA_MODO_ENVIO_ID').AsInteger.ToString //
    + ', ' + T.FieldByName('IMPRESSORA_MODELO_ID').AsInteger.ToString //
    + ', ' + T.FieldByName('IMPRESSORA_NOME').AsString.QuotedString //
    + ', ' + T.FieldByName('IMPRESSORA_COLS_QTD').AsInteger.ToString //

    + ', ' + T.FieldByName('CUPOM_QTD_LINS_FINAL').AsInteger.ToString //

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
    + '  , T.GAVETA_IMPR_NOME'#13#10 //

    + '  , BMU.BALANCA_MODO_USO_ID'#13#10 //
    + '  , BMU.DESCR AS BALANCA_MODO_USO_DESCR'#13#10 //

    + '  , B.BALANCA_ID'#13#10 //
    + '  , TRIM(B.FABRICANTE || '' '' || B.MODELO) BALANCA_FABR_MODELO'#13#10 //

    + '  , T.BARRAS_COD_INI'#13#10 //
    + '  , T.BARRAS_COD_TAM'#13#10 //

    + '  , IME.IMPRESSORA_MODO_ENVIO_ID'#13#10 //
    + '  , IME.DESCR IMPRESSORA_MODO_ENVIO_DESCR'#13#10 //

    + '  , IM.IMPRESSORA_MODELO_ID'#13#10 //
    + '  , IM.DESCR IMPRESSORA_MODELO_DESCR'#13#10 //
    + '  , T.IMPRESSORA_NOME'#13#10 //
    + '  , T.IMPRESSORA_COLS_QTD'#13#10 //

    + '  , T.CUPOM_QTD_LINS_FINAL'#13#10 //

    + '  , T.SEMPRE_OFFLINE'#13#10 //
    + '  , T.ATIVO'#13#10 //

    + 'FROM TERMINAL T'#13#10 //

    + 'JOIN BALANCA_MODO_USO BMU ON'#13#10 //
    + 'T.BALANCA_MODO_USO_ID = BMU.BALANCA_MODO_USO_ID'#13#10 //

    + 'JOIN BALANCA B ON'#13#10 //
    + 'T.BALANCA_ID = B.BALANCA_ID'#13#10 //

    + 'JOIN IMPRESSORA_MODO_ENVIO IME ON'#13#10 //
    + 'IME.IMPRESSORA_MODO_ENVIO_ID = T.IMPRESSORA_MODO_ENVIO_ID'#13#10 //

    + 'JOIN IMPRESSORA_MODELO IM ON'#13#10 //
    + 'IM.IMPRESSORA_MODELO_ID = T.IMPRESSORA_MODELO_ID'#13#10 //

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
