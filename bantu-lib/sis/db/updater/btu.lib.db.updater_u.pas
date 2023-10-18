unit btu.lib.db.updater_u;

interface

uses
  btu.lib.db.updater, btu.lib.config, btu.sis.ui.io.log, btu.sis.ui.io.output,
  btu.lib.db.types, btu.lib.db.dbms, System.Classes, Vcl.Dialogs,
  btu.lib.db.updater.comando.list, btu.sis.ui.io.output.exibirpausa.form_u,
  btu.lib.db.updater.operations;

type
  TDBUpdater = class(TInterfacedObject, IDBUpdater)
  private
    FsLocalDoDB: string;
    FLocalDoDB: TLocalDoDB;
    FSisConfig: ISisConfig;
    FLog: ILog;
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
    property sLocalDoDB: string read FsLocalDoDB;
    property SisConfig: ISisConfig read FSisConfig;
    property log: ILog read FLog;
    property output: IOutput read FOutput;
    property LocalDoDB: TLocalDoDB read FLocalDoDB;
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

  public
    function Execute: boolean;

    constructor Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
      pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput);
    destructor Destroy; override;
  end;

implementation

{ TDBUpdater }

uses btn.lib.types.integers, System.SysUtils, System.StrUtils,
  btu.lib.db.factory, btn.lib.types.str.TStrings_u, btu.lib.sis.constants,
  btu.lib.db.updater.constants_u, btu.lib.db.updater.comando,
  btu.lib.db.updater.factory, btu.sis.db.updater.utils, btn.lib.types.strings;

constructor TDBUpdater.Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput);
var
  sLog: string;
  sSql: string;
begin
  FDestinoSL := TStringList.Create;
  FLocalDoDB := pLocalDoDB;
  FsLocalDoDB := TiposDeLocalDB[pLocalDoDB];
  FSisConfig := pSisConfig;
  FLog := pLog;
  FOutput := pOutput;
  FDBMS := pDBMS;
  sLog := classname + '.Create,' + FsLocalDoDB;
  FCaminhoComandos := FSisConfig.PastaProduto + 'inst\dbupdates\';

  FDBConnection := DBConnectionCreate(FSisConfig, FDBMS, FLocalDoDB,
    FLog, FOutput);

  FDBUpdaterOperations := GetDBUpdaterOperations(FDBConnection, FLog, FOutput);

  FComandoList := ComandoListCreate;
end;

function TDBUpdater.DBDescubraVersaoEConecte: integer;
var
  sErro, sLog: string;
begin
  Result := 0;
  sLog := 'TDBUpdater.DBDescubraVersaoEConecte';
  try
    sLog := sLog + ', vai testar se o banco existe';
    if not GetDBExiste then
    begin
      sLog := sLog + ',banco nao existia';
      CrieDB;
      sleep(100);
      if not GetDBExiste then
      begin
        sErro := 'Error ao criar banco de dados';
        sLog := sLog + sErro;
        raise Exception.Create(sErro);
      end;
    end
    else
      sLog := sLog + ',banco existia';

    DBConnection.Abrir;
    FDBUpdaterOperations.PreparePrincipais;
    sLog := sLog + ',tab ' + NOMETAB_DBUPDATE_HIST + ' vai testar se existe';
    if not FDBUpdaterOperations.TabelaExiste(NOMETAB_DBUPDATE_HIST) then
    begin
      sLog := sLog + ', nao existia,vr=-1';
      Result := -1;
      exit;
    end;
    sLog := sLog + ', existia,vai ler com versao_get';

    Result := FDBUpdaterOperations.VersaoGet;
  finally
    log.Exibir(sLog);
    output.Exibir(sLog);
  end;
end;

destructor TDBUpdater.Destroy;
var
  sLog: string;
begin
  sLog := classname + '.Destroy,' + FsLocalDoDB;
  FLog.Exibir(sLog);
  FOutput.Exibir(sLog);
  FDestinoSL.Free;
  inherited;
end;

