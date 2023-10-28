unit btu.lib.db.dbms.firebird_u;

interface

uses btu.lib.db.dbms, btu.lib.config, sis.win.VersionInfo, System.Classes,
  sis.ui.io.log, sis.ui.io.output, sis.win.execute, btu.lib.db.types,
  btu.lib.db.dbms.config;

type
  TDBMSFirebird = class(TInterfacedObject, IDBMS)
  private
    FFirebirdPath: string;
    FIsqlExe: string;
    FSisConfig: ISisConfig;
    // FLog: ILog;
    // FOutput: IOutput;
    //FPausaAntesExec: string;

    FDBMSConfig: IDBMSConfig;
    function DBMSInstalado(pLog: iLog; pOutput: IOutput): boolean;
    procedure PeguePaths(pLog: iLog; pOutput: IOutput);
    procedure ExecInstal(pLog: iLog; pOutput: IOutput);
    function GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo; pLog: iLog;
      pOutput: IOutput): string;
  protected
    property DBMSConfig: IDBMSConfig read FDBMSConfig;
  public
    function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB)
      : TDBConnectionParams;
    function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    function GarantirDBServCriadoEAtualizado(pLog: iLog;
      pOutput: IOutput): boolean;
    procedure GarantirDBMSInstalado(pLog: iLog; pOutput: IOutput);
    // procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string;
      pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;

    constructor Create(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
      pLog: iLog; pOutput: IOutput);
  end;

implementation

uses sis.win.Registry, System.win.Registry, Winapi.Windows, SysUtils,
  sis.types.bool.utils, sis.win.pastas, sis.win.factory,
  btu.lib.db.updater.factory, btu.lib.db.updater, sis.files, Vcl.Dialogs,
  sis.sis.clipb_u, btu.lib.debug;

{ TDBMSFirebird }

function TDBMSFirebird.DBMSInstalado(pLog: iLog; pOutput: IOutput): boolean;
var
  s: string;
begin
  s := 'TDBMSFirebird.BancoInstalado';
  Result := FileExists(FIsqlExe);
  s := s + ', ' + Iif(Result, 'instalado', 'nao instalado');
end;

constructor TDBMSFirebird.Create(pSisConfig: ISisConfig;
  pDBMSConfig: IDBMSConfig; pLog: iLog; pOutput: IOutput);
begin
  FSisConfig := pSisConfig;
  FDBMSConfig := pDBMSConfig;
  PeguePaths(pLog, pOutput);
end;

procedure TDBMSFirebird.ExecInstal;
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
  I: Integer;
begin
  sStartIn := ParamStr(0);
  sStartIn := ExtractFilePath(sStartIn);
  sStartIn := sStartIn + 'inst\inst-Firebird\';

  if FSisConfig.WinVersionInfo.Version <= 6.1 then
  begin
    sStartIn := sStartIn + 'fb32\';
    sExecFile := sStartIn + 'Firebird-4.0.2.2816-0-Win32.exe';
  end
  else
  begin
    sStartIn := sStartIn + 'fb64\';
    sExecFile := sStartIn + 'Firebird-4.0.2.2816-0-x64.exe';
  end;

  sParam := '/PASSWORD=masterkey /SERVER=SuperServer /SILENT /SP-' +
    ' /COMPONENTS=SuperServerComponent,ClassicServerComponent,ServerComponent,'
    + 'DevAdminComponent,ClientComponent';

  bExecuteAoCriar := true;

  pLog.Exibir('ExecIntall inicio');
  pLog.Exibir('sExecFile=' + sExecFile);
  pLog.Exibir('sParam=' + sParam);
  pLog.Exibir('sStartIn=' + sStartIn);

  pLog.Exibir('vai executar');
  pOutput.Exibir('Instalando o firebird...');
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  while WExec.Executando do
  begin
    for I := 1 to 8 do
    begin
      sleep(100);
      if not WExec.Executando then
        break;
    end;
    if WExec.Executando then
      pOutput.Exibir('Aguardando a execução...');
  end;

  pOutput.Exibir('Execução terminada');
  pLog.Exibir('Execução terminada');
  pLog.Exibir('ExecIntall fim');
  PeguePaths(pLog, pOutput);
