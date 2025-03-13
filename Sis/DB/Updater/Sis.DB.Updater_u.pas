unit Sis.DB.Updater_u;

interface

uses
  Sis.DB.Updater, Sis.ui.io.output, System.Classes, Vcl.Dialogs, Sis.Types,
  Sis.Config.SisConfig, Sis.ui.io.output.ProcessLog, Sis.DB.DBTypes,
  Sis.DB.Updater.Comando.List, Sis.DB.Updater.Operations, Sis.Loja, Sis.Usuario,
  Sis.Entities.Types, Sis.DB.Updater.PontoAlvo.Utils_u, Vcl.Forms,
  Sis.TerminalList, Sis.Terminal, Sis.DB.Updater_u.Teste, Sis.Terminal.DBI;

type
  TGetDBExisteRetorno = (dbeExistia, dbeNaoExistiaCopiou, dbeNaoExistia);

  TGetDBExisteRetornoHelper = record helper for TGetDBExisteRetorno
    function ToString: string;
  end;

  TDBUpdater = class(TInterfacedObject, IDBUpdater)
  private
    FTerminalId: TTerminalId;
    FTerminalDBI: ITerminalDBI;
    FDBUpdaterPontoAlvo: TDBUpdaterPontoAlvo;
    FsDBUpdaterPontoAlvo: string;
    FDBConnectionParams: TDBConnectionParams;
    FSisConfig: ISisConfig;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FMudoOutput: IOutput;
    FDBMS: IDBMS;
    FiVersao: integer;
    FCaminhoComandos: string;
    FLinhasSL: TStringList;
    FDtHExec: TDateTime;
    FSqlDestinoSL: TStringList;
    FsAssunto: string;
    FNomeArqBanco: string;
    FsVersaoObjetivo: string;

    FsDBAtualizPontoAlvo: string;
    FDBAtualizPontoAlvo: TDBUpdaterPontoAlvo;

    FsDBAtualizAtividadeAlvo: string;

    FsObs: string;
    FComandoList: IComandoList;
    FPastaProduto: string;
    FDBConnection: IDBConnection;

    FDBUpdaterOperations: IDBUpdaterOperations;
    FTerminalList: ITerminalList;

    FLoja: ISisLoja;
    FUsuarioAdmin: IUsuario;

    FDBExisteRetorno: TGetDBExisteRetorno;

    FsDiretivaAbre: string;
    FsDiretivaFecha: string;

    FVariaveis: TStringList;

    procedure SetiVersao(const Value: integer);

    function CarreguouArqComando(piVersao: integer): Boolean;
    procedure RemoveExcedentes(pSL: TStrings);
    procedure LerUpdateProperties(pSL: TStrings);

    procedure ComandosCarregar;
    procedure ComandosGetSql;
    procedure InsertCabecalho;
    procedure ExecuteSql;
    procedure ComandosTesteFuncionou;
    procedure GravarVersao;

    /// <summary>
    /// Grava os dados iniciais no banco de dados.
    /// </summary>
    /// <param name="pDBConnection">Conexão com o banco de dados.</param>
    /// <remarks>
    /// Este método realiza várias operações de inicialização,
    /// incluindo a criação de registros de gerente, loja e suporte.
    /// </remarks>
    /// <remarks>
    /// Quando ainda não existe pessoa, não é possível gerar um log.
    /// Logs aqui são necessários pois serão usados para notificar os PDVs
    /// destes novos registros.
    ///
    /// Primeiro, chama <c>GravarIniciais_CrieGerenteInicial</c>
    /// que gera a pessoa sem o uso de stored procedures,
    /// apenas <c>INSERT INTO</c>.
    ///
    /// Depois que o registro da pessoa do gerente já existe,
    /// pode-se criar a loja e as demais tabelas.
    /// Mesmo o gerente agora será regravado usando stored procedures
    /// e todos terão os seus logs registrados.
    ///
    /// aí que entra a <c>GravarIniciais_CrieGerenteFinal</c>
    /// </remarks>
    /// <exception cref="EAbort">Lança uma exceção se estiver em um terminal.</exception>
    procedure GravarIniciais(pDBConnection: IDBConnection);

    function GravarIniciais_CrieMachineIdLocal(pDBConnection: IDBConnection)
      : SmallInt;
    procedure GravarIniciais_CrieSistemaInicial(pDBConnection: IDBConnection);
    function GravarIniciais_CrieGerenteInicial(pDBConnection
      : IDBConnection): integer;
    procedure GravarIniciais_CrieGerenteFinal(pDBConnection: IDBConnection);
    procedure GravarIniciais_CrieLoja(pDBConnection: IDBConnection);
    procedure GravarIniciais_CrieSistemaFinal(pDBConnection: IDBConnection);
    procedure GravarIniciais_CrieSuporte(pDBConnection: IDBConnection);

    procedure DoAposCriarBanco;

    procedure LinhasUppercase(pSL: TStrings);
  protected
    property SisConfig: ISisConfig read FSisConfig;
    property ProcessLog: IProcessLog read FProcessLog;
    property output: IOutput read FOutput;
    property MudoOutput: IOutput read FMudoOutput;

    property dbms: IDBMS read FDBMS;
    property iVersao: integer read FiVersao write SetiVersao;

    /// <summary>
    /// Verifica se o banco de dados existe.
    /// </summary>
    /// <returns>
    /// Retorna um valor de <c>TGetDBExisteRetorno</c> indicando
    /// se o banco de dados existia, se não existia e foi copiado, ou se não
    /// existia.
    /// dbeExistia - O banco de dados já existia.
    /// dbeNaoExistiaCopiou - O banco de dados não existia e foi copiado.
    /// dbeNaoExistia - O banco de dados não existia
    /// </returns>
    function GetDBExiste: TGetDBExisteRetorno; virtual; abstract;

    /// <summary>
    /// Garante a existencia do banco de dados, descobre a versão do banco e
    /// conecta a ele.
    /// </summary>
    /// <returns>A versão do banco de dados.</returns>
    /// <remarks>
    /// verifica se o banco de dados existe e, se não existir, cria.
    /// Em seguida, conecta ao banco de dados e prepara as operações principais.
    /// Se a tabela de histórico de atualizações não existir, retorna -1.
    /// Caso contrário, retorna a última versão registrada nesta tabela
    /// </remarks>
    /// <exception cref="Exception">Lança uma exceção se houver erro ao criar ou conectar ao banco de dados.</exception>
    function DBDescubraVersaoEConecte: integer; virtual;

    property LinhasSL: TStringList read FLinhasSL;

    function VersaoToArqComando(pVersao: integer): string;

    function GetNomeBanco: string; virtual; abstract;
    property NomeBanco: string read GetNomeBanco;
    procedure CrieDB; virtual; abstract;

    property DBConnection: IDBConnection read FDBConnection;
    property DBConnectionParams: TDBConnectionParams read FDBConnectionParams;
    property PastaProduto: string read FPastaProduto;

    property sDBAtualizPontoAlvo: string read FsDBAtualizPontoAlvo;
    property DBAtualizPontoAlvo: TDBUpdaterPontoAlvo read FDBAtualizPontoAlvo;

    property sDBAtualizAtividadeAlvo: string read FsDBAtualizAtividadeAlvo;

    procedure DiretivasAjustaCaracteres; virtual;
    property TerminalId: TTerminalId read FTerminalId;
  public
    function Execute: Boolean;

    constructor Create(pTerminalId: TTerminalId;
      pDBConnectionParams: TDBConnectionParams; pPastaProduto: string;
      pDBMS: IDBMS; pSisConfig: ISisConfig; pProcessLog: IProcessLog;
      pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
      pTerminalList: ITerminalList; pVariaveis: string);
    destructor Destroy; override;
  end;

