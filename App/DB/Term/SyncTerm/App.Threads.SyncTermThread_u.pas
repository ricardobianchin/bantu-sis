unit App.Threads.SyncTermThread_u;

interface

uses App.Threads.TermThread_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  Sis.Threads.SafeBool, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.Threads.SyncTermThread_AddComandos,
  System.Generics.Collections;

type
  TAppSyncTermThread = class(TTermThread)
  private
    FServCon, FTermCon: IDBConnection;
    FLogIdIni, FLogIdFin: Int64;
    FDBExecScript: IDBExecScript;
    FAddCommandsList: TList<ISyncTermAddComandos>;
    function Conectou: boolean;
    procedure FecharConexoes;
    procedure Sync(pAtualIni, pAtualFIn: Int64);
    procedure AtualizeMachine;
  protected
    procedure RegistreAddComands(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pSql: TStrings); virtual;
    procedure Execute; override;

    procedure PegarFaixa(out FLogIdIni, FLogIdFin: Int64); virtual;

    property AddCommandsList: TList<ISyncTermAddComandos> read FAddCommandsList;
    property DBExecScript: IDBExecScript read FDBExecScript;
  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
    destructor Destroy; override;

  end;

implementation

uses System.SysUtils, Sis.Config.SisConfig, System.Math, App.Constants,
  App.Threads.SyncTermThread_u_PegarFaixa, App.Threads.SyncTermThread.Factory_u,
  Data.DB;

{ TAppSyncTermThread }

procedure TAppSyncTermThread.AtualizeMachine;
var
  iMaxTerm: integer;
  s: string;
  q: TDataSet;
begin
  s := 'select max(machine_id) from machine;';
  iMaxTerm := FTermCon.GetValueInteger(s);

  s := 'SELECT MACHINE_ID, NOME_NA_REDE, trim(IP) colip' + ' FROM MACHINE' +
    ' WHERE MACHINE_ID > ' + IntToStr(iMaxTerm) + ' ORDER BY MACHINE_ID';

  AppObj.CriticalSections.DB.Acquire;
  try
    FServCon.QueryDataSet(s, q);
  finally
    AppObj.CriticalSections.DB.Release;
  end;

  if not Assigned(q) then
    exit;

  try
    if q.IsEmpty then
      exit;

    Terminal.CriticalSections.DB.Acquire;
    try
      while not q.Eof do
      begin
        s := 'INSERT INTO MACHINE' + '(MACHINE_ID, NOME_NA_REDE, IP)' //
          + ' VALUES (' + q.Fields[0].AsInteger.ToString //
          + ', ' + QuotedStr(q.Fields[1].AsString) //
          + ', ' + QuotedStr(q.Fields[2].AsString.Trim) //
          + ');';
        FTermCon.ExecuteSQL(s);
        q.Next;
      end;
    finally
      Terminal.CriticalSections.DB.Release;
    end;
  finally
    FreeAndNil(q);
  end;

end;

function TAppSyncTermThread.Conectou: boolean;
var
  s: ISisConfig;
  rDBConnectionParams: TDBConnectionParams;

begin
  s := AppObj.SisConfig;

  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FServCon := DBConnectionCreate('TAppSyncTermThread.serv.con', s,
    rDBConnectionParams, ProcessLog, StatusOutput);

  rDBConnectionParams.Server := Terminal.NomeNaRede;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  FTermCon := DBConnectionCreate('TAppSyncTermThread.term.con', s,
    rDBConnectionParams, ProcessLog, StatusOutput);

  Result := FServCon.Abrir;
  if not Result then
    exit;

  Result := FTermCon.Abrir;
  if not Result then
  begin
    FServCon.Fechar;
    exit;
  end;
end;

constructor TAppSyncTermThread.Create(pTerminal: ITerminal; pAppObj: IAppObj;
  pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput; pStatusOutput: IOutput;
  pProcessLog: IProcessLog);
