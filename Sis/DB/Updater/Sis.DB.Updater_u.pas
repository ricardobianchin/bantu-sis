unit Sis.DB.Updater_u;

interface

uses
  Sis.DB.Updater, Sis.ui.io.output, System.Classes, Vcl.Dialogs, Sis.Types,
  Sis.Config.SisConfig, Sis.ui.io.output.ProcessLog, Sis.DB.DBTypes,
  Sis.DB.Updater.Comando.List, Sis.DB.Updater.Operations, Sis.Loja, Sis.Usuario,
  Sis.Entities.Types, Sis.DB.Updater.Destino.Utils_u, Vcl.Forms,
  Sis.Entities.TerminalList;

type
  TDBUpdater = class(TInterfacedObject, IDBUpdater)
  private
    FTerminalId: TTerminalId;
    FDBUpdaterAlvo: TDBUpdaterAlvo;
    FsDBUpdaterAlvo: string;
    FDBConnectionParams: TDBConnectionParams;
    FSisConfig: ISisConfig;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FDBMS: IDBMS;
    FiVersao: integer;
    FCaminhoComandos: string;
    FLinhasSL: TStringList;
    FDtHExec: TDateTime;
    FSqlDestinoSL: TStringList;
    FsAssunto: string;
    FsVersaoObjetivo: string;
    FsDBAtualizAlvo: string;
    FDBAtualizAlvo: TDBUpdaterAlvo;
    FsObs: string;
    FComandoList: IComandoList;
    FPastaProduto: string;
    FDBConnection: IDBConnection;

    FDBUpdaterOperations: IDBUpdaterOperations;
    FTerminalList: ITerminalList;

    FLoja: ILoja;
    FUsuarioGerente: IUsuario;

    FCriouDB: Boolean;

    FsDiretivaAbre: string;
    FsDiretivaFecha: string;

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

    procedure GravarIniciais(pDBConnection: IDBConnection);

    procedure DoAposCriarBanco;

  protected
    property SisConfig: ISisConfig read FSisConfig;
    property ProcessLog: IProcessLog read FProcessLog;
    property output: IOutput read FOutput;
    property dbms: IDBMS read FDBMS;
    property iVersao: integer read FiVersao write SetiVersao;
    function GetDBExiste: Boolean; virtual; abstract;
    function DBDescubraVersaoEConecte: integer; virtual;
    property LinhasSL: TStringList read FLinhasSL;

    function VersaoToArqComando(pVersao: integer): string;

    function GetNomeBanco: string; virtual; abstract;
    property NomeBanco: string read GetNomeBanco;
    procedure CrieDB; virtual; abstract;

    property DBConnection: IDBConnection read FDBConnection;
    property DBConnectionParams: TDBConnectionParams read FDBConnectionParams;
    property PastaProduto: string read FPastaProduto;

    property sDBAtualizAlvo: string read FsDBAtualizAlvo;
    property DBAtualizAlvo: TDBUpdaterAlvo read FDBAtualizAlvo;

    procedure DireitivasAjustaCaracteres; virtual;
  public
    function Execute: Boolean;

    constructor Create(pTerminalId: TTerminalId;
      pDBConnectionParams: TDBConnectionParams; pPastaProduto: string;
      pDBMS: IDBMS; pSisConfig: ISisConfig; pProcessLog: IProcessLog;
      pOutput: IOutput; pLoja: ILoja; pUsuarioGerente: IUsuario;
      pTerminalList: ITerminalList);
    destructor Destroy; override;
  end;

implementation

{ TDBUpdater }

uses System.SysUtils, System.StrUtils, Sis.DB.Updater.Factory,
  Sis.Sis.constants, Sis.DB.Factory, Sis.DB.Updater.Constants_u,
  Sis.DB.Updater_u_GetStrings, Sis.DB.Updater.Comando, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.Types.TStrings_u, Sis.Types.strings.Crypt_u,
  Sis.Win.Utils_u, Sis.ui.io.Files, Sis.Win.Execute, Sis.Win.Factory,
  Sis.DB.Updater.Diretivas_u, Sis.Entities.Terminal, Sis.Types.Bool_u;

constructor TDBUpdater.Create(pTerminalId: TTerminalId;
  pDBConnectionParams: TDBConnectionParams; pPastaProduto: string; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput;
  pLoja: ILoja; pUsuarioGerente: IUsuario; pTerminalList: ITerminalList);
var
  sSql: string;
