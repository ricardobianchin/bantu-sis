unit btu.lib.db.dbms.firebird_u;

interface

uses btu.lib.db.dbms, btu.lib.config, sis.win.VersionInfo, System.Classes,
  sis.ui.io.LogProcess, sis.ui.io.output, sis.win.execute, btu.lib.db.types,
  btu.lib.db.dbms.config;

type
  TDBMSFirebird = class(TInterfacedObject, IDBMS)
  private
    FFirebirdPath: string;
    FIsqlExe: string;
    FSisConfig: ISisConfig;
    // FLogProcess: ILogProcess;
    FOutput: IOutput;
    //FPausaAntesExec: string;

    FDBMSConfig: IDBMSConfig;
    function DBMSInstalado(pLogProcess: ILogProcess; pOutput: IOutput): boolean;
    procedure PeguePaths(pLogProcess: ILogProcess; pOutput: IOutput);
    procedure ExecInstal(pLogProcess: ILogProcess; pOutput: IOutput);
    function GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo; pLogProcess: ILogProcess;
      pOutput: IOutput): string;
  protected
    property DBMSConfig: IDBMSConfig read FDBMSConfig;
  public
    function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB)
      : TDBConnectionParams;
    function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    function GarantirDBServCriadoEAtualizado(pLogProcess: ILogProcess;
      pOutput: IOutput): boolean;
    procedure GarantirDBMSInstalado(pLogProcess: ILogProcess; pOutput: IOutput);
    // procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string;
      pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput); overload;

    constructor Create(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
      pLogProcess: ILogProcess; pOutput: IOutput);
  end;

implementation

uses sis.win.Registry, System.win.Registry, Winapi.Windows, SysUtils,
  sis.types.bool.utils, sis.win.pastas, sis.win.factory,
  btu.lib.db.updater.factory, btu.lib.db.updater, sis.files, Vcl.Dialogs,
  sis.sis.clipb_u, btu.lib.debug;

{ TDBMSFirebird }

function TDBMSFirebird.DBMSInstalado(pLogProcess: ILogProcess; pOutput: IOutput): boolean;
var
  s: string;
  Resultado: boolean;
begin
  Result := False;

  s := 'TDBMSFirebird.BancoInstalado';
  Resultado := FileExists(FIsqlExe);
  if Resultado then
    Result := True;
  s := s + ', ' + Iif(Result, 'instalado', 'nao instalado');
end;

constructor TDBMSFirebird.Create(pSisConfig: ISisConfig;
  pDBMSConfig: IDBMSConfig; pLogProcess: ILogProcess; pOutput: IOutput);
begin
  FSisConfig := pSisConfig;
  FDBMSConfig := pDBMSConfig;
  FOutput := pOutput;
  PeguePaths(pLogProcess, pOutput);
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
    sExecFile := sStartIn + 'Firebird-4.0.3.2975-0-Win32.exe';
  end
  else
  begin
    sStartIn := sStartIn + 'fb64\';
    sExecFile := sStartIn + 'Firebird-4.0.3.2975-0-x64.exe';
  end;

  sParam := '/PASSWORD=masterkey /SERVER=SuperServer /SILENT /SP-' +
    ' /COMPONENTS=SuperServerComponent,ClassicServerComponent,ServerComponent,'
    + 'DevAdminComponent,ClientComponent';

  bExecuteAoCriar := True;

  pLogProcess.Exibir('ExecIntall inicio');
  pLogProcess.Exibir('sExecFile=' + sExecFile);
  pLogProcess.Exibir('sParam=' + sParam);
  pLogProcess.Exibir('sStartIn=' + sStartIn);

  pLogProcess.Exibir('vai executar');
  pOutput.Exibir('Instalando o firebird...');
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
//  sleep(10000);
  WExec.EspereExecucao(FOutput);

  PeguePaths(pLogProcess, pOutput);

  sStartIn := FFirebirdPath;
  sExecFile := sStartIn + 'instsvc.exe';
  sParam := 'start';

  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
//  sleep(3000);
  WExec.EspereExecucao(FOutput);

  pOutput.Exibir('Execução terminada');
  pLogProcess.Exibir('Execução terminada');
  pLogProcess.Exibir('ExecIntall fim');

end;

procedure TDBMSFirebird.ExecInterative(pAssunto: string; pSql: string;
  pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput);
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
    WExec.EspereExecucao(pOutput);

    pOutput.Exibir('Execução terminada');
    sLog := sLog + ',Execução terminada';
    // PeguePaths(pLogProcess, pOutput);
  finally
    pLogProcess.Exibir(sLog);
  end;
end;

{
  procedure TDBMSFirebird.ExecInterative(pNomeArqSQL: string;
  pLocalDoDB: TLocalDoDB; pLogProcess: ILogProcess; pOutput: IOutput);
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

  pLogProcess.Exibir('TDBMSFirebird.ExecInterative inicio');
  pLogProcess.Exibir('sExecFile='+sExecFile);
  pLogProcess.Exibir('sParam='+sParam);
  pLogProcess.Exibir('sStartIn='+sStartIn);

  pLogProcess.Exibir('vai executar');
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
  pLogProcess.Exibir('Execução terminada');
  pLogProcess.Exibir('TDBMSFirebird.ExecInterative fim');
  end;
}
procedure TDBMSFirebird.GarantirDBMSInstalado(pLogProcess: ILogProcess; pOutput: IOutput);
begin
  if not DBMSInstalado(pLogProcess, pOutput) then
    ExecInstal(pLogProcess, pOutput);
end;

function TDBMSFirebird.GarantirDBServCriadoEAtualizado(pLogProcess: ILogProcess;
  pOutput: IOutput): boolean;
var
  oUpdater: IDBUpdater;
  s: string;
begin
  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado'
    + ',vai DBUpdaterFirebirdCreate';
  pLogProcess.Exibir(s);

  oUpdater := DBUpdaterFirebirdCreate(ldbServidor, self, FSisConfig,
    pLogProcess, pOutput);

  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado,vai updater.execute';
  pLogProcess.Exibir(s);

  result := oUpdater.execute;

  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado'
    + ',updater.execute retornou,fim';
  pLogProcess.Exibir(s);
end;

function TDBMSFirebird.GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo;
  pLogProcess: ILogProcess; pOutput: IOutput): string;
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
  pLogProcess.Exibir(sLog);
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

procedure TDBMSFirebird.PeguePaths(pLogProcess: ILogProcess; pOutput: IOutput);
begin
  pLogProcess.Exibir('TDBMSFirebird.PeguePaths,inicio');

  FFirebirdPath := GetFirebirdExePath(FSisConfig.WinVersionInfo, pLogProcess, pOutput);
  pLogProcess.Exibir('TDBMSFirebird.PeguePaths,FFirebirdPath='+FFirebirdPath);

  FIsqlExe := FFirebirdPath + 'ISQL.exe';
  pLogProcess.Exibir('TDBMSFirebird.PeguePaths,FIsqlExe='+FIsqlExe);
end;

end.