function TDBUpdater.Execute: boolean;
begin
  FOutput.Exibir('TDBUpdater.Execute,Inicio');
  FLog.Exibir('TDBUpdater.Execute,Inicio');
  FLog.Exibir('TDBUpdater.Execute,FsLocalDoDB=' + FsLocalDoDB);

  FLinhasSL := TStringList.Create;
  try
    try
      iVersao := DBDescubraVersaoEConecte;

      try
        repeat
          FOutput.Exibir('');
          iVersao := iVersao + 1;

          if not CarreguouArqComando(iVersao) then
            break;

          FDtHExec := Now;
          RemoveExcedentes(FLinhasSL);
          LerUpdateProperties(FLinhasSL);

          ComandosCarregar;
          ComandosGetSql;
          ExecuteSql;
          ComandosTesteFuncionou;
          GravarVersao;

        until False;
      finally
        FDBUpdaterOperations.Unprepare;
      end;
    except
      on E: Exception do
      begin
        FLog.Exibir('vr. ' + iVersao.ToString + E.Message);
        FOutput.Exibir('vr. ' + iVersao.ToString + E.Message);
        //DBConnection.Rollback;
      end;
    end;
  finally
    FLog.Exibir('TDBUpdater.Execute,fechando DBConnection e saindo');
    DBConnection.Fechar;
    FreeAndNil(FLinhasSL);
    FLog.Exibir('TDBUpdater.Execute,Fim');
    FOutput.Exibir('TDBUpdater.Execute,Fim');
  end;
end;

procedure TDBUpdater.InsertCabecalho;
var
  sLinhas: string;
