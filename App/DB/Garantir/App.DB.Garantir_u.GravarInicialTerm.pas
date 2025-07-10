unit App.DB.Garantir_u.GravarInicialTerm;

interface

uses Sis.DB.DBTypes, Sis.Usuario, Sis.Loja, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, App.AppObj, Sis.Terminal, Sis.Entities.Types,
  Sis.Types.Bool_u;

procedure GravarInicialTerm(pTerminal: ITerminal;
  rDBConnectionParamsTerm: TDBConnectionParams; pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ISisLoja;
  pUsuarioAdmin: IUsuario);

implementation

uses Sis.DB.Factory, System.SysUtils, Sis.Threads.Crit.FixedCriticalSection_u,
  Sis.Win.Utils_u;

var
  DBConnectionTerm: IDBConnection;
  DBExecScript: IDBExecScript;
  FixedCriticalSection: TFixedCriticalSection;

procedure GarantirAmbi(pLojaId, pTerminalId: SmallInt);
var
  sSql: string;
begin
  sSql := //
    'UPDATE AMBIENTE_SIS SET'#13#10 +//
    'LOJA_ID = ' + IntToStr(pLojaId) + ','#13#10 +//
    'TERMINAL_ID = ' + IntToStr(pTerminalId) + #13#10 +//
    ';';

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  DBExecScript.PegueComando(sSql);
end;

procedure GarantirLoja(pLoja: ISisLoja);
var
  sSql: string;
begin
  sSql := 'UPDATE OR INSERT INTO LOJA'#13#10 //
    + '(LOJA_ID, APELIDO, SELECIONADO)'#13#10 //
    + 'VALUES ' //
    + '(' //
    + pLoja.Id.ToString + ', ' //
    + QuotedStr(pLoja.Descr) + ', ' //
    + 'TRUE' //
    + ')'#13#10 //
    + 'MATCHING (LOJA_ID);';

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  DBExecScript.PegueComando(sSql);
end;

procedure GarantirTerminal(pTerminal: ITerminal);
var
  sSql: string;
  T: ITerminal;