begin
  FTerminalId := pTerminalId;
  FTerminalList := pTerminalList;
  FDBUpdaterAlvo := TerminalIdToAlvo(FTerminalId);
  FsDBUpdaterAlvo := UpperCase(DBUpdaterAlvoNomes[FDBUpdaterAlvo]);

  FPastaProduto := pPastaProduto;
  FSqlDestinoSL := TStringList.Create;
  FDBConnectionParams := pDBConnectionParams;
  FSisConfig := pSisConfig;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FDBMS := pDBMS;
  FLoja := pLoja;
  FUsuarioGerente := pUsuarioGerente;
  FCriouDB := False;

  FProcessLog.PegueLocal('TDBUpdater.Create');

  try
    FCaminhoComandos := FPastaProduto + 'Inst\Update\DBUpdates\';

    FProcessLog.RegistreLog('FDBConnectionParams.Database=' +
      FDBConnectionParams.Database + ',FCaminhoComandos=' + FCaminhoComandos);

    FDBConnection := DBConnectionCreate('UpdaterDBConnection', FSisConfig,
      FDBMS, FDBConnectionParams, FProcessLog, FOutput);

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
begin
  Result := 0;
  FProcessLog.PegueLocal('TDBUpdater.DBDescubraVersaoEConecte');
  try
    FProcessLog.RegistreLog('vai GetDBExiste, testar se o banco existe');
    if not GetDBExiste then
    begin
      FProcessLog.RegistreLog('banco nao existia, vai CrieDB');
      CrieDB;
      FCriouDB := True;
      FProcessLog.RegistreLog
        ('vai novamente GetDBExiste, testar se o banco existe');
      if not GetDBExiste then
      begin
        sErro := 'TDBUpdater.DBDescubraVersaoEConecte,Erro ao criar banco de dados';
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
  finally
    FProcessLog.RetorneLocal;
  end;
  inherited;
end;

procedure TDBUpdater.DireitivasAjustaCaracteres;
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
  sPastaBin := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  sPastaExe := PastaAcima(sPastaBin);
  sPastaEventos := sPastaExe + 'Comandos\Eventos\';

  GarantirPasta(sPastaEventos);

  sNomeArqBat := sPastaEventos + 'Exec Apos Criar DB.bat';

  if not FileExists(sNomeArqBat) then
    exit;

  OWinExecute := WinExecuteCreate(sNomeArqBat, '', sPastaEventos, True, 1);
  OWinExecute.EspereExecucao(output, 16);
  // C:\Pr\app\bantu\bantu-sis\Exe\Comandos\Eventos\Exec Apos Criar DB.bat
end;

function TDBUpdater.Execute: Boolean;
var
  sVariaveis: string;
  bSeAplica: Boolean;