implementation

{ TDBUpdater }

uses System.SysUtils, System.StrUtils, Sis.DB.Updater.Factory,
  Sis.Sis.constants, Sis.DB.Factory, Sis.DB.Updater.Constants_u,
  Sis.DB.Updater_u_GetStrings, Sis.DB.Updater.Comando, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.Types.TStrings_u, Sis.Types.strings.Crypt_u,
  Sis.Win.Utils_u, Sis.ui.io.Files, Sis.Win.Execute, Sis.Win.Factory,
  Sis.DB.Updater.Diretivas_u, Sis.Types.Bool_u, Sis.Terminal.Factory_u,
  Sis.ui.io.Factory, System.DateUtils;

constructor TDBUpdater.Create(pTerminalId: TTerminalId;
  pDBConnectionParams: TDBConnectionParams; pPastaProduto: string; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput;
  pLoja: ISisLoja; pUsuarioAdmin: IUsuario; pTerminalList: ITerminalList;
  pVariaveis: string);
var
  sConnNome: string;
begin
  FVariaveis := TStringList.Create;

  FVariaveis.Text := pVariaveis;
  FTerminalId := pTerminalId;
  FTerminalList := pTerminalList;
  FDBUpdaterPontoAlvo := TerminalIdToPontoAlvo(FTerminalId);
  FsDBUpdaterPontoAlvo :=
    AnsiUpperCase(DBUpdaterPontoAlvoNomes[FDBUpdaterPontoAlvo]);

  FPastaProduto := pPastaProduto;
  FSqlDestinoSL := TStringList.Create;
  FDBConnectionParams := pDBConnectionParams;
  FNomeArqBanco := ExtractFileName(FDBConnectionParams.Arq);
  FSisConfig := pSisConfig;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FMudoOutput := MudoOutputCreate;
  FDBMS := pDBMS;

  FLoja := pLoja;
  FUsuarioAdmin := pUsuarioAdmin;

  FProcessLog.PegueLocal('TDBUpdater.Create');

  try
    FCaminhoComandos := FPastaProduto + 'Inst\Update\DBUpdates\';

    FProcessLog.RegistreLog('FDBConnectionParams.Database=' +
      FDBConnectionParams.Database + ',FCaminhoComandos=' + FCaminhoComandos);

    sConnNome := ExtractFileName(FDBConnectionParams.Arq);
    sConnNome := ChangeFileExt(sConnNome, '');
    sConnNome := 'Updater.' + FDBConnectionParams.Server + '.' + sConnNome
      + '.Conn';

    FDBConnection := DBConnectionCreate(sConnNome, FSisConfig,
      FDBConnectionParams, FProcessLog, FOutput);

    FTerminalDBI := TerminalDBICreate(FDBConnection);

    FDBUpdaterOperations := DBUpdaterOperationsCreate(FDBConnection,
      FProcessLog, FOutput);

    FComandoList := ComandoListCreate;

  finally
    FProcessLog.RegistreLog('Fim');
    FProcessLog.RetorneLocal;
  end;
