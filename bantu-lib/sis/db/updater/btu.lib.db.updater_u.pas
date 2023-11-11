unit btu.lib.db.updater_u;

interface

uses
  btu.lib.db.updater, btu.lib.config, sis.ui.io.LogProcess, sis.ui.io.output,
  btu.lib.db.types, btu.lib.db.dbms, System.Classes, Vcl.Dialogs,
  btu.lib.db.updater.comando.list, sis.ui.io.output.exibirpausa.form_u,
  btu.lib.db.updater.operations;

type
  TDBUpdater = class(TInterfacedObject, IDBUpdater)
  private
    FsLocalDoDB: string;
    FLocalDoDB: TLocalDoDB;
    FSisConfig: ISisConfig;
    FLogProcess: ILogProcess;
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
    property LogProcess: ILogProcess read FLogProcess;
    property Output: IOutput read FOutput;
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
      pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput);
    destructor Destroy; override;
  end;

implementation

{ TDBUpdater }

uses sis.types.integers, System.SysUtils, System.StrUtils,
  btu.lib.db.factory, sis.types.str.TStrings_u, sis.sis.constants,
  btu.lib.db.updater.constants_u, btu.lib.db.updater.comando,
  btu.lib.db.updater.factory, btu.sis.db.updater.utils, sis.types.strings;

constructor TDBUpdater.Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput);
var
  sSql: string;
begin
  FDestinoSL := TStringList.Create;
  FLocalDoDB := pLocalDoDB;
  FsLocalDoDB := TiposDeLocalDB[pLocalDoDB];
  FSisConfig := pSisConfig;
  FLogProcess := pLogProcess;
  FOutput := pOutput;
  FDBMS := pDBMS;

  FCaminhoComandos := FSisConfig.PastaProduto + 'Starter\Update\dbupdates\';

  FLogProcess.Exibir('TDBUpdater.Create FsLocalDoDB=' + FsLocalDoDB +
    ',FCaminhoComandos=' + FCaminhoComandos);
  FDBConnection := DBConnectionCreate(FSisConfig, FDBMS, FLocalDoDB,
    FLogProcess, FOutput);

  FDBUpdaterOperations := GetDBUpdaterOperations(FDBConnection, FLogProcess, FOutput);

  FComandoList := ComandoListCreate;

  FLogProcess.Exibir('TDBUpdater.Create fim');
end;

function TDBUpdater.DBDescubraVersaoEConecte: integer;
var
  sErro: string;
begin
  Result := 0;
  FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte inicio');
  try
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte, vai testar se o banco existe');
    if not GetDBExiste then
    begin
      FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte,banco nao existia');
      CrieDB;
      if not GetDBExiste then
      begin
        sErro := 'TDBUpdater.DBDescubraVersaoEConecte,Erro ao criar banco de dados';
        FLogProcess.Exibir(sErro);
        raise Exception.Create(sErro);
      end;
    end
    else
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte,banco existia,vai abrir conexao');

    DBConnection.Abrir;
    FDBUpdaterOperations.PreparePrincipais;
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte,vai testar se tabela ' + NOMETAB_DBUPDATE_HIST + ' existe');
    if not FDBUpdaterOperations.TabelaExiste(NOMETAB_DBUPDATE_HIST) then
    begin
      FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte,nao existia,vr=-1');
      Result := -1;
      exit;
    end;
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte, existia,vai ler com versao_get');

    Result := FDBUpdaterOperations.VersaoGet;
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte, FDBUpdaterOperations.VersaoGet=' + Result.ToString);
  finally
    FLogProcess.Exibir('TDBUpdater.DBDescubraVersaoEConecte fim');
  end;
end;

destructor TDBUpdater.Destroy;
begin
  FLogProcess.Exibir('TDBUpdater.Destroy, FsLocalDoDB=' + FsLocalDoDB);
  FDestinoSL.Free;
  inherited;
end;

function TDBUpdater.Execute: boolean;
var
  s: string;