begin
  Result := True;
  FProcessLog.PegueLocal('TDBUpdater.Execute');
  DireitivasAjustaCaracteres;
  FLinhasSL := TStringList.Create;
  try
    try
      FProcessLog.RegistreLog('vai iVersao := DBDescubraVersaoEConecte');
      iVersao := DBDescubraVersaoEConecte;
      FProcessLog.RegistreLog('iVersao' + iVersao.ToString);
      try
        repeat
          FOutput.Exibir('');
          iVersao := iVersao + 1;
          FOutput.Exibir('Versao=' + iVersao.ToString);

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
          // teste
          // FLinhasSL.LoadFromFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\origem com diretivas.txt');
          //
          // ProcessarDiretivas(FLinhasSL,
          // 'ALVO=TERMINAL'#13#10'TERMINAL_ID=1', '{', '}');
          // FLinhasSL.SaveToFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\destino terminal.txt');
          //
          // FLinhasSL.LoadFromFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\origem com diretivas.txt');
          // ProcessarDiretivas(FLinhasSL,
          // 'ALVO=SERVIDOR'#13#10'TERMINAL_ID=1', '{', '}');
          // FLinhasSL.SaveToFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\Testes\Teste Diretivas\destino servidor.txt');
          //
          // Halt(0);
          // fim do teste            testar acima, add aqui terminal_id=

          sVariaveis := //
            'ALVO=' + FsDBUpdaterAlvo + #13#10 + //
            'TERMINAL_ID=' + FTerminalId.ToString + #13#10 //
            ; //

          ProcessarDiretivas(FLinhasSL, sVariaveis, FsDiretivaAbre,
            FsDiretivaFecha);
          LerUpdateProperties(FLinhasSL);

          bSeAplica := SeAplica(FTerminalId, FDBAtualizAlvo);

          if bSeAplica then
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
    if not SisConfig.LocalMachineIsServer then
      exit;

    if FCriouDB then
      DoAposCriarBanco;
    // podeaqui
    GravarIniciais(DBConnection);
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

    FsDBAtualizAlvo := pSL.Values[DBATUALIZ_ALVO_CHAVE];
    sOutput := sOutput + 'sAlvo=' + FsDBAtualizAlvo + #13#10;

    FDBAtualizAlvo := StrToAlvo(FsDBAtualizAlvo);

    FsObs := pSL.Values[DBATUALIZ_OBS_CHAVE];
    sOutput := sOutput + 'sObs=' + FsObs + #13#10;

    sLog := sOutput;
    FOutput.Exibir(sOutput);
  finally
    FProcessLog.RegistreLog(sLog);
    FProcessLog.RetorneLocal;
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
      else if Pos(DBATUALIZ_COMANDO_ALVO + '=', sLin) = 1 then
      begin
        bSeAplica := ComandoSeAplica(FTerminalId, sLin);
      end
      else if Pos(DBATUALIZ_COMANDO_TIPO + '=', sLin) = 1 then
      begin
        if bSeAplica then
        begin
          sTipoComando := StrApos(sLin, '=');
          FProcessLog.RegistreLog('sTipoComando=' + sTipoComando);
          oComando := TipoToComando(sTipoComando, FDBConnection,
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
  I, iQtdComandos: integer;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosGetSql');
  try
    FOutput.Exibir('Montando comandos...');
    FSqlDestinoSL.Clear;
    iQtdComandos := 0;

    for I := 0 to FComandoList.Count - 1 do
    begin
      oComando := FComandoList[I];
      sComandosSql := oComando.GetAsSql;
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
  I: integer;
  Resultado: Boolean;
  sMensagemErro: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosTesteFuncionou');
  try
    FOutput.Exibir('Testando os comandos...');

    for I := 0 to FComandoList.Count - 1 do
    begin
      oComando := FComandoList[I];
      Resultado := oComando.Funcionou;
      if not Resultado then
      begin
        sMensagemErro := 'Erro DB UPDATER, vr ' + iVersao.ToString + ', ' +
          oComando.UltimoErro;
        // Sis.ui.io.output.exibirpausa.form_u.Exibir(sMensagemErro,
        // TMsgDlgType.mtError);
        FProcessLog.PegueLocal(sMensagemErro);
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

    dbms.ExecInterative(sAssunto, sSql, sNomeBanco, sPastaComandos,
      FProcessLog, FOutput);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.GravarIniciais(pDBConnection: IDBConnection);
var
  sSenha: string;
  iPessoaId: integer;
  oTerminal: ITerminal;
  i: integer;
  sSql: string;
begin
  // loja inicio
  if FLoja.Descr <> '' then
  begin
    sSql := 'EXECUTE PROCEDURE LOJA_INICIAL_PA.GARANTIR(' //
      + FLoja.Id.ToString + ',' //
      + FLoja.Descr.QuotedString + ', TRUE);' //
      ; //

    pDBConnection.ExecuteSql(sSql);

    sSql := 'SELECT GEN_ID(PESSOA_SEQ, 1) FROM RDB$DATABASE;';
    iPessoaId := pDBConnection.GetValueInteger(sSql);

    sSql := 'INSERT INTO PESSOA (LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME, APELIDO' //
      + ') VALUES (' //
      + FLoja.Id.ToString //
      + ', 0' //
      + ', ' + iPessoaId.ToString + ', ' + QuotedStr('') + ', ' +
      FLoja.Descr.QuotedString + ');';
    pDBConnection.ExecuteSql(sSql);

    sSql := 'INSERT INTO LOJA_EH_PESSOA (LOJA_ID, TERMINAL_ID, PESSOA_ID' //
      + ') VALUES (' //
      + FLoja.Id.ToString //
      + ', 0' //
      + ', ' + iPessoaId.ToString + ');';
    pDBConnection.ExecuteSql(sSql);
  end;
  // loja fim

  if FUsuarioGerente.NomeCompleto <> '' then
  begin
    Encriptar(1, '123', sSenha);

    sSql := 'SELECT PESSOA_ID_RET FROM USUARIO_PA.GARANTIR_NOMES(' //
      + FLoja.Id.ToString // LOJA_ID
      + ', ' + 'SUPORTE TECNICO'.QuotedString // NOME
      + ', ' + 'SUP'.QuotedString // NOME_DE_USUARIO
      + ', ' + sSenha.QuotedString // SENHA
      + ', 1' // CRY_VER
      + ', ' + 'SUPORTE'.QuotedString // APELIDO
      + ', NULL);';

    iPessoaId := pDBConnection.GetValue(sSql);

    sSql := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_DE_USO_GARANTIR(' //
      + FLoja.Id.ToString // LOJA_ID
      + ', ' + iPessoaId.ToString // PESSOA_ID
      + ', 1' // PERFIL_DE_USO_ID
      + ');';

    pDBConnection.ExecuteSql(sSql);

    Encriptar(1, FUsuarioGerente.Senha, sSenha);

    sSql := 'SELECT PESSOA_ID_RET FROM USUARIO_PA.GARANTIR_NOMES(' //
      + FLoja.Id.ToString // LOJA_ID
      + ', ' + FUsuarioGerente.NomeCompleto.QuotedString // NOME
      + ', ' + FUsuarioGerente.NomeDeUsuario.QuotedString // NOME_DE_USUARIO
      + ', ' + sSenha.QuotedString // SENHA
      + ', 1' // CRY_VER
      + ', ' + FUsuarioGerente.NomeExib.QuotedString // APELIDO
      + ', NULL);';

    iPessoaId := pDBConnection.GetValue(sSql);

    sSql := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_DE_USO_GARANTIR(' //
      + FLoja.Id.ToString // LOJA_ID
      + ', ' + iPessoaId.ToString // PESSOA_ID
      + ', 2' // PERFIL_DE_USO_ID
      + ');';

    pDBConnection.ExecuteSql(sSql);
  end;


  sSql := 'DELETE FROM TERMINAL;';
  pDBConnection.ExecuteSql(sSql);

  for i := 0 to FTerminalList.Count - 1 do
  begin
    oTerminal := FTerminalList[i];
    sSql := 'INSERT INTO TERMINAL (' //
      + 'TERMINAL_ID,' //
      + 'APELIDO,' //
      + 'NOME_NA_REDE,' //
      + 'NF_SERIE,' //
      + 'LETRA_DO_DRIVE,' //
      + 'GAVETA_TEM,' //
      + 'BALANCA_MODO_ID,' //
      + 'BALANCA_ID,' //
      + 'BARRAS_COD_INI,' //
      + 'BARRAS_COD_TAM,' //
      + 'CUPOM_NLINS_FINAL,' //
      + 'SEMPRE_OFFLINE' //
      + ') VALUES (' //
      + oTerminal.TerminalId.ToString //
      + ', ' + oTerminal.Apelido.QuotedString //
      + ', ' + oTerminal.NomeDaRede.QuotedString //
      + ', ' + oTerminal.NFSerie.ToString //
      + ', ' + oTerminal.LetraDoDrive.QuotedString //
      + ', ' + BooleanToStrSQL(oTerminal.GavetaTem) //
      + ', ' + oTerminal.BalancaModoId.ToString //
      + ', ' + oTerminal.BalancaId.ToString //
      + ', ' + oTerminal.BarCodigoIni.ToString //
      + ', ' + oTerminal.BarCodigoTam.ToString //
      + ', ' + oTerminal.CupomNLinsFinal.ToString //
      + ', ' + BooleanToStrSQL(oTerminal.SempreOffLine) //
      + ');'; //

    pDBConnection.ExecuteSql(sSql);
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
    SLManterEntre(pSL, DBATUALIZ_INI_CHAVE, DBATUALIZ_FIM_CHAVE);
    // SLRemoveVazias(FLinhasSL);
    SLUpperCase(FLinhasSL);
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
  sVersaoPad: string;
  sSubPastaComando: string;
  sPastaComando: string;
  sNomeCompleto: string;
  sNomeArq: string;
begin
  sVersaoPad := IntToStrZero(pVersao, 9);

  sSubPastaComando := LeftStr(sVersaoPad, 6);
  Insert('\', sSubPastaComando, 4);

  sPastaComando := FCaminhoComandos + sSubPastaComando + '\';
  ForceDirectories(sPastaComando);

  sNomeArq := sPastaComando + 'dbupdate ' + sVersaoPad + '.txt';
  Result := sNomeArq;
end;

end.
