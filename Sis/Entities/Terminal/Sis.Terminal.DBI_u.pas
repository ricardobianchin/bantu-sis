unit Sis.Terminal.DBI_u;

interface

uses Sis.DBI_u, Sis.Terminal.DBI, Sis.Terminal, Sis.DB.DBTypes, System.Classes,
  Sis.TerminalList, System.Variants, FireDAC.Comp.Client, Data.DB,
  Sis.Config.SisConfig;

type
  TTerminalDBI = class(TDBI, ITerminalDBI)
  private
    /// <summary>
    /// Transfers data from a dataset current record to a terminal interface.
    /// </summary>
    /// <param name="Q">The dataset containing the data to be transferred.</param>
    /// <param name="pTerminal">The terminal interface where the data will be transferred to.</param>
    /// <param name="pPastaDados">The data folder path.</param>
    /// <param name="pAtividadeEconDescr">The activity description.</param>

    function GetSqlTerminal(pTerminalId: SmallInt): string;
    function GetSQLTerminalGar(pTerminal: ITerminal): string;
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
    function DBToList(pTerminalList: ITerminalList;
      pPastaDados, pAtividadeEconDescr: string;
      pSomenteMaquina: string = ''): Boolean;

    procedure ListToDB(pTerminalList: ITerminalList; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure TerminalToDB(pTerminal: ITerminal; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt;
      pDBConnection: IDBConnection = nil);

    procedure DataSetToDB(pDataSet: TDataSet; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DBToDMemTable(pDMemTable: TFDMemTable);

    procedure TermDBsParaList(pTerminalList: ITerminalList;
      pSisConfig: ISisConfig; pPastaDados: string);

    procedure ListToDBs(pTerminalList: ITerminalList; pSisConfig: ISisConfig;
      pLogLojaId: SmallInt; pLogUsuarioId: integer);
  end;

implementation

uses System.SysUtils, Sis.Entities.Types, Sis.Types.Bool_u, Sis.Win.Utils_u,
  Sis.Terminal.Factory_u, Sis.DB.DataSet.Utils, Sis.Types.Variants,
  Sis.Terminal.Utils_u, Sis.UI.IO.Input.Bool, Sis.DB.Factory;

{ TTerminalDBI }

procedure TTerminalDBI.TermDBsParaList(pTerminalList: ITerminalList;
  pSisConfig: ISisConfig; pPastaDados: string);
var
  i: integer;
  TermDBConnection: IDBConnection;
  oDBConnectionParams: TDBConnectionParams;
  sSql: string;
  oTerminal: ITerminal;
  q: TDataSet;
begin
    for i := 0 to pTerminalList.Count - 1 do
    begin
      oTerminal := pTerminalList[i];
      oDBConnectionParams.Server := oTerminal.NomeNaRede;
      oDBConnectionParams.Arq := oTerminal.LocalArqDados;
      oDBConnectionParams.Database := oTerminal.Database;
      if not FileExists(oTerminal.LocalArqDados) then
        continue;

      TermDBConnection := DBConnectionCreate('TerminalGetConn', pSisConfig,
        oDBConnectionParams, nil, nil);
      if not TermDBConnection.Abrir then
        continue;
      try
        sSql := GetSqlTerminal(oTerminal.TerminalId);
        // {$IFDEF DEBUG}
        // CopyTextToClipboard(sSql);
        // {$ENDIF}
        TermDBConnection.QueryDataSet(sSql, q);
        DataSetToTerminal(q, oTerminal, '', '');
        q.free;
      finally
        TermDBConnection.Fechar;
      end;
    end;
end;

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

    + ', ' + T.FieldByName('BALANCA_PORTA').AsInteger.ToString
  // BALANCA_PORTA
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
    + 'AND T.ATIVO'#13#10 //
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

function TTerminalDBI.GetSqlTerminal(pTerminalId: SmallInt): string;
var
  sTipoDeParametro: string;
  sValor: string;
begin
  Result := 'SELECT'#13#10
  //

    + '  T.TERMINAL_ID'#13#10 //

    + '  , T.APELIDO'#13#10 //
    + '  , T.NOME_NA_REDE'#13#10 //
    + '  , T.IP'#13#10 //
    + '  , T.LETRA_DO_DRIVE'#13#10 // || '':'' LETRADRIVE'#13#10 //

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

    + 'WHERE T.TERMINAL_ID = ' + pTerminalId.ToString + #13#10 //
    + 'AND T.ATIVO'#13#10 //
    ;
end;

function TTerminalDBI.GetSQLTerminalGar(pTerminal: ITerminal): string;
begin
  {
    propriedades de ITerminal.
    serao usadas para compor a string result

    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    property Apelido: string read GetApelido write SetApelido;
    property NomeNaRede: string read GetNomeNaRede write SetNomeNaRede;
    property IP: string read GetIP write SetIP;
    property LetraDoDrive: string read GetLetraDoDrive write SetLetraDoDrive;

    property NFSerie: smallint read GetNFSerie write SetNFSerie;

    property GavetaTem: Boolean read GetGavetaTem write SetGavetaTem;
    property GavetaComando: string read GetGavetaComando write SetGavetaComando;
    property GavetaImprNome: string read GetGavetaImprNome write SetGavetaImprNome;

    property BalancaModoUsoId: smallint read GetBalancaModoUsoId write SetBalancaModoUsoId;
    property BalancaModoUsoDescr: string read GetBalancaModoUsoDescr write SetBalancaModoUsoDescr;

    property BalancaId: smallint read GetBalancaId write SetBalancaId;
    property BalancaFabrModelo: string read GetBalancaFabrModelo write SetBalancaFabrModelo;

    property BarCodigoIni: smallint read GetBarCodigoIni write SetBarCodigoIni;
    property BarCodigoTam: smallint read GetBarCodigoTam write SetBarCodigoTam;

    property ImpressoraModoEnvioId: smallint read GetImpressoraModoEnvioId write SetImpressoraModoEnvioId;
    property ImpressoraModoEnvioDescr: string read GetImpressoraModoEnvioDescr write SetImpressoraModoEnvioDescr;

    property ImpressoraModeloId: smallint read GetImpressoraModeloId write SetImpressoraModeloId;
    property ImpressoraModeloDescr: string read GetImpressoraModeloDescr write SetImpressoraModeloDescr;
    property ImpressoraNome: string read GetImpressoraNome write SetImpressoraNome;
    property ImpressoraColsQtd: smallint read GetImpressoraColsQtd write SetImpressoraColsQtd;

    property CupomQtdLinsFinal: smallint read GetCupomQtdLinsFinal write SetCupomQtdLinsFinal;

    property SempreOffLine: Boolean read GetSempreOffLine write SetSempreOffLine;
    property Ativo: Boolean read GetAtivo write SetAtivo;

    property BALANCA_PORTA: smallint read GetBALANCA_PORTA write SetBALANCA_PORTA;
    property BALANCA_BAUDRATE: smallint read GetBALANCA_BAUDRATE write SetBALANCA_BAUDRATE;
    property BALANCA_DATABITS: smallint read GetBALANCA_DATABITS write SetBALANCA_DATABITS;
    property BALANCA_PARIDADE: smallint read GetBALANCA_PARIDADE write SetBALANCA_PARIDADE;
    property BALANCA_STOPBITS: smallint read GetBALANCA_STOPBITS write SetBALANCA_STOPBITS;
    property BALANCA_HANDSHAKING: smallint read GetBALANCA_HANDSHAKING write SetBALANCA_HANDSHAKING;

    property LocalArqDados: string read GetLocalArqDados write SetLocalArqDados;
    property Database: string read GetDatabase write SetDatabase;


    property AsText: string read GetAsText;
    property IdentStr: string read GetIdentStr;

    property CriticalSections: ICriticalSections read GetCriticalSections;

  }
  Result := //
    'UPDATE OR INSERT INTO TERMINAL ('#13#10 //
    + '  TERMINAL_ID,'#13#10 //
    + '  APELIDO,'#13#10 //
    + '  NOME_NA_REDE,'#13#10 //
    + '  IP,'#13#10 //
    + '  LETRA_DO_DRIVE,'#13#10 //
    + '  NF_SERIE,'#13#10 //
    + '  GAVETA_TEM,'#13#10 //
    + '  GAVETA_COMANDO,'#13#10 //
    + '  GAVETA_IMPR_NOME,'#13#10 //
    + '  BALANCA_MODO_USO_ID,'#13#10 //
    + '  BALANCA_ID,'#13#10 //
    + '  BARRAS_COD_INI,'#13#10 //
    + '  BARRAS_COD_TAM,'#13#10 //
    + '  IMPRESSORA_MODO_ENVIO_ID,'#13#10 //
    + '  IMPRESSORA_MODELO_ID,'#13#10 //
    + '  IMPRESSORA_NOME,'#13#10 //
    + '  IMPRESSORA_COLS_QTD,'#13#10 //
    + '  CUPOM_QTD_LINS_FINAL,'#13#10 //
    + '  SEMPRE_OFFLINE,'#13#10 //
    + '  ATIVO,'#13#10 //
    + '  BALANCA_PORTA,'#13#10 //
    + '  BALANCA_BAUDRATE,'#13#10 //
    + '  BALANCA_DATABITS,'#13#10 //
    + '  BALANCA_PARIDADE,'#13#10 //
    + '  BALANCA_STOPBITS,'#13#10 //
    + '  BALANCA_HANDSHAKING'#13#10 //
    + '  VALUES ('#13#10 //
    + pTerminal.TerminalId.ToString + ', -- TERMINAL_ID'#13#10 +
    QuotedStr(pTerminal.Apelido) + ', -- APELIDO'#13#10 +
    QuotedStr(pTerminal.NomeNaRede) + ', -- NOME_NA_REDE'#13#10 +
    QuotedStr(pTerminal.IP) + ', -- IP'#13#10 +
    QuotedStr(pTerminal.LetraDoDrive) + ', -- LETRA_DO_DRIVE'#13#10 +
    pTerminal.NFSerie.ToString + ', -- NF_SERIE'#13#10 +
    BooleanToStrSQL(pTerminal.GavetaTem) + ', -- GAVETA_TEM'#13#10 +
    QuotedStr(pTerminal.GavetaComando) + ', -- GAVETA_COMANDO'#13#10 +
    QuotedStr(pTerminal.GavetaImprNome) + ', -- GAVETA_IMPR_NOME'#13#10 +
    pTerminal.BalancaModoUsoId.ToString + ', -- BALANCA_MODO_USO_ID'#13#10 +
    pTerminal.BalancaId.ToString + ', -- BALANCA_ID'#13#10 +
    pTerminal.BarCodigoIni.ToString + ', -- BARRAS_COD_INI'#13#10 +
    pTerminal.BarCodigoTam.ToString + ', -- BARRAS_COD_TAM'#13#10 +
    pTerminal.ImpressoraModoEnvioId.ToString +
    ', -- IMPRESSORA_MODO_ENVIO_ID'#13#10 +
    pTerminal.ImpressoraModeloId.ToString + ', -- IMPRESSORA_MODELO_ID'#13#10 +
    QuotedStr(pTerminal.ImpressoraNome) + ', -- IMPRESSORA_NOME'#13#10 +
    pTerminal.ImpressoraColsQtd.ToString + ', -- IMPRESSORA_COLS_QTD'#13#10 +
    pTerminal.CupomQtdLinsFinal.ToString + ', -- CUPOM_QTD_LINS_FINAL'#13#10 +
    BooleanToStrSQL(pTerminal.SempreOffLine) + ', -- SEMPRE_OFFLINE'#13#10 +
    BooleanToStrSQL(pTerminal.Ativo) + ', -- ATIVO'#13#10 +
    pTerminal.Balanca_Porta.ToString + ', -- BALANCA_PORTA'#13#10 +
    pTerminal.Balanca_Baudrate.ToString + ', -- BALANCA_BAUDRATE'#13#10 +
    pTerminal.Balanca_Databits.ToString + ', -- BALANCA_DATABITS'#13#10 +
    pTerminal.Balanca_Paridade.ToString + ', -- BALANCA_PARIDADE'#13#10 +
    pTerminal.Balanca_Stopbits.ToString + ', -- BALANCA_STOPBITS'#13#10 +
    pTerminal.Balanca_Handshaking.ToString + ', -- BALANCA_HANDSHAKING'#13#10 +
    ' ) MATCHING (TERMINAL_ID);'#13#10 // '
    ;
end;

procedure TTerminalDBI.ListToDB(pTerminalList: ITerminalList;
  pLogLojaId: SmallInt; pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);
var
  sDel: string;
  i: integer;
begin
  for i := 0 to pTerminalList.Count - 1 do
  begin
    TerminalToDB(pTerminalList[i], pLogLojaId, pLogUsuarioId,
      pLogMachineIdentId);
  end;
end;

procedure TTerminalDBI.ListToDBs(pTerminalList: ITerminalList;
  pSisConfig: ISisConfig; pLogLojaId: SmallInt; pLogUsuarioId: integer);
var
  i: integer;
  oDBConnection: IDBConnection;
  oDBConnectionParams: TDBConnectionParams;
  oTerminal: ITerminal;
  oDBExec: IDBExec;
begin
  for i := 0 to pTerminalList.Count - 1 do
  begin
    oTerminal := pTerminalList[i];
    oDBConnectionParams.Server := oTerminal.NomeNaRede;
    oDBConnectionParams.Arq := oTerminal.LocalArqDados;
    oDBConnectionParams.Database := oTerminal.Database;

    oDBConnection := DBConnectionCreate('TerminalSetConn', pSisConfig,
      oDBConnectionParams, nil, nil);
    oDBConnection.Abrir;
    try
      TerminalToDB(oTerminal, pLogLojaId, pLogUsuarioId,
        pSisConfig.LocalMachineId.IdentId, oDBConnection);
    finally
      oDBConnection.Fechar;
    end;
  end;
end;

procedure TTerminalDBI.DBToDMemTable(pDMemTable: TFDMemTable);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := GetSqlForEach(Null);
  pDMemTable.EmptyDataSet;
  DBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      pDMemTable.Append;
      RecordToFDMemTable(q, pDMemTable);
      pDMemTable.Post;
      q.Next;
    end;
  finally
    q.free;
  end;
end;

function TTerminalDBI.DBToList(pTerminalList: ITerminalList;
  pPastaDados, pAtividadeEconDescr: string; pSomenteMaquina: string): Boolean;
var
  sSql: string;
  q: TDataSet;
  iTerminalId: SmallInt;
  oTerminal: ITerminal;
  vValues: Variant;
begin
  Result := DBConnection.Abrir;
  if not Result then
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

    DBConnection.QueryDataSet(sSql, q);
    while not q.Eof do
    begin
      iTerminalId := q.fields[0].asinteger;
      oTerminal := pTerminalList.TerminalIdToTerminal(iTerminalId);
      if oTerminal = nil then
      begin
        oTerminal := TerminalCreate;
        pTerminalList.Add(oTerminal);
        DataSetToTerminal(q, oTerminal, pPastaDados, pAtividadeEconDescr);
      end;

      q.Next;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TTerminalDBI.TerminalToDB(pTerminal: ITerminal; pLogLojaId: SmallInt;
  pLogUsuarioId: integer; pLogMachineIdentId: SmallInt;
  pDBConnection: IDBConnection);
var
  sSql: string;
  T: ITerminal;
  oDBConnection: IDBConnection;
begin
  if pDBConnection = nil then
    oDBConnection := DBConnection
  else
    oDBConnection := pDBConnection;

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

    + ', ' + T.Balanca_Porta.ToString // BALANCA_PORTA
    + ', ' + T.Balanca_Baudrate.ToString // BALANCA_BAUDRATE
    + ', ' + T.Balanca_Databits.ToString // BALANCA_DATABITS
    + ', ' + T.Balanca_Paridade.ToString // BALANCA_PARIDADE
    + ', ' + T.Balanca_Stopbits.ToString // BALANCA_STOPBITS
    + ', ' + T.Balanca_Handshaking.ToString // BALANCA_HANDSHAKING

    + ', ' + pLogLojaId.ToString // LOG_LOJA_ID
    + ', ' + pLogUsuarioId.ToString // LOG_PESSOA_ID
    + ', ' + pLogMachineIdentId.ToString // MACHINE_ID
    + ');'; //

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  oDBConnection.ExecuteSQL(sSql);
end;

end.