begin
  s := 'TDBUpdater.Execute,Inicio,FsLocalDoDB=' + FsLocalDoDB +
    ',FCaminhoComandos=' + FCaminhoComandos;

  FLogProcess.Exibir(s);

  Result := True;

  FLinhasSL := TStringList.Create;
  try
    try
      s := 'TDBUpdater.Execute,vai DBDescubraVersaoEConecte';
      FLogProcess.Exibir(s);
      iVersao := DBDescubraVersaoEConecte;
      s := 'TDBUpdater.Execute,fez prepare,iVersao=' + iVersao.ToString;
      FLogProcess.Exibir(s);
      try
        repeat
          FOutput.Exibir('');
          iVersao := iVersao + 1;

          s := 'TDBUpdater.Execute,incrementou iVersao=' + iVersao.ToString +
            ',vai CarreguouArqComando';
          FLogProcess.Exibir(s);

          if not CarreguouArqComando(iVersao) then
          begin
            s := 'TDBUpdater.Execute,CarreguouArqComando retornou False'
              +', vai abortar o loop';
            FLogProcess.Exibir(s);
            break;
          end;
          FLogProcess.Exibir('TDBUpdater.Execute,retornou True');

          FDtHExec := Now;
          RemoveExcedentes(FLinhasSL);
          LerUpdateProperties(FLinhasSL);

          FLogProcess.Exibir('TDBUpdater.Execute,vai ComandosCarregar');
          ComandosCarregar;

          FLogProcess.Exibir('TDBUpdater.Execute,vai ComandosGetSql');
          ComandosGetSql;

          FLogProcess.Exibir('TDBUpdater.Execute,vai ExecuteSql');
          ExecuteSql;

          FLogProcess.Exibir('TDBUpdater.Execute,vai ComandosTesteFuncionou');
          ComandosTesteFuncionou;

          FLogProcess.Exibir('TDBUpdater.Execute,vai GravarVersao');
          GravarVersao;

        until False;
      finally
        FLogProcess.Exibir('TDBUpdater.Execute,vai FDBUpdaterOperations.Unprepare');
        FDBUpdaterOperations.Unprepare;
      end;
    except
      on E: Exception do
      begin
        FOutput.Exibir('vr. ' + iVersao.ToString + E.Message);
        FLogProcess.Exibir('TDBUpdater.Execute,erro vr. ' + iVersao.ToString + E.Message);
        // DBConnection.Rollback;
      end;
    end;
  finally
    FLogProcess.Exibir('TDBUpdater.Execute,fechando DBConnection e saindo');

    DBConnection.Fechar;
    FreeAndNil(FLinhasSL);
    FOutput.Exibir('TDBUpdater.Execute,Fim');
  end;
end;

procedure TDBUpdater.InsertCabecalho;
var
  sLinhas: string;
begin
  sLinhas := '/*'#13#10 + 'SCRIPT CRIADO AUTOMATICAMENTE'#13#10 +
    'ATUALIZA BANCO DE DADOS PARA A VERSAO: ' + iVersao.ToString + #13#10 +
    'ASSUNTO: ' + FsAssunto + #13#10 + 'OBJETIVO: ' + FsObjetivo + #13#10;
  if FsObs <> '' then
    sLinhas := sLinhas + 'OBS: ' + FsObs + #13#10;

  sLinhas := sLinhas + FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', FDtHExec) +
    #13#10 + '*/'#13#10 + #13#10 + 'CONNECT ''' + dbms.LocalDoDBToDatabase
    (FLocalDoDB) + ''' USER ''sysdba'' PASSWORD ''masterkey'';'#13#10 + #13#10;

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
  FLogProcess.Exibir(sLog);
end;

function TDBUpdater.CarreguouArqComando(piVersao: integer): boolean;
var
  sNomeArq: string;
  sLog: string;
begin
  sLog := 'TDBUpdater.Execute,iVersao=' + piVersao.ToString;
  try
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
    FLogProcess.Exibir(sLog);
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
  FLogProcess.Exibir('TDBUpdater.ComandosCarregar,ini;');
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
        oComando := TipoToComando(sTipoComando, FDBConnection,
          FDBUpdaterOperations, FLogProcess, FOutput);
        FComandoList.Add(oComando);
        oComando.PegarLinhas(iLin, FLinhasSL);
      end;

      inc(iLin);
    end;
  finally
    FLogProcess.Exibir('TDBUpdater.ComandosCarregar,fim;');
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
    oComando := FComandoList[I];
    Resultado := oComando.Funcionou;
    if not Resultado then
    begin
      sMensagemErro := 'Erro DB UPDATER, vr ' + iVersao.ToString + ', ' +
        oComando.UltimoErro;
      sis.ui.io.output.exibirpausa.form_u.Exibir(sMensagemErro,
        TMsgDlgType.mtError);
      raise Exception.Create(sMensagemErro);
    end;
  end;

  FOutput.Exibir('Testes Ok');
end;

procedure TDBUpdater.ExecuteSql;
begin
  FOutput.Exibir('Executando comandos...');
  dbms.ExecInterative('DBUpdate ' + IntToStrZero(iVersao, 9), FDestinoSL.Text,
    FLocalDoDB, FLogProcess, FOutput);
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
  // SLRemoveVazias(FLinhasSL);
  SLUpperCase(FLinhasSL);
  sLog := sLog + ',sobraram ' + pSL.Count.ToString + ' linhas,';
  FLogProcess.Exibir(sLog);
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