end;

procedure TDBMSFirebird.ExecInterative(pAssunto: string; pSql: string;
  pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput);
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;
  sNomeArqTmp: string;
  sNomeBanco: string;
  sPastaTmp: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
  I: Integer;

  s: string;
  sLog: string;
begin
  sLog := 'TDBMSFirebird.ExecInterative inicio';
  try
    if Trim(pSql) = '' then
    begin
      sLog := 'sql zerada, abortando';
      exit;
    end;

    sPastaTmp := FSisConfig.PastaProduto + 'tmp\comandos\';
    ForceDirectories(sPastaTmp);

    sNomeBanco := LocalDoDBToNomeBanco(pLocalDoDB);
    sNomeArqTmp := Trim(sPastaTmp + 'SQL ' + pAssunto);

    sNomeArqTmp := sNomeArqTmp + ' ' + sNomeBanco + ' ' +
      DateTimeToNomeArq() + '.sql';

    sLog := sLog + ',sNomeArqTmp=' + sNomeArqTmp;

    EscreverArquivo(pSql, sNomeArqTmp);

    if DBMSConfig.PausaAntesExec then
    begin
      // SetClipboardText(sNomeArqTmp);
      ExecutarNotepadPlusPlus(sNomeArqTmp);
    end;

    sExecFile := FIsqlExe;
    sStartIn := FFirebirdPath;
    sParam := '-user sysdba -password masterkey -i "' + sNomeArqTmp + '"';

    bExecuteAoCriar := true;

    sLog := sLog + ',sExecFile=' + sExecFile + ',sParam=' + sParam +
      ',sStartIn=' + sStartIn;

    pOutput.Exibir('Executando via ISQL ' +
      ExtractFileName(sNomeArqTmp) + '...');
    WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
    while WExec.Executando do
    begin
      for I := 1 to 10 do
      begin
        sleep(100);
        if not WExec.Executando then
          break;
      end;
      if WExec.Executando then
        pOutput.Exibir('Aguardando a execução...');
    end;

    pOutput.Exibir('Execução terminada');
    sLog := sLog + ',Execução terminada';
    // PeguePaths(pLog, pOutput);
  finally
    pLog.Exibir(sLog);
  end;
end;

{
  procedure TDBMSFirebird.ExecInterative(pNomeArqSQL: string;
  pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput);
  var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
  I: Integer;
  //sLog: string;
  begin
  sExecFile := FIsqlExe;
  sStartIn := FFirebirdPath;
  sParam := '-user sysdba -password masterkey -i "' + pNomeArqSQL + '"';

  bExecuteAoCriar := true;

  pLog.Exibir('TDBMSFirebird.ExecInterative inicio');
  pLog.Exibir('sExecFile='+sExecFile);
  pLog.Exibir('sParam='+sParam);
  pLog.Exibir('sStartIn='+sStartIn);

  pLog.Exibir('vai executar');
  pOutput.Exibir('instalando o firebird...');
  pOutput.Exibir('Executando via ISQL ' + ExtractFileName(pNomeArqSQL) + '...');
  //  sLog := 'vai exec';
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  //  sLog := sLog + ',exec';
  while WExec.Executando do
  begin
  //    sLog := sLog + ',fora pausa';
  for I := 1 to 2 do
  begin
  //      sLog := sLog + ',dentro pausa';
  sleep(500);
  if not WExec.Executando then
  break;
  end;
  //    sLog := sLog + ',testar';
  if WExec.Executando then
  pOutput.Exibir('Aguardando a execução...');
  end;
  //  sLog := sLog + ',saiu loop';
  //  pOutput.Exibir(slog);
  Sleep(100);

  pOutput.Exibir('Execução terminada');
  pLog.Exibir('Execução terminada');
  pLog.Exibir('TDBMSFirebird.ExecInterative fim');
  end;
}
procedure TDBMSFirebird.GarantirDBMSInstalado(pLog: iLog; pOutput: IOutput);
begin
  if not DBMSInstalado(pLog, pOutput) then
    ExecInstal(pLog, pOutput);