end;

function TDBUpdater.DBDescubraVersaoEConecte: integer;
var
  sErro: string;
  eTmp: TGetDBExisteRetorno;
begin
  Result := -1;
  FProcessLog.PegueLocal('TDBUpdater.DBDescubraVersaoEConecte');
  try
    FProcessLog.RegistreLog('vai GetDBExiste, testar se o banco existe');
    FDBExisteRetorno := GetDBExiste;
    FProcessLog.RegistreLog('GetDBExiste, retornou ' +
      FDBExisteRetorno.ToString);

    if not(FDBExisteRetorno = dbeExistia) then
    begin
      if FDBExisteRetorno = dbeNaoExistia then
      begin
        FProcessLog.RegistreLog('banco nao existia, vai CrieDB');
        CrieDB;
      end;

      FProcessLog.RegistreLog
        ('vai novamente GetDBExiste, confirmar que o banco agora existe');
      eTmp := GetDBExiste;
      FProcessLog.RegistreLog('GetDBExiste, retornou ' + eTmp.ToString);

      if not(eTmp = dbeExistia) then
      begin
        sErro := 'TDBUpdater.DBDescubraVersaoEConecte,' +
          'Erro ao criar banco de dados';
        FProcessLog.RegistreLog(sErro);
        raise Exception.Create(sErro);
      end
      else
        FProcessLog.RegistreLog('agora banco existe');
    end
    else
      FProcessLog.RegistreLog('banco existia');

    FProcessLog.RegistreLog('vai DBConnection.Abrir');
    DBConnection.Abrir;

    FProcessLog.RegistreLog('vai FDBUpdaterOperations.PreparePrincipais');
    FDBUpdaterOperations.PreparePrincipais;

    FProcessLog.RegistreLog('vai testar se tabela existe ' +
      NOMETAB_DBUPDATE_HIST);

    if not FDBUpdaterOperations.TabelaExiste(NOMETAB_DBUPDATE_HIST) then
    begin
      FProcessLog.RegistreLog('nao existia,vr=-1');
      Result := -1;
      exit;
    end;

    FProcessLog.RegistreLog('existia,vai ler com versao_get');
    Result := FDBUpdaterOperations.VersaoGet;
    FProcessLog.RegistreLog('Retornou ' + Result.ToString);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

destructor TDBUpdater.Destroy;
begin
  FProcessLog.PegueLocal('TDBUpdater.Destroy');
  try
    FProcessLog.RegistreLog('FSqlDestinoSL.Free');
    FSqlDestinoSL.Free;
    FVariaveis.Free;
  finally
    FProcessLog.RetorneLocal;
  end;
  inherited;
end;

procedure TDBUpdater.DiretivasAjustaCaracteres;
begin
  FsDiretivaAbre := '{';
  FsDiretivaFecha := '}';
end;

procedure TDBUpdater.DoAposCriarBanco;
var
  sNomeArqBat: string;
  sPastaBin: string;
  sPastaExe: string;
  sPastaEventos: string;
  OWinExecute: IWinExecute;
begin
{$IFNDEF DEBUG}
  exit;
{$ENDIF}
  if FTerminalId > 1 then
    exit;

  sPastaBin := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  sPastaExe := PastaAcima(sPastaBin);
  sPastaEventos := sPastaExe + 'Comandos\Eventos\';

  GarantirPasta(sPastaEventos);

  sNomeArqBat := sPastaEventos + 'Exec Apos Criar DB';
  if FTerminalId = 0 then
    sNomeArqBat := sNomeArqBat + ' Server'
  else
    sNomeArqBat := sNomeArqBat + ' Term' + FTerminalId.ToString;
  sNomeArqBat := sNomeArqBat + '.bat';

  if not FileExists(sNomeArqBat) then
    exit;

  OWinExecute := WinExecuteCreate(sNomeArqBat, '"' + FDBConnectionParams.Arq +
    '"', sPastaEventos, True, 1);
  OWinExecute.EspereExecucao(output, 16);
  // C:\Pr\app\bantu\bantu-sis\Exe\Comandos\Eventos\Exec Apos Criar DB.bat
end;

function TDBUpdater.Execute: Boolean;
var
  sVariaveisAdicionais: string;
  bPontoSeAplica: Boolean;
  bAtividadeSeAplica: Boolean;
  sAtividadeEconomicaName: string;
  bDeveGravarIniciais: Boolean;
  bDeveAbortar: Boolean;