var
  sThreadTitulo: string;
begin
  sThreadTitulo := 'Sincronização ' + pTerminal.AsText;
  inherited Create(pTerminal, pAppObj, pExecutandoSafeBool, pTitOutput,
    pStatusOutput, pProcessLog, sThreadTitulo);
  FAddCommandsList := TList<ISyncTermAddComandos>.Create;
end;

destructor TAppSyncTermThread.Destroy;
begin
  FreeAndNil(FAddCommandsList);
  inherited;
end;

procedure TAppSyncTermThread.Execute;
var
  i, m: integer;
  iAtualIni, iAtualFIn: Int64;
begin
  // inherited;
  StatusOutput.Exibir('Iniciou');
  if Terminated then
    exit;
  if not Conectou then
    exit;
  try
    if Terminated then
      exit;

    FDBExecScript := DBExecScriptCreate('TAppSyncTermThread.ExecScript',
      FTermCon, ProcessLog, StatusOutput, Terminal.CriticalSections.DB);

    AtualizeMachine;

    RegistreAddComands(AppObj, Terminal, FServCon, FTermCon, FDBExecScript.Sql);

    PegarFaixa(FLogIdIni, FLogIdFin);

    if FLogIdIni = FLogIdFin then
      exit;

    iAtualIni := FLogIdIni;

    while iAtualIni <= FLogIdFin do
    begin
      if Terminated then
        exit;

      iAtualFIn := Min(FLogIdFin, iAtualIni + TERMINAL_SYNC_PASSO - 1);

      Sync(iAtualIni, iAtualFIn);

      Inc(iAtualIni, TERMINAL_SYNC_PASSO);
    end;
  finally
    FecharConexoes;
  end;
end;

{
  m := 5 + random(10);
  for i := 1 to m do
  begin
  OutputSafe(StatusOutput, i.ToString + '/' + m.ToString);
  if Terminated then
  break;
  Sleep(1000);
  end;
}

procedure TAppSyncTermThread.FecharConexoes;
begin
  FServCon.Fechar;
  FTermCon.Fechar;
end;

procedure TAppSyncTermThread.PegarFaixa(out FLogIdIni, FLogIdFin: Int64);
begin
  App.Threads.SyncTermThread_u_PegarFaixa.PegarFaixa(AppObj, Terminal, FServCon,
    FTermCon, FLogIdIni, FLogIdFin);
end;

procedure TAppSyncTermThread.RegistreAddComands(pAppObj: IAppObj;
  pTerminal: ITerminal; pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  FAddCommandsList.Add(AddComandosLoja(pAppObj, pTerminal, pServCon, pTermCon,
    FDBExecScript));
  FAddCommandsList.Add(AddComandosTerminal(pAppObj, pTerminal, pServCon,
    pTermCon, FDBExecScript));
  FAddCommandsList.Add(AddComandosPagamentoForma(pAppObj, pTerminal, pServCon,
    pTermCon, FDBExecScript));
  FAddCommandsList.Add(AddComandosFuncUsu(pAppObj, pTerminal, pServCon,
    pTermCon, FDBExecScript));
  FAddCommandsList.Add(AddComandosUsuPode(pAppObj, pTerminal, pServCon,
    pTermCon, FDBExecScript));
end;

procedure TAppSyncTermThread.Sync(pAtualIni, pAtualFIn: Int64);
var
  sFormat: string;
  sMens: string;
begin
  sFormat := 'Logs de %d a %d. Fin: %d';
  sMens := Format(sFormat, [pAtualIni, pAtualFIn, FLogIdFin]);
  StatusOutput.Exibir(sMens);

  for var Adder in FAddCommandsList do
    Adder.Execute(pAtualIni, pAtualFIn);

  FDBExecScript.PegueComando
    ('EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.ATUALIZAR(' +
    FLogIdFin.ToString + ');');

  FDBExecScript.Execute;
end;

end.
