unit btu.lib.db.dbms.firebird_u;

interface

uses btu.lib.db.dbms, btu.lib.config, btu.lib.win.VersionInfo, System.Classes,
  btu.sis.ui.io.log, btu.sis.ui.io.output, btu.lib.win.execute, btu.lib.db.types,
  btu.lib.db.dbms.config;

type
  TDBMSFirebird = class(TInterfacedObject, IDBMS)
  private
    FFirebirdPath: string;
    FIsqlExe: string;
    FSisConfig: ISisConfig;
//    FLog: ILog;
//    FOutput: IOutput;
    FPausaAntesExec: string;

    FDBMSConfig: IDBMSConfig;
    function BancoInstalado(pLog: iLog; pOutput: IOutput): boolean;
    procedure PeguePaths(pLog: iLog; pOutput: IOutput);
    procedure ExecInstal(pLog: iLog; pOutput: IOutput);
    function GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo; pLog: iLog; pOutput: IOutput): string;
  protected
    property DBMSConfig: IDBMSConfig read FDBMSConfig;
  public
    function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB): TDBConnectionParams;
    function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    procedure GarantirDBServCriadoEAtualizado(pLog: iLog; pOutput: IOutput);
    procedure GarantirDBMSInstalado(pLog: iLog; pOutput: IOutput);
    procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSLSql: TStrings; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;

    constructor Create(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
      pLog: iLog; pOutput: IOutput);
  end;

implementation

uses btu.lib.win.Registry, System.win.Registry, Winapi.Windows, SysUtils,
  btu.lib.types.bool.utils, btu.lib.win.pastas, btu.lib.win.factory,
  btu.lib.db.updater.factory, btu.lib.db.updater, btu.lib.files, Vcl.Dialogs,
  btu.lib.sis.clipb_u, btu.lib.debug;

{ TDBMSFirebird }

function TDBMSFirebird.BancoInstalado(pLog: iLog; pOutput: IOutput): boolean;
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
  sStartIn := PastaAcima(sStartIn);
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

  sParam := '/PASSWORD=masterkey /SERVER=SuperServer /SILENT /SP-'
    +' /COMPONENTS=SuperServerComponent,ClassicServerComponent,ServerComponent,'
    +'DevAdminComponent,ClientComponent'
    ;

  bExecuteAoCriar := true;

  pLog.Exibir('ExecIntall inicio');
  pLog.Exibir('sExecFile='+sExecFile);
  pLog.Exibir('sParam='+sParam);
  pLog.Exibir('sStartIn='+sStartIn);

  pLog.Exibir('vai executar');
  pOutput.Exibir('instalando o firebird...');
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  while WExec.Executando do
  begin
    for I := 1 to 8 do
    begin
      sleep(1000);
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