begin
  T := pTerminal;
  sSql := 'UPDATE OR INSERT INTO TERMINAL'#13#10 //
    + '('#13#10 //
    + 'TERMINAL_ID'#13#10 //

    + ', APELIDO'#13#10 //
    + ', NOME_NA_REDE'#13#10 //
    + ', IP'#13#10 //
    + ', LETRA_DO_DRIVE'#13#10 //

    + ', NF_SERIE'#13#10 //

    + ', GAVETA_TEM'#13#10 //
    + ', GAVETA_COMANDO'#13#10 //
    + ', GAVETA_IMPR_NOME'#13#10 //

    + ', BALANCA_MODO_USO_ID'#13#10 //
    + ', BALANCA_ID'#13#10 //

    + ', BARRAS_COD_INI'#13#10 //
    + ', BARRAS_COD_TAM'#13#10 //

    + ', IMPRESSORA_MODO_ENVIO_ID'#13#10 //
    + ', IMPRESSORA_MODELO_ID'#13#10 //
    + ', IMPRESSORA_NOME'#13#10 //
    + ', IMPRESSORA_COLS_QTD'#13#10 //

    + ', CUPOM_QTD_LINS_FINAL'#13#10 //

    + ', SEMPRE_OFFLINE'#13#10 //
    + ', ATIVO'#13#10 //

    + ', BALANCA_PORTA'#13#10 //
    + ', BALANCA_BAUDRATE'#13#10 //
    + ', BALANCA_DATABITS'#13#10 //
    + ', BALANCA_PARIDADE'#13#10 //
    + ', BALANCA_STOPBITS'#13#10 //
    + ', BALANCA_HANDSHAKING'#13#10 //

    + ') VALUES (' //

    + T.TerminalId.ToString + ' -- TERMINAL_ID'#13#10 //

    + ', ' + T.Apelido.QuotedString + ' -- APELIDO'#13#10 //
    + ', ' + T.NomeNaRede.QuotedString + ' -- NOME_NA_REDE'#13#10 //
    + ', ' + T.IP.QuotedString + ' -- IP'#13#10 //
    + ', ' + T.LetraDoDrive.QuotedString + ' -- LETRA_DO_DRIVE'#13#10 //

    + ', ' + T.NFSerie.ToString + ' -- NF_SERIE'#13#10 //

    + ', ' + BooleanToStrSQL(T.GavetaTem) + ' -- GAVETA_TEM'#13#10 //
    + ', ' + T.GavetaComando.QuotedString + ' -- GAVETA_COMANDO'#13#10 //
    + ', ' + T.GavetaImprNome.QuotedString + ' -- GAVETA_IMPR_NOME'#13#10 //

    + ', ' + T.BalancaModoUsoId.ToString + ' -- BALANCA_MODO_USO_ID'#13#10 //
    + ', ' + T.BalancaId.ToString + ' -- BALANCA_ID'#13#10 //

    + ', ' + T.BarCodigoIni.ToString + ' -- BARRAS_COD_INI'#13#10 //
    + ', ' + T.BarCodigoTam.ToString + ' -- BARRAS_COD_TAM'#13#10 //

    + ', ' + T.ImpressoraModoEnvioId.ToString +
    ' -- IMPRESSORA_MODO_ENVIO_ID'#13#10 //
    + ', ' + T.ImpressoraModeloId.ToString + ' -- IMPRESSORA_MODELO_ID'#13#10 //
    + ', ' + T.ImpressoraNome.QuotedString + ' -- GAVETA_IMPR_NOME'#13#10 //
    + ', ' + T.ImpressoraColsQtd.ToString + ' -- IMPRESSORA_COLS_QTD'#13#10 //

    + ', ' + T.CupomQtdLinsFinal.ToString + ' -- CUPOM_QTD_LINS_FINAL'#13#10 //

    + ', ' + BooleanToStrSQL(T.SempreOffLine) + ' -- SEMPRE_OFFLINE'#13#10 //
    + ', ' + BooleanToStrSQL(T.Ativo) + ' -- ATIVO'#13#10 //

    + ', ' + T.BALANCA_PORTA.ToString + ' -- BALANCA_PORTA'#13#10 //
    + ', ' + T.BALANCA_BAUDRATE.ToString + ' -- BALANCA_BAUDRATE'#13#10 //
    + ', ' + T.BALANCA_DATABITS.ToString + ' -- BALANCA_DATABITS'#13#10 //
    + ', ' + T.BALANCA_PARIDADE.ToString + ' -- BALANCA_PARIDADE'#13#10 //
    + ', ' + T.BALANCA_STOPBITS.ToString + ' -- BALANCA_STOPBITS'#13#10 //
    + ', ' + T.BALANCA_HANDSHAKING.ToString + ' -- BALANCA_HANDSHAKING'#13#10 //

    + ')'#13#10 //

    + 'MATCHING (TERMINAL_ID);';

//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  DBExecScript.PegueComando(sSql);
end;

procedure GravarInicialTerm(pTerminal: ITerminal;
  rDBConnectionParamsTerm: TDBConnectionParams; pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ISisLoja;
  pUsuarioAdmin: IUsuario);
begin
  FixedCriticalSection := TFixedCriticalSection.Create;
  DBConnectionTerm := DBConnectionCreate('GravarInicialTerm.Conn',
    pAppObj.SisConfig, rDBConnectionParamsTerm, nil, nil);
  DBConnectionTerm.Abrir;
  try
    DBExecScript := DBExecScriptCreate('GravarInicialTerm.ExecScript',
      DBConnectionTerm, nil, nil, FixedCriticalSection, False);
    GarantirAmbi(pLoja.Id, pTerminal.TerminalId);
    GarantirLoja(pLoja);
    GarantirTerminal(pTerminal);
    DBExecScript.Execute;
  finally
    DBConnectionTerm.Fechar;
    FixedCriticalSection.Free;
  end;
end;

end.