end;

function TDBMSFirebird.GarantirDBServCriadoEAtualizado(pLog: iLog;
  pOutput: IOutput): boolean;
var
  updater: IDBUpdater;
begin
  pLog.Exibir('TDBMSFirebird.GarantirDBServCriadoEAtualizado,vai DBUpdaterFirebirdCreate');
  updater := DBUpdaterFirebirdCreate(ldbServidor, self, FSisConfig,
    pLog, pOutput);
  pLog.Exibir('TDBMSFirebird.GarantirDBServCriadoEAtualizado,vai updater.execute');
  result := updater.execute;
  pLog.Exibir('TDBMSFirebird.GarantirDBServCriadoEAtualizado,updater.execute retornou,fim');
end;

function TDBMSFirebird.GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo;
  pLog: iLog; pOutput: IOutput): string;
var
  // lReg: TRegistry;
  // lStr : String;
  RegistryView: TRegistryView;
  sLog: string;
begin
  sLog := 'TDBMSFirebird.GetFirebirdExePath';
  case pWinVersionInfo.WinPlatform of
    wplatNaoIndicado:
      begin
        RegistryView := rvDefault;
        sLog := sLog + ',' + 'rvDefault';
      end;
    wplatWin32:
      begin
        RegistryView := rvRegistry32;
        sLog := sLog + ',' + 'rvRegistry32';
      end;
    else //wplatWin64:
      begin
        RegistryView := rvRegistry64;
        sLog := sLog + ',' + 'rvRegistry64';
      end;
  end;

  Result := ReadRegStr(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    RegistryView);
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result);
  sLog := sLog + ', [' + Result + ']';
  pLog.Exibir(sLog);
  // pOutput.Exibir(sLog);
end;

function TDBMSFirebird.LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB)
  : TDBConnectionParams;
begin
  Result.Server := FSisConfig.ServerMachineId.GetServerName;
  Result.Arq := LocalDoDBToNomeArq(pLocalDoDB);
  Result.Database := Result.Arq;
  if Result.Server <> '' then
    Result.Database := Result.Server + ':' + Result.Database;
end;

function TDBMSFirebird.LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;
var
  sArq, sServ: string;
begin
  sArq := LocalDoDBToNomeArq(pLocalDoDB);

  Result := sArq;

  sServ := FSisConfig.ServerMachineId.GetServerName;
  if sServ <> '' then
    Result := sServ + ':' + Result;
end;

function TDBMSFirebird.LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
begin
  Result := FSisConfig.PastaProduto + 'dados\' + LocalDoDBToNomeBanco
    (pLocalDoDB) + '.fdb';
end;

function TDBMSFirebird.LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
begin
  case pLocalDoDB of
    ldbNaoIndicado:
      Result := '';
    ldbServidor:
      Result := 'retag';
    ldbTerminal:
      Result := '';
  end;
end;

procedure TDBMSFirebird.PeguePaths(pLog: iLog; pOutput: IOutput);
begin
  pLog.Exibir('TDBMSFirebird.PeguePaths,inicio');

  FFirebirdPath := GetFirebirdExePath(FSisConfig.WinVersionInfo, pLog, pOutput);
  pLog.Exibir('TDBMSFirebird.PeguePaths,FFirebirdPath='+FFirebirdPath);

  FIsqlExe := FFirebirdPath + 'ISQL.exe';
  pLog.Exibir('TDBMSFirebird.PeguePaths,FIsqlExe='+FIsqlExe);
end;

end.