begin
  Result := True;
  FProcessLog.PegueLocal('TDBUpdater.Execute');
  DiretivasAjustaCaracteres;
  FLinhasSL := TStringList.Create;
  try
    try
      FProcessLog.RegistreLog('vai iVersao := DBDescubraVersaoEConecte');
      iVersao := DBDescubraVersaoEConecte;
      FProcessLog.RegistreLog('iVersao' + iVersao.ToString);

      Sis.DB.Updater_u.Teste.ResetBanco(FDBConnectionParams, FDBMS,
        FTerminalList.TerminalIdToTerminal(TerminalId),
        FPastaProduto + 'Comandos\Updater\', FProcessLog, FOutput);
      try
        repeat
          FOutput.Exibir('');
          iVersao := iVersao + 1;
          FOutput.Exibir('Versao=' + iVersao.ToString);
          if DB_UPDATER_EM_TESTE then
            if iVersao > VERSAO_ULTIMA_A_PROCESSAR then
              break;

          FProcessLog.RegistreLog('iVersao' + iVersao.ToString +
            ',vai CarreguouArqComando');

          if not CarreguouArqComando(iVersao) then
          begin
            FProcessLog.RegistreLog('retornou False, vai abortar o loop');
            break;
          end;
          FProcessLog.RegistreLog('retornou True');

          FDtHExec := Now;
          RemoveExcedentes(FLinhasSL);
          LinhasUppercase(FLinhasSL);
          // Sis.Types.TStrings_u.SalveSL(FLinhasSL, 'D:\Doc\linhas.txt');
          // teste
          // FLinhasSL.LoadFromFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\origem com diretivas.txt');
          //
          // ProcessarDiretivas(FLinhasSL,
          // 'PONTO_ALVO=TERMINAL'#13#10'TERMINAL_ID=1', '{', '}');
          // FLinhasSL.SaveToFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\destino terminal.txt');
          //
          // FLinhasSL.LoadFromFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\origem com diretivas.txt');
          // ProcessarDiretivas(FLinhasSL,
          // 'PONTO_ALVO=SERVIDOR'#13#10'TERMINAL_ID=1', '{', '}');
          // FLinhasSL.SaveToFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\destino servidor.txt');
          //
          // Halt(0);
          // fim do teste            testar acima, add aqui terminal_id=

          // SLUpperCase(FLinhasSL);

          sVariaveisAdicionais := //
            'PONTO_ALVO=' + FsDBUpdaterPontoAlvo + #13#10 + //
            'TERMINAL_ID=' + FTerminalId.ToString + #13#10 //
            ; //

          ProcessarDiretivas(FLinhasSL, FVariaveis.Text + #13#10 +
            sVariaveisAdicionais, FsDiretivaAbre, FsDiretivaFecha);
          // {$IFDEF DEBUG}
          // if iVersao=2 then
          // begin
          // CopyTextToClipboard(FLinhasSL.Text);
          // end;
          // {$ENDIF}

          LerUpdateProperties(FLinhasSL);
          sAtividadeEconomicaName := FVariaveis.Values
            ['ATIVIDADE_ECONOMICA_NAME'];
          bAtividadeSeAplica := Iif(FsDBAtualizAtividadeAlvo = '#032', True, //
            FsDBAtualizAtividadeAlvo = sAtividadeEconomicaName);

          bPontoSeAplica := PontoSeAplica(FTerminalId, FDBAtualizPontoAlvo);

          if bPontoSeAplica and bAtividadeSeAplica then
          begin
            FProcessLog.RegistreLog('ComandosCarregar');
            ComandosCarregar;

            FProcessLog.RegistreLog('ComandosGetSql');
            ComandosGetSql;

            FProcessLog.RegistreLog('ExecuteSql');
            ExecuteSql;

            FProcessLog.RegistreLog('ComandosTesteFuncionou');
            ComandosTesteFuncionou;
          end;

          FProcessLog.RegistreLog('GravarVersao');
          GravarVersao;
        until False;
      finally
        FProcessLog.RegistreLog('FDBUpdaterOperations.Unprepare');
        FDBUpdaterOperations.Unprepare;
      end;
    except
      on E: Exception do
      begin
        FOutput.Exibir('vr. ' + iVersao.ToString + E.Message);
        FProcessLog.RegistreLog('TDBUpdater.Execute,erro vr. ' +
          iVersao.ToString + E.Message);
        // DBConnection.Rollback;
      end;
    end;

    // updater fim aqui
    // update fim aqui

    if FDBExisteRetorno <> dbeExistia then
      DoAposCriarBanco;

    bDeveGravarIniciais := (FDBUpdaterPontoAlvo = upontoServidor) and
      (DB_UPDATER_EM_TESTE or TESTE_GRAVA_INICIAIS) and
      (FDBExisteRetorno <> dbeExistia);

    if bDeveGravarIniciais then
    begin
      GravarIniciais(DBConnection);
    end;
  finally
    FProcessLog.RegistreLog('DBConnection.Fechar');

    DBConnection.Fechar;
    // updater fim aqui
    // updater aqui
    // update fim aqui
    // update aqui
    // dbupdate aqui
    // db update aqui
    // dbupdate fim aqui

    FreeAndNil(FLinhasSL);
    FOutput.Exibir('TDBUpdater.Execute,Fim');
    FProcessLog.RetorneLocal;

    bDeveAbortar := DB_UPDATER_EM_TESTE and TESTE_ABORTA_NO_PRIMEIRO;
    if bDeveAbortar then
      Halt(0);
  end;
end;

procedure TDBUpdater.InsertCabecalho;
var
  sLinhas: string;
begin
  sLinhas := GetUpdaterCabecalho(iVersao, FsVersaoObjetivo, FsObs, FsAssunto,
    FDBConnectionParams.Database, FDtHExec);

  FSqlDestinoSL.Text := sLinhas + FSqlDestinoSL.Text;
end;

procedure TDBUpdater.LerUpdateProperties(pSL: TStrings);
var
  sLog: string;
  sOutput: string;
begin
  ProcessLog.PegueLocal('TDBUpdater.LerUpdateProperties');
  try
    sOutput := '';

    FsAssunto := pSL.Values[DBATUALIZ_ASSUNTO_CHAVE];
    sOutput := sOutput + 'FsAssunto=' + FsAssunto + #13#10;

    FsVersaoObjetivo := pSL.Values[DBATUALIZ_OBJETIVO_CHAVE];
    sOutput := sOutput + 'sVersaoObjetivo=' + FsVersaoObjetivo + #13#10;

    // pega ponto alvo
    FsDBAtualizPontoAlvo := pSL.Values[DBATUALIZ_PONTO_ALVO_CHAVE];
    sOutput := sOutput + 'sPontoAlvo=' + FsDBAtualizPontoAlvo + #13#10;

    FDBAtualizPontoAlvo := StrToPontoAlvo(FsDBAtualizPontoAlvo);

    // pega atividade alvo
    FsDBAtualizAtividadeAlvo := pSL.Values[DBATUALIZ_ATIVIDADE_ALVO_CHAVE];
    if FsDBAtualizAtividadeAlvo = '' then
      FsDBAtualizAtividadeAlvo := '#032';
    sOutput := sOutput + 'sAtividadeAlvo=' + FsDBAtualizAtividadeAlvo + #13#10;

    FsObs := pSL.Values[DBATUALIZ_OBS_CHAVE];
    sOutput := sOutput + 'sObs=' + FsObs + #13#10;

    sLog := sOutput;
    FOutput.Exibir(sOutput);
  finally
    FProcessLog.RegistreLog(sLog);
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.LinhasUppercase(pSL: TStrings);
var
  i: integer;
  bNoCSV: Boolean;
  sOriginal: string;
  sMaiusculas: string;
  bDentroDeBloco: Boolean;
  iPosBloco: integer;
begin
  bNoCSV := False;
  bDentroDeBloco := False;
  for i := 0 to pSL.Count - 1 do
  begin
    sOriginal := pSL[i];

    iPosBloco := Pos('```', sOriginal);
    if iPosBloco > 0 then
      bDentroDeBloco := not bDentroDeBloco;

    if bDentroDeBloco then
      continue;

    sOriginal := Trim(sOriginal);

    sMaiusculas := AnsiUpperCase(sOriginal);

    if sMaiusculas = DBATUALIZ_CSV_INI_CHAVE then
      bNoCSV := True
    else if sMaiusculas = DBATUALIZ_CSV_FIM_CHAVE then
      bNoCSV := False;

    if bNoCSV then
      pSL[i] := sOriginal
    else
      pSL[i] := sMaiusculas;
  end;
end;

function TDBUpdater.CarreguouArqComando(piVersao: integer): Boolean;
var
  sNomeArq: string;
  sLog: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.CarreguouArqComando');
  try
    sLog := 'piVersao=' + piVersao.ToString;

    // sNomeArq := VersaoToArqComando(84);
    // sNomeArq := VersaoToArqComando(100);
    // sNomeArq := VersaoToArqComando(101);

    sNomeArq := VersaoToArqComando(piVersao);

    sLog := sLog + ',sNomeArqComando=' + sNomeArq;
    Result := FileExists(sNomeArq);

    if not Result then
    begin
      sLog := sLog + ',arq nao encontrado, encerrando';
      exit;
    end;
    sLog := sLog + ',arq encontrado, vai carregar';

    FOutput.Exibir('iVersao=' + piVersao.ToString);

    FLinhasSL.LoadFromFile(sNomeArq);
    // FLinhasSL.LoadFromFile(sNomeArq, TEncoding.GetEncoding(1252));

    Result := FLinhasSL.Text <> '';

    if not Result then
    begin
      sLog := sLog + ',arquivo estava vazio, abortando';
    end;
  finally
    FProcessLog.RegistreLog(sLog);
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.ComandosCarregar;
var
  iLin: integer;
  sLin: string;
  bComandAberto: Boolean;
  oComando: IComando;
  sTipoComando: string;
  bSeAplica: Boolean;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosCarregar');
  FOutput.Exibir('Carregando comandos...');

  try
    bComandAberto := False;
    iLin := 0;
    FComandoList.Clear;
    bSeAplica := True;
    while iLin < FLinhasSL.Count do
    begin
      sLin := FLinhasSL[iLin];

      if sLin = DBATUALIZ_COMANDO_INI_CHAVE then
      begin
        bComandAberto := True;
      end
      else if sLin = DBATUALIZ_COMANDO_FIM_CHAVE then
      begin
        bComandAberto := False;
        bSeAplica := True;
      end
      else if Pos(DBATUALIZ_COMANDO_PONTO_ALVO + '=', sLin) = 1 then
      begin
        bSeAplica := ComandoPontoSeAplica(FTerminalId, sLin);
      end
      else if Pos(DBATUALIZ_COMANDO_TIPO + '=', sLin) = 1 then
      begin
        if bSeAplica then
        begin
          sTipoComando := StrApos(sLin, '=');
          FProcessLog.RegistreLog('sTipoComando=' + sTipoComando);
          oComando := TipoToComando(sTipoComando, FiVersao, FDBConnection,
            FDBUpdaterOperations, FProcessLog, FOutput);
          FComandoList.Add(oComando);
          oComando.PegarLinhas(iLin, FLinhasSL);
        end;
      end;

      inc(iLin);
    end;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.ComandosGetSql;
var
  oComando: IComando;
  sComandosSql: string;
  i, iQtdComandos: integer;
//  Ti, Tf: TDateTime;
//  s: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosGetSql');
  try
    FOutput.Exibir('Montando comandos...');
    FSqlDestinoSL.Clear;
    iQtdComandos := 0;

    for i := 0 to FComandoList.Count - 1 do
    begin
      oComando := FComandoList[i];
//      Ti := Now;
      sComandosSql := oComando.GetAsSql;
//      Tf := Now;
//      s := FormatFloat('###0.000', SecondSpan(Ti, Tf));
      if sComandosSql <> '' then
      begin
        inc(iQtdComandos);
        FSqlDestinoSL.Text := FSqlDestinoSL.Text + sComandosSql;
      end;
    end;

    if iQtdComandos > 0 then
      InsertCabecalho;
  finally
    FProcessLog.RegistreLog('iQtdComandos=' + iQtdComandos.ToString);
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.ComandosTesteFuncionou;
var
  oComando: IComando;
  i: integer;
  Resultado: Boolean;
  sMensagemErro: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosTesteFuncionou');
  try
    FOutput.Exibir('Testando os comandos...');

    for i := 0 to FComandoList.Count - 1 do
    begin
      oComando := FComandoList[i];
{$IFDEF DEBUG}
      Resultado := True;
{$ELSE}
      Resultado := oComando.Funcionou;
{$ENDIF}
      if not Resultado then
      begin
        sMensagemErro := 'Erro DB UPDATER, vr ' + iVersao.ToString + ', ' +
          oComando.UltimoErro;
        // Sis.ui.io.output.exibirpausa.form_u.Exibir(sMensagemErro,
        // TMsgDlgType.mtError);
        FProcessLog.RegistreLog(sMensagemErro);
        raise Exception.Create(sMensagemErro);
      end;
    end;
    FProcessLog.PegueLocal('Comandos OK');
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.ExecuteSql;
var
  sAssunto: string;
  sSql: string;
  sNomeBanco: string;
  sPastaComandos: string;

begin
  FProcessLog.PegueLocal('TDBUpdater.ExecuteSql');
  try
    FOutput.Exibir('Executando comandos...');
    FProcessLog.RegistreLog('Executando ' + iVersao.ToString);

    sAssunto := 'DBUpdate ' + IntToStrZero(iVersao, 9);
    sSql := FSqlDestinoSL.Text;
    sNomeBanco := FDBConnectionParams.GetNomeBanco;
    sPastaComandos := FPastaProduto + 'Comandos\Updater\';
    FOutput.Exibir(FNomeArqBanco + ' ' + sAssunto);
    dbms.ExecInterative(sAssunto, sSql, sNomeBanco, sPastaComandos, FProcessLog,
      FMudoOutput, False);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.GravarIniciais(pDBConnection: IDBConnection);
var
  i: integer;
begin
  if FTerminalId > 0 then // se estou em terminal, aborta
    exit;

  FSisConfig.LocalMachineId.IdentId := GravarIniciais_CrieMachineIdLocal
    (pDBConnection);
  if FUsuarioAdmin.Id < 1 then
  begin
    GravarIniciais_CrieSistemaInicial(pDBConnection);
    FUsuarioAdmin.Id := GravarIniciais_CrieGerenteInicial(pDBConnection);
  end;
  if FLoja.Descr <> '' then
  begin
    GravarIniciais_CrieLoja(pDBConnection);
  end;

  if FUsuarioAdmin.NomeCompleto <> '' then
  begin
    GravarIniciais_CrieSistemaFinal(pDBConnection);
    GravarIniciais_CrieSuporte(pDBConnection);
    GravarIniciais_CrieGerenteFinal(pDBConnection);
  end;

  pDBConnection.ExecuteSql('UPDATE USUARIO SET DE_SISTEMA=TRUE' +
    ' WHERE PESSOA_ID < 0;');

  FTerminalDBI.ListToDB(FTerminalList, FLoja.Id, FUsuarioAdmin.Id,
    FSisConfig.LocalMachineId.IdentId);
end;

function TDBUpdater.GravarIniciais_CrieGerenteInicial(pDBConnection
  : IDBConnection): integer;
var
  sSql: string;
  oDBQuery: IDBQuery;
begin
  sSql := 'SELECT PESSOA_PA.PROXIMO_ID_GET() AS PESSOA_ID_RET FROM RDB$DATABASE';

  oDBQuery := DBQueryCreate('TDBUpdater.GravarIniciais.Query', pDBConnection,
    sSql, FProcessLog, FOutput);

  oDBQuery.Abrir;
  Result := oDBQuery.DataSet.Fields[0].AsInteger;
  oDBQuery.Fechar;

  sSql := 'INSERT INTO PESSOA'#13#10 //
    + '('#13#10 //

    + '  LOJA_ID'#13#10 //
    + '  , TERMINAL_ID'#13#10 //
    + '  , PESSOA_ID'#13#10 //
    + '  , NOME'#13#10 //

    + ')'#13#10 //
    + 'VALUES'#13#10 //
    + '('#13#10 //

    + '  ' + FLoja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , 0 -- TERMINAL_ID'#13#10 //
    + '  , ' + Result.ToString + ' -- PESSOA_ID'#13#10 //
    + '  , ' + FUsuarioAdmin.NomeCompleto.QuotedString + ' -- NOME'#13#10 //

    + ');'#13#10;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDBConnection.ExecuteSql(sSql);
end;

procedure TDBUpdater.GravarIniciais_CrieLoja(pDBConnection: IDBConnection);
var
  sSql: string;
begin
  sSql := 'EXECUTE PROCEDURE LOJA_INICIAL_PA.GARANTIR(' //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + FLoja.Descr.QuotedString // APELIDO
    + ', TRUE' // SELECIONADO
    + ', ' + FLoja.Id.ToString // LOG_LOJA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');'; //
  pDBConnection.ExecuteSql(sSql);
end;

procedure TDBUpdater.GravarIniciais_CrieSistemaFinal(pDBConnection
  : IDBConnection);
var
  sSql: string;
  oDBQuery: IDBQuery;
  sSenha: string;
  iSistemaPessoaId: integer;
begin
  Encriptar(1, '123', sSenha);

  sSql := 'SELECT PESSOA_ID_RET FROM USUARIO_PA.GARANTIR_NOMES(' //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + USUARIO_SISTEMA_NOME.QuotedString // NOME
    + ', ' + USUARIO_SISTEMA_NOME_DE_USUARIO.QuotedString // NOME_DE_USUARIO
    + ', ' + sSenha.QuotedString // SENHA
    + ', 1' // CRY_VER
    + ', ' + 'SISTEMA'.QuotedString // APELIDO
    + ', ' + USUARIO_SISTEMA_PESSOA_ID.ToString // PESSOA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ', TRUE' + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  iSistemaPessoaId := pDBConnection.GetValue(sSql);

  sSql := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_DE_USO_GARANTIR(' +
    FLoja.Id.ToString // LOJA_ID
    + ', ' + iSistemaPessoaId.ToString // USUARIO_PESSOA_ID
    + ', 1' // PERFIL_DE_USO_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDBConnection.ExecuteSql(sSql);
end;

procedure TDBUpdater.GravarIniciais_CrieSistemaInicial(pDBConnection
  : IDBConnection);
var
  sSql: string;
begin

  sSql := 'INSERT INTO PESSOA'#13#10 //
    + '('#13#10 //

    + '  LOJA_ID'#13#10 //
    + '  , TERMINAL_ID'#13#10 //
    + '  , PESSOA_ID'#13#10 //
    + '  , NOME'#13#10 //

    + ')'#13#10 //
    + 'VALUES'#13#10 //
    + '('#13#10 //

    + '  ' + FLoja.Id.ToString + ' -- LOJA_ID'#13#10 //
    + '  , 0 -- TERMINAL_ID'#13#10 //
    + '  , ' + USUARIO_SISTEMA_PESSOA_ID.ToString + ' -- PESSOA_ID'#13#10 //
    + '  , ' + USUARIO_SISTEMA_NOME.QuotedString + ' -- NOME'#13#10 //

    + ');'#13#10;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDBConnection.ExecuteSql(sSql);
end;

procedure TDBUpdater.GravarIniciais_CrieSuporte(pDBConnection: IDBConnection);
var
  sSql: string;
  oDBQuery: IDBQuery;
  sSenha: string;
  iSuportePessoaId: integer;
begin
  Encriptar(1, '123', sSenha);

  sSql := 'SELECT PESSOA_ID_RET FROM USUARIO_PA.GARANTIR_NOMES(' //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + 'SUPORTE TECNICO'.QuotedString // NOME
    + ', ' + 'SUP'.QuotedString // NOME_DE_USUARIO
    + ', ' + sSenha.QuotedString // SENHA
    + ', 1' // CRY_VER
    + ', ' + 'SUPORTE'.QuotedString // APELIDO
    + ', ' + USUARIO_SUPORTE_PESSOA_ID.ToString // PESSOA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ', TRUE' + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  iSuportePessoaId := pDBConnection.GetValue(sSql);

  sSql := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_DE_USO_GARANTIR('
  //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + iSuportePessoaId.ToString // USUARIO_PESSOA_ID
    + ', 1' // PERFIL_DE_USO_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  pDBConnection.ExecuteSql(sSql);
end;

procedure TDBUpdater.GravarIniciais_CrieGerenteFinal(pDBConnection
  : IDBConnection);
var
  sSql: string;
  sSenha: string;
begin
  Encriptar(1, FUsuarioAdmin.Senha, sSenha);

  sSql := 'SELECT PESSOA_ID_RET FROM USUARIO_PA.GARANTIR_NOMES(' //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + FUsuarioAdmin.NomeCompleto.QuotedString // NOME
    + ', ' + FUsuarioAdmin.NomeDeUsuario.QuotedString // NOME_DE_USUARIO
    + ', ' + sSenha.QuotedString // SENHA
    + ', 1' // CRY_VER
    + ', ' + FUsuarioAdmin.NomeExib.QuotedString // APELIDO
    + ', ' + FUsuarioAdmin.Id.ToString // PESSOA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');';

  pDBConnection.GetValue(sSql);

  sSql := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_DE_USO_GARANTIR(' //
    + FLoja.Id.ToString // LOJA_ID
    + ', ' + FUsuarioAdmin.Id.ToString // PESSOA_ID
    + ', 2' // PERFIL_DE_USO_ID
    + ', ' + FUsuarioAdmin.Id.ToString // LOG_PESSOA_ID
    + ', ' + FSisConfig.LocalMachineId.IdentId.ToString // MACHINE_ID
    + ');';

  pDBConnection.ExecuteSql(sSql);
end;

function TDBUpdater.GravarIniciais_CrieMachineIdLocal(pDBConnection
  : IDBConnection): SmallInt;
var
  sSql: string;
  oDBQuery: IDBQuery;
begin
  sSql := 'select MACHINE_ID_RET' +
    ' from machine_pa.BYIDENT_GET (:NOME_NA_REDE, :IP);';

  oDBQuery := DBQueryCreate('TDBUpdater.GravarIniciais.Query', pDBConnection,
    sSql, FProcessLog, FOutput);

  oDBQuery.Prepare;
  try
    oDBQuery.Params[0].AsString := FSisConfig.LocalMachineId.Name;
    oDBQuery.Params[1].AsString := FSisConfig.LocalMachineId.IP;
    oDBQuery.Abrir;
    try
      Result := oDBQuery.DataSet.Fields[0].AsInteger;
    finally
      oDBQuery.Fechar;
    end;
  finally
    oDBQuery.Unprepare;
  end;
end;

procedure TDBUpdater.GravarVersao;
begin
  FProcessLog.PegueLocal('TDBUpdater.GravarVersao');
  try
    FProcessLog.RegistreLog('FDBUpdaterOperations.PrepareVersoes');
    FDBUpdaterOperations.PrepareVersoes;

    FProcessLog.RegistreLog('FDBUpdaterOperations.HistIns');
    FDBUpdaterOperations.HistIns(FiVersao, FsAssunto, FsVersaoObjetivo, FsObs);
  finally
    FProcessLog.RetorneLocal;
  end;

end;

procedure TDBUpdater.RemoveExcedentes(pSL: TStrings);
var
  sLog: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.RemoveExcedentes');
  try
    sLog := 'TDBUpdater.RemoveExcedentes,' + pSL.Count.ToString + ' linhas,';
    SLRemoveCommentsSingleLine(pSL);
    SLRemoveCommentsMultiLine(pSL);
    SLDeleteLinhasForaDe(pSL, DBATUALIZ_INI_CHAVE, DBATUALIZ_FIM_CHAVE);

    // SLUpperCase(FLinhasSL);

    sLog := sLog + ',sobraram ' + pSL.Count.ToString + ' linhas,';
    FProcessLog.RegistreLog(sLog);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.SetiVersao(const Value: integer);
begin
  FiVersao := Value;
end;

function TDBUpdater.VersaoToArqComando(pVersao: integer): string;
var
  iPrimNumFaixa: integer;
  sVersaoPastas: string;
  sNomeArqZeros: string;
  sPastaComando: string;
  sNomeArq: string;
begin
  // C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates\000\00\00\00\dbupdate 000000084.txt
  // seja pVersao = 84

  iPrimNumFaixa := (pVersao div 100) * 100;
  // 84 -> iPrimNumFaixa = 000
  // 100 -> iPrimNumFaixa = 100

  sVersaoPastas := IntToStrZero(iPrimNumFaixa div 100, 9);
  // sVersaoPastas = '000000000'
  // sVersaoPastas = '000000001'

  Insert('\', sVersaoPastas, 4);
  // sVersaoPastas = '000\000000'
  // sVersaoPastas = '000\000001'

  Insert('\', sVersaoPastas, 7);
  // sVersaoPastas = '000\00\0000'
  // sVersaoPastas = '000\00\0001'

  Insert('\', sVersaoPastas, 10);
  // sVersaoPastas = '000\00\00\00'
  // sVersaoPastas = '000\00\00\01'

  sNomeArqZeros := IntToStrZero(pVersao, 9);
  // sNomeArqZeros = '000000084'
  // sNomeArqZeros = '000000100'

  sPastaComando := FCaminhoComandos + sVersaoPastas + '\';
  // sPastaComando := 'C:\Pr\app\bantu\bantu-sis\Exe\Inst\Update\DBUpdates\000\00\00\00\'
  // sPastaComando := 'C:\Pr\app\bantu\bantu-sis\Exe\Inst\Update\DBUpdates\000\00\00\01\'

  ForceDirectories(sPastaComando);

  sNomeArq := sPastaComando + 'dbupdate ' + sNomeArqZeros + '.txt';
  // sNomeArq = 'C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates\000\00\00\00\' + 'dbupdate ' + 000000084' + '.txt'
  // sNomeArq = 'C:\Pr\app\bantu\bantu-sis\Exe\Inst\Update\DBUpdates\000\00\00\00\dbupdate 000000084.txt'
  // sNomeArq = 'C:\Pr\app\bantu\bantu-sis\Exe\Inst\Update\DBUpdates\000\00\00\01\dbupdate 000000100.txt'
  Result := sNomeArq;
end;

{ TGetDBExisteRetornoHelper }

function TGetDBExisteRetornoHelper.ToString: string;
begin
  case Self of
    dbeExistia:
      Result := 'dbeExistia'; // 'Existia';
    dbeNaoExistiaCopiou:
      Result := 'dbeNaoExistiaCopiou'; // 'Não existia, copiou';
    dbeNaoExistia:
      Result := 'dbeNaoExistia'; // 'Não existia';
  else
    Result := 'Desconhecido';
  end;
end;

end.