begin
  sLinhas :=
    '/*'#13#10
    + 'SCRIPT CRIADO AUTOMATICAMENTE'#13#10
    + 'ATUALIZA BANCO DE DADOS PARA A VERSAO: '+iVersao.ToString + #13#10
    + 'ASSUNTO: '+FsAssunto + #13#10
    + 'OBJETIVO: '+FsObjetivo + #13#10
    ;
  if FsObs <> '' then
    sLinhas := sLinhas + 'OBS: '+FsObs + #13#10;

  sLinhas := sLinhas
    + FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtHExec) + #13#10
    + '*/'#13#10
    + #13#10
    + 'CONNECT ''' + dbms.LocalDoDBToDatabase(FLocalDoDB)
      + ''' USER ''sysdba'' PASSWORD ''masterkey'';'#13#10
    + #13#10
    ;

  FDestinoSL.Text := sLinhas + FDestinoSL.Text;
end;

procedure TDBUpdater.LerUpdateProperties(pSL: TStrings);
var
  sLog: string;
  sOutput: string;
begin
  sLog := 'TDBUpdater.LerUpdateProperties,';
  sOutput := '';

  FsAssunto := pSL.Values[DBATUALIZ_ASSUNTO_CHAVE];
  sOutput := sOutput + 'FsAssunto=' + FsAssunto + #13#10;

  FsObjetivo := pSL.Values[DBATUALIZ_OBJETIVO_CHAVE];
  sOutput := sOutput + 'sObjetivo=' + FsObjetivo + #13#10;

  FsObs := pSL.Values[DBATUALIZ_OBS_CHAVE];
  sOutput := sOutput + 'sObs=' + FsObs + #13#10;

  sLog := sLog + #13#10 + sOutput;
  FOutput.Exibir(sOutput);
  FLog.Exibir(sLog);
end;

function TDBUpdater.CarreguouArqComando(piVersao: integer): boolean;
var
  sNomeArq: string;
begin
  FLog.Exibir('TDBUpdater.Execute,iVersao=' + piVersao.ToString);

  sNomeArq := VersaoToArqComando(piVersao);

  FLog.Exibir('TDBUpdater.Execute,sNomeArqComando=' + sNomeArq);
  Result := FileExists(sNomeArq);

  if not Result then
  begin
    FLog.Exibir('TDBUpdater.Execute,arq nao encontrado, abortando');
    exit;
  end;
  FOutput.Exibir('iVersao=' + piVersao.ToString);

  FLog.Exibir('TDBUpdater.Execute,arq encontrado, vai carregar');

  FLinhasSL.LoadFromFile(sNomeArq);
  Result := FLinhasSL.Text <> '';

  if not Result then
  begin
    FLog.Exibir('TDBUpdater.Execute,arquivo estava vazio, abortando');
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
  FLog.Exibir('TDBUpdater.ComandosCarregar,ini;');
  FOutput.Exibir('Carregando comandos...');

  try
    bComandAberto := false;
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
        bComandAberto := false;
      end
      else if Pos(DBATUALIZ_TIPO_COMANDO + '=', sLin) = 1 then
      begin
        sTipoComando := StrApos(sLin, '=');
        oComando := TipoToComando(sTipoComando, FDBConnection, FDBUpdaterOperations, FLog, FOutput);
        FComandoList.Add(oComando);
        oComando.PegarLinhas(iLin, FLinhasSL);
      end;

      inc(iLin);
    end;
  finally
    FLog.Exibir('TDBUpdater.ComandosCarregar,fim;');
  end;
end;

procedure TDBUpdater.ComandosGetSql;
var
  oComando: IComando;
  sComandosSql: string;
  I: integer;
  bTeveComando: boolean;
begin
  FOutput.Exibir('Montando comandos...');
  FDestinoSL.Clear;
  bTeveComando := False;

  for I := 0 to FComandoList.Count - 1 do
  begin
    oComando := FComandoList[I];
    sComandosSql := oComando.GetAsSql;
    if sComandosSql <> '' then
    begin
      bTeveComando := True;
      FDestinoSL.Text := FDestinoSL.Text + sComandosSql;
    end;
  end;

  if bTeveComando then
    InsertCabecalho;
end;

procedure TDBUpdater.ComandosTesteFuncionou;
var
  oComando: IComando;
  I: integer;
  Resultado: boolean;
  sMensagemErro: string;
begin
  FOutput.Exibir('Testando os comandos...');

  for I := 0 to FComandoList.Count - 1 do
  begin
    //sLEEP(200);
    oComando := FComandoList[I];
    Resultado := oComando.Funcionou;
    if not Resultado then
    begin
      sMensagemErro := 'Erro DB UPDATER, vr ' + iVersao.ToString + ', ' +
        oComando.UltimoErro;
      btu.sis.ui.io.output.exibirpausa.form_u.Exibir(sMensagemErro, TMsgDlgType.mtError);
      raise Exception.Create(sMensagemErro);
    end;
  end;

  FOutput.Exibir('Testes Ok');
end;

procedure TDBUpdater.ExecuteSql;
begin
  FOutput.Exibir('Executando comandos...');
  dbms.ExecInterative('DBUpdate ' + IntToStrZero(iVersao, 9),
    FDestinoSL.Text, FLocalDoDB, FLog, FOutput);
end;

procedure TDBUpdater.GravarVersao;
begin
  FDBUpdaterOperations.PrepareVersoes;

  FDBUpdaterOperations.HistIns(FiVersao, FsAssunto, FsObjetivo, FsObs);
end;

procedure TDBUpdater.RemoveExcedentes(pSL: TStrings);
var
  sLog: string;
begin
  sLog := 'TDBUpdater.RemoveExcedentes,' + pSL.Count.ToString + ' linhas,';
  SLRemoveCommentsSingleLine(pSL);
  SLRemoveCommentsMultiLine(pSL);
  SLManterEntre(pSL, DBATUALIZ_INI_CHAVE, DBATUALIZ_FIM_CHAVE);
  //SLRemoveVazias(FLinhasSL);
  SLUpperCase(FLinhasSL);
  sLog := sLog + ',sobraram ' + pSL.Count.ToString + ' linhas,';
  FLog.Exibir(sLog);
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
begin
  sVersaoPad := IntToStrZero(pVersao, 9);

  sSubPastaComando := LeftStr(sVersaoPad, 6);
  Insert('\', sSubPastaComando, 4);

  sPastaComando := FCaminhoComandos + sSubPastaComando + '\';
  ForceDirectories(sPastaComando);

  Result := sPastaComando + 'dbupdate ' + sVersaoPad + '.txt';
end;

end.
