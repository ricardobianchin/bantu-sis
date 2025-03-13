unit Sis.Terminal.DBI_u;

interface

uses Sis.DBI_u, Sis.Terminal.DBI, Sis.Terminal, Sis.DB.DBTypes, System.Classes,
  Sis.TerminalList, System.Variants, FireDAC.Comp.Client, Data.DB;

type
  TTerminalDBI = class(TDBI, ITerminalDBI)
  private
    /// <summary>
    /// Transfers data from a dataset current record to a terminal interface.
    /// </summary>
    /// <param name="Q">The dataset containing the data to be transferred.</param>
    /// <param name="pTerminal">The terminal interface where the data will be transferred to.</param>
    /// <param name="pPastaDados">The data folder path.</param>
    /// <param name="pAtivDescr">The activity description.</param>
  protected
    /// <summary>
    /// Gera o SQL query que poderá ser usada em métodos ForEachTerminal
    /// </summary>
    /// <param name="pValues">
    /// array de parametros a serem usados na sql query
    /// deve ser nulo ou formado por exatamente dois elementos
    ///
    /// se for nulo, o SQL query criado retornará todos os terminais
    ///
    /// se nao for nulo, os valores dos elementos devem ser:
    /// pValues[0] deve conter uma destas strings
    ///
    /// - NOME_NA_REDE = retornará só os terminais da máquina com este nome
    /// neste caso, pValues[1] conterá string com o nome na rede
    ///
    /// - IP = retornará só os terminais da máquina com este IP
    /// neste caso, pValues[1] conterá string com o IP da máquina
    ///
    /// - EXCETO = retornará todos os terminais,
    /// exceto o que tiver código estiver este ID.
    /// pValues[1] contem uma string com este id
    /// </param>
    /// <returns>A string representing the generated SQL query.</returns>
    function GetSqlForEach(pValues: Variant): string; override;
  public
    procedure DBToList(pTerminalList: ITerminalList;
      pPastaDados, pAtivDescr: string; pSomenteMaquina: string = '');

    procedure ListToDB(pTerminalList: ITerminalList; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure TerminalToDB(pTerminal: ITerminal; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DataSetToDB(pDataSet: TDataSet; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DBToDMemTable(pDMemTable: TFDMemTable);
  end;

implementation

uses System.SysUtils, Sis.Entities.Types, Sis.Types.Bool_u, Sis.Win.Utils_u,
  Sis.Terminal.Factory_u, Sis.DB.DataSet.Utils, Sis.Types.Variants,
  Sis.Terminal.Utils_u;

{ TTerminalDBI }

procedure TTerminalDBI.DataSetToDB(pDataSet: TDataSet; pLogLojaId: SmallInt;
  pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);
var
  sSql: string;
  sMens: string;
  T: TDataSet;
  sLetraDrive: string;
begin
  T := pDataSet;

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

    + ', ' + T.FieldByName('BALANCA_PORTA').AsInteger.ToString // BALANCA_PORTA
    + ', ' + T.FieldByName('BALANCA_BAUDRATE').AsInteger.ToString
  // BALANCA_BAUDRATE
    + ', ' + T.FieldByName('BALANCA_DATABITS').AsInteger.ToString
  // BALANCA_DATABITS
    + ', ' + T.FieldByName('BALANCA_PARIDADE').AsInteger.ToString
  // BALANCA_PARIDADE
    + ', ' + T.FieldByName('BALANCA_STOPBITS').AsInteger.ToString
  // BALANCA_STOPBITS
    + ', ' + T.FieldByName('BALANCA_HANDSHAKING').AsInteger.ToString
  // BALANCA_HANDSHAKING

    + ', ' + pLogLojaId.ToString // LOG_LOJA_ID
    + ', ' + pLogUsuarioId.ToString // LOG_PESSOA_ID
    + ', ' + pLogMachineIdentId.ToString // MACHINE_ID

    + ');'; //

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  ExecuteSQL(sSql, sMens);
end;

function TTerminalDBI.GetSqlForEach(pValues: Variant): string;
var
  sTipoDeParametro: string;
  sValor: string;
  // ve, vn: Boolean;
  vv: Boolean;
begin
  // if VarIsEmpty(pValues) or VarIsNull(pValues) then
  // ve := VarIsEmpty(pValues);
  // vn := VarIsNull(pValues);

  vv := VarArrayVazia(pValues);

  if vv then
  begin
    sTipoDeParametro := '';
    sValor := '';
  end
  else
  begin
    sTipoDeParametro := pValues[0];
    sValor := pValues[1];
  end;

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
    + '  , B.MODELO BALANCA_FABR_MODELO'#13#10 //

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

    + '  , T.BALANCA_PORTA'#13#10 //
    + '  , T.BALANCA_BAUDRATE'#13#10 //
    + '  , T.BALANCA_DATABITS'#13#10 //
    + '  , T.BALANCA_PARIDADE'#13#10 //
    + '  , T.BALANCA_STOPBITS'#13#10 //
    + '  , T.BALANCA_HANDSHAKING'#13#10 //

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
    ;

  if (sTipoDeParametro = 'NOME_NA_REDE') or (sTipoDeParametro = 'IP') then
    Result := Result //
      + 'AND (NOME_NA_REDE=' + sValor.QuotedString //
      + 'OR IP=' + sValor.QuotedString + ')'#13#10 //
  else if (sTipoDeParametro = 'EXCETO') then
    Result := Result //
      + 'AND (TERMINAL_ID <>' + sValor + #13#10 //
      ;

  Result := Result + 'ORDER BY TERMINAL_ID'#13#10; //
end;

procedure TTerminalDBI.ListToDB(pTerminalList: ITerminalList;
  pLogLojaId: SmallInt; pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);
var
  sDel: string;
  i: integer;
begin
  sDel := 'DELETE FROM TERMINAL where terminal_id > 0;';

  DBConnection.ExecuteSQL(sDel);

  for i := 0 to pTerminalList.Count - 1 do
  begin
    TerminalToDB(pTerminalList[i], pLogLojaId, pLogUsuarioId,
      pLogMachineIdentId);
  end;
end;

procedure TTerminalDBI.DBToDMemTable(pDMemTable: TFDMemTable);
var
  sSql: string;
  Q: TDataSet;
begin
  sSql := GetSqlForEach(Null);
  pDMemTable.EmptyDataSet;
  DBConnection.QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      pDMemTable.Append;
      RecordToFDMemTable(Q, pDMemTable);
      pDMemTable.Post;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

procedure TTerminalDBI.DBToList(pTerminalList: ITerminalList;
  pPastaDados, pAtivDescr: string; pSomenteMaquina: string);
var
  sSql: string;
  Q: TDataSet;
  oTerminal: ITerminal;
  vValues: Variant;
begin
  pTerminalList.Clear;
  if not DBConnection.Abrir then
    exit;
  try
    if pSomenteMaquina = '' then
      vValues := Null
    else
    begin
      vValues := VarArrayCreate([0, 1], varVariant);
      vValues[0] := 'NOME_NA_REDE';
      vValues[1] := pSomenteMaquina;
    end;

    sSql := GetSqlForEach(vValues);

    DBConnection.QueryDataSet(sSql, Q);
    while not Q.Eof do
    begin
      oTerminal := TerminalCreate;
      pTerminalList.Add(oTerminal);

      DataSetToTerminal(Q, oTerminal, pPastaDados, pAtivDescr);

      Q.Next;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TTerminalDBI.TerminalToDB(pTerminal: ITerminal; pLogLojaId: SmallInt;
  pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);
var
  sSql: string;
  T: ITerminal;
  sTmp: string;
begin
  sTmp := DBConnection.Nome;
  T := pTerminal;
  sSql := 'EXECUTE PROCEDURE TERMINAL_PA.GARANTIR (' //
    + T.TerminalId.ToString // TERMINAL_ID

    + ', ' + T.Apelido.QuotedString // APELIDO
    + ', ' + T.NomeNaRede.QuotedString // NOME_NA_REDE
    + ', ' + T.IP.QuotedString // IP
    + ', ' + T.LetraDoDrive.QuotedString // LETRA_DO_DRIVE

    + ', ' + T.NFSerie.ToString // NF_SERIE

    + ', ' + BooleanToStrSQL(T.GavetaTem) // GAVETA_TEM
    + ', ' + T.GavetaComando.QuotedString // GAVETA_COMANDO
    + ', ' + T.GavetaImprNome.QuotedString // GAVETA_IMPR_NOME

    + ', ' + T.BalancaModoUsoId.ToString // BALANCA_MODO_USO_ID
    + ', ' + T.BalancaId.ToString // BALANCA_ID

    + ', ' + T.BarCodigoIni.ToString // BARRAS_COD_INI
    + ', ' + T.BarCodigoTam.ToString // BARRAS_COD_TAM

    + ', ' + T.ImpressoraModoEnvioId.ToString // IMPRESSORA_MODO_ENVIO_ID
    + ', ' + T.ImpressoraModeloId.ToString // IMPRESSORA_MODELO_ID
    + ', ' + T.ImpressoraNome.QuotedString // GAVETA_IMPR_NOME
    + ', ' + T.ImpressoraColsQtd.ToString // IMPRESSORA_COLS_QTD

    + ', ' + T.CupomQtdLinsFinal.ToString // CUPOM_QTD_LINS_FINAL

    + ', ' + BooleanToStrSQL(T.SempreOffLine) // SEMPRE_OFFLINE
    + ', ' + BooleanToStrSQL(T.Ativo) // SEMPRE_OFFLINE

    + ', ' + T.BALANCA_PORTA.ToString // BALANCA_PORTA
    + ', ' + T.BALANCA_BAUDRATE.ToString // BALANCA_BAUDRATE
    + ', ' + T.BALANCA_DATABITS.ToString // BALANCA_DATABITS
    + ', ' + T.BALANCA_PARIDADE.ToString // BALANCA_PARIDADE
    + ', ' + T.BALANCA_STOPBITS.ToString // BALANCA_STOPBITS
    + ', ' + T.BALANCA_HANDSHAKING.ToString // BALANCA_HANDSHAKING

    + ', ' + pLogLojaId.ToString // LOG_LOJA_ID
    + ', ' + pLogUsuarioId.ToString // LOG_PESSOA_ID
    + ', ' + pLogMachineIdentId.ToString // MACHINE_ID
    + ');'; //

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  DBConnection.ExecuteSQL(sSql);
end;

end.