procedure TDBMSFirebird.ExecInterative(pAssunto: string; pSLSql: TStrings;
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
begin
  if Trim(pSLSql.Text) = '' then
    exit;

  sPastaTmp := FSisConfig.PastaProduto + 'tmp\comandos\';
  ForceDirectories(sPastaTmp);

  sNomeBanco := LocalDoDBToNomeBanco(pLocalDoDB);
  sNomeArqTmp := Trim(sPastaTmp + 'SQL ' + pAssunto);

  sNomeArqTmp := sNomeArqTmp + ' '  + sNomeBanco + ' ' +
    DateTimeToNomeArq() + '.sql';

  pSLSql.SaveToFile(sNomeArqTmp);

  if DBMSConfig.PausaAntesExec then
  begin
    //SetClipboardText(sNomeArqTmp);
    ExecutarNotepadPlusPlus(sNomeArqTmp);
    showmessage('vai executar ' + sNomeArqTmp);
  end;

  sExecFile := FIsqlExe;
  sStartIn := FFirebirdPath;
  sParam := '-user sysdba -password masterkey -i "' + sNomeArqTmp + '"';

  bExecuteAoCriar := true;

  pLog.Exibir('TDBMSFirebird.ExecInterative inicio');
  pLog.Exibir('sExecFile='+sExecFile);
  pLog.Exibir('sParam='+sParam);
  pLog.Exibir('sStartIn='+sStartIn);

  pLog.Exibir('vai executar');
  pOutput.Exibir('Executando via ISQL ' + ExtractFileName(sNomeArqTmp) + '...');
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  while WExec.Executando do
  begin
    for I := 1 to 2 do
    begin
      sleep(1000);
      if not WExec.Executando then
        break;
    end;
    if WExec.Executando then
      pOutput.Exibir('Aguardando a execução...');
  end;

  pOutput.Exibir('Execução terminada');
  pLog.Exibir('Execução terminada');
  pLog.Exibir('TDBMSFirebird.ExecInterative fim');
  //PeguePaths(pLog, pOutput);
end;

procedure TDBMSFirebird.ExecInterative(pNomeArqSQL: string;
  pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput);
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
  I: Integer;
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
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
  while WExec.Executando do
  begin
    for I := 1 to 2 do
    begin
      sleep(1000);
      if not WExec.Executando then
        break;
    end;
    if WExec.Executando then
      pOutput.Exibir('Aguardando a execução...');
  end;

  pOutput.Exibir('Execução terminada');
  pLog.Exibir('Execução terminada');
  pLog.Exibir('TDBMSFirebird.ExecInterative fim');
end;

procedure TDBMSFirebird.GarantirDBMSInstalado(pLog: iLog; pOutput: IOutput);
begin
  if not BancoInstalado(pLog, pOutput) then
    ExecInstal(pLog, pOutput);
end;

procedure TDBMSFirebird.GarantirDBServCriadoEAtualizado(pLog: iLog; pOutput: IOutput);
var
  Updater: IDBUpdater;
begin
  Updater := DBUpdaterFirebirdCreate(ldbServidor, self, FSisConfig, pLog, pOutput);
  Updater.Execute;
end;

function TDBMSFirebird.GetFirebirdExePath(pWinVersionInfo
  : IWinVersionInfo; pLog: iLog; pOutput: IOutput): string;
var
//  lReg: TRegistry;
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
    wplatWin64:
    begin
      RegistryView := rvRegistry64;
      sLog := sLog + ',' + 'rvRegistry64';
    end;
  end;

  result := ReadRegStr(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    RegistryView);
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result);
  sLog := sLog + ', ['+ Result + ']';
  pLog.Exibir(sLog);
//  pOutput.Exibir(sLog);
end;

function TDBMSFirebird.LocalDoDBToConnectionParams(
  pLocalDoDB: TLocalDoDB): TDBConnectionParams;
begin
  Result.Server := FSisConfig.ServerMachineId.GetServerName;
  Result.Arq := LocalDoDBToNomeArq(pLocalDoDB);
  Result.Database := Result.Arq;
  if Result.Server <> '' then
    Result.Database := Result.Server + ':' + Result.Database;
end;

function TDBMSFirebird.LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;
var
  sNome, sIP, sArq, sServ: string;
begin
  sArq := LocalDoDBToNomeArq(pLocalDoDB);

  Result := sArq;

  sServ := FSisConfig.ServerMachineId.GetServerName;
  if sServ <> '' then
    Result := sServ + ':' + Result;
end;

function TDBMSFirebird.LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
begin
  Result := FSisConfig.PastaProduto+'dados\' + LocalDoDBToNomeBanco(pLocalDoDB) + '.fdb';
end;

function TDBMSFirebird.LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
begin
  case pLocalDoDB of
    ldbNaoIndicado: Result := '';
    ldbServidor: Result := 'retag';
    ldbTerminal: Result := '';
  end;
end;

procedure TDBMSFirebird.PeguePaths(pLog: iLog; pOutput: IOutput);
var
  sLog: string;
begin
  sLog := 'TDBMSFirebird.PeguePaths';

  FFirebirdPath := GetFirebirdExePath(FSisConfig.WinVersionInfo, pLog, pOutput);
  FIsqlExe := FFirebirdPath + 'ISQL.exe';

  sLog := sLog + ',' + FIsqlExe;
  pLog.Exibir(sLog);
end;

end.
