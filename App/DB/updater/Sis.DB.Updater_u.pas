unit Sis.DB.Updater_u;

interface

uses
  Sis.DB.Updater, Sis.ui.io.output, System.Classes, Vcl.Dialogs,
  Sis.Config.SisConfig,
  Sis.ui.io.output.ProcessLog, Sis.DB.DBTypes, Sis.DB.Updater.Comando.List,
  Sis.DB.Updater.Operations;

type
  TDBUpdater = class(TInterfacedObject, IDBUpdater)
  private
    FDBConnectionParams: TDBConnectionParams;
    FSisConfig: ISisConfig;
    FProcessLog: IProcessLog;
    FOutput: IOutput;
    FDBMS: IDBMS;
    FiVersao: integer;
    FCaminhoComandos: string;
    FLinhasSL: TStringList;
    FDtHExec: TDateTime;
    FDestinoSL: TStringList;
    FsAssunto: string;
    FsObjetivo: string;
    FsObs: string;
    FComandoList: IComandoList;
    FPastaProduto: string;
    FDBConnection: IDBConnection;

    FDBUpdaterOperations: IDBUpdaterOperations;

    procedure SetiVersao(const Value: integer);

    function CarreguouArqComando(piVersao: integer): boolean;
    procedure RemoveExcedentes(pSL: TStrings);
    procedure LerUpdateProperties(pSL: TStrings);

    procedure ComandosCarregar;
    procedure ComandosGetSql;
    procedure InsertCabecalho;
    procedure ExecuteSql;
    procedure ComandosTesteFuncionou;
    procedure GravarVersao;
  protected
    property SisConfig: ISisConfig read FSisConfig;
    property ProcessLog: IProcessLog read FProcessLog;
    property output: IOutput read FOutput;
    property dbms: IDBMS read FDBMS;
    property iVersao: integer read FiVersao write SetiVersao;
    function GetDBExiste: boolean; virtual; abstract;
    function DBDescubraVersaoEConecte: integer; virtual;
    property LinhasSL: TStringList read FLinhasSL;

    function VersaoToArqComando(pVersao: integer): string;

    function GetNomeBanco: string; virtual; abstract;
    property NomeBanco: string read GetNomeBanco;
    procedure CrieDB; virtual; abstract;

    property DBConnection: IDBConnection read FDBConnection;
    property DBConnectionParams: TDBConnectionParams read FDBConnectionParams;
    property PastaProduto: string read FPastaProduto;

  public
    function Execute: boolean;

    constructor Create(pDBConnectionParams: TDBConnectionParams;
      pPastaProduto: string; pDBMS: IDBMS; pSisConfig: ISisConfig;
      pProcessLog: IProcessLog; pOutput: IOutput);
    destructor Destroy; override;
  end;

implementation

{ TDBUpdater }

uses System.SysUtils, System.StrUtils, Sis.DB.Updater.Factory,
  Sis.Sis.constants, Sis.DB.Factory, Sis.DB.Updater.Constants_u,
  Sis.DB.Updater_u_GetStrings, Sis.DB.Updater.Comando, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.Types.TStrings_u;

constructor TDBUpdater.Create(pDBConnectionParams: TDBConnectionParams;
  pPastaProduto: string; pDBMS: IDBMS; pSisConfig: ISisConfig;
  pProcessLog: IProcessLog; pOutput: IOutput);
var
  sSql: string;
begin
  FPastaProduto := pPastaProduto;
  FDestinoSL := TStringList.Create;
  FDBConnectionParams := pDBConnectionParams;
  FSisConfig := pSisConfig;
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FDBMS := pDBMS;

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
    FProcessLog.RegistreLog('FDestinoSL.Free');
    FDestinoSL.Free;
  finally
    FProcessLog.RetorneLocal;
  end;
  inherited;
end;

function TDBUpdater.Execute: boolean;
var
  s: string;
begin
  Result := True;
  FProcessLog.PegueLocal('TDBUpdater.Execute');
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
          LerUpdateProperties(FLinhasSL);

          FProcessLog.RegistreLog('ComandosCarregar');
          ComandosCarregar;

          FProcessLog.RegistreLog('ComandosGetSql');
          ComandosGetSql;

          FProcessLog.RegistreLog('ExecuteSql');
          ExecuteSql;

          FProcessLog.RegistreLog('ComandosTesteFuncionou');
          ComandosTesteFuncionou;

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
  finally
    FProcessLog.RegistreLog('DBConnection.Fechar');

    DBConnection.Fechar;
    FreeAndNil(FLinhasSL);
    FOutput.Exibir('TDBUpdater.Execute,Fim');
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.InsertCabecalho;
var
  sLinhas: string;
begin
  sLinhas := GetUpdaterCabecalho(iVersao, FsObjetivo, FsObs, FsAssunto,
    FDBConnectionParams.Database, FDtHExec);

  FDestinoSL.Text := sLinhas + FDestinoSL.Text;
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

    FsObjetivo := pSL.Values[DBATUALIZ_OBJETIVO_CHAVE];
    sOutput := sOutput + 'sObjetivo=' + FsObjetivo + #13#10;

    FsObs := pSL.Values[DBATUALIZ_OBS_CHAVE];
    sOutput := sOutput + 'sObs=' + FsObs + #13#10;

    sLog := sOutput;
    FOutput.Exibir(sOutput);
  finally
    FProcessLog.RegistreLog(sLog);
    FProcessLog.RetorneLocal;
  end;
end;

function TDBUpdater.CarreguouArqComando(piVersao: integer): boolean;
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
  bComandAberto: boolean;
  oComando: IComando;
  sTipoComando: string;
begin
  FProcessLog.PegueLocal('TDBUpdater.ComandosCarregar');
  FOutput.Exibir('Carregando comandos...');

  try
    bComandAberto := False;
    iLin := 0;
    FComandoList.Clear;
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
      end
      else if Pos(DBATUALIZ_TIPO_COMANDO + '=', sLin) = 1 then
      begin
        sTipoComando := StrApos(sLin, '=');
        FProcessLog.RegistreLog('sTipoComando=' + sTipoComando);
        oComando := TipoToComando(sTipoComando, FDBConnection,
          FDBUpdaterOperations, FProcessLog, FOutput);
        FComandoList.Add(oComando);
        oComando.PegarLinhas(iLin, FLinhasSL);
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
    FDestinoSL.Clear;
    iQtdComandos := 0;

    for I := 0 to FComandoList.Count - 1 do
    begin
      oComando := FComandoList[I];
      sComandosSql := oComando.GetAsSql;
      if sComandosSql <> '' then
      begin
        inc(iQtdComandos);
        FDestinoSL.Text := FDestinoSL.Text + sComandosSql;
      end;
    end;

    if iQtdComandos > 0 then
      InsertCabecalho;
  finally
    FProcessLog.RegistreLog('iQtdComandos='+iQtdComandos.ToString);
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.ComandosTesteFuncionou;
var
  oComando: IComando;
  I: integer;
  Resultado: boolean;
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
      //  Sis.ui.io.output.exibirpausa.form_u.Exibir(sMensagemErro,
//          TMsgDlgType.mtError);
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
    FProcessLog.RegistreLog('Executando '+iVersao.ToString);

    sAssunto := 'DBUpdate ' + IntToStrZero(iVersao, 9);
    sSql := FDestinoSL.Text;
    sNomeBanco := FDBConnectionParams.GetNomeBanco;
    sPastaComandos := FPastaProduto + 'Comandos\Updater\';

    dbms.ExecInterative(sAssunto, sSql, sNomeBanco, sPastaComandos,
      FProcessLog, FOutput);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBUpdater.GravarVersao;
begin
  FProcessLog.PegueLocal('TDBUpdater.GravarVersao');
  try
    FProcessLog.RegistreLog('FDBUpdaterOperations.PrepareVersoes');
    FDBUpdaterOperations.PrepareVersoes;

    FProcessLog.RegistreLog('FDBUpdaterOperations.HistIns');
    FDBUpdaterOperations.HistIns(FiVersao, FsAssunto, FsObjetivo, FsObs);
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
