unit Sis.DB.DBMS.Firebird_u;

interface

uses Sis.DB.DBTypes, Sis.Config.SisConfig, Sis.UI.IO.Output, System.Classes,
  Sis.UI.IO.Output.ProcessLog, Sis.Win.VersionInfo, Sis.Win.Execute;

type
  TDBMSFirebird = class(TInterfacedObject, IDBMS)
  private
    FFirebirdPath: string;
    FIsqlExe: string;
    FSisConfig: ISisConfig;
    // FProcessLog: IProcessLog;
    FOutput: IOutput;
    // FPausaAntesExec: string;

    FDBMSConfig: IDBMSConfig;
    function DBMSInstalado(pProcessLog: IProcessLog; pOutput: IOutput): boolean;
    procedure PeguePaths(pProcessLog: IProcessLog; pOutput: IOutput);
    procedure ExecInstal(pProcessLog: IProcessLog; pOutput: IOutput);
    function GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo;
      pProcessLog: IProcessLog; pOutput: IOutput): string;

    function GetVendorHome: string;
    function GetVendorLib: string;

  protected
    property DBMSConfig: IDBMSConfig read FDBMSConfig;
  public
    // function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB): TDBConnectionParams;
    // function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    // function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    // function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    // function GarantirDBServCriadoEAtualizado(pProcessLog: IProcessLog;
    // pOutput: IOutput): boolean;
    function GarantirDBMSInstalado(pProcessLog: IProcessLog;
      pOutput: IOutput): boolean;
    procedure ExecInterative(pAssunto: string; pSql: string; pNomeBanco: string;
      pPastaComandos: string; pProcessLog: IProcessLog; pOutput: IOutput;
      pJanelaVisivel: boolean = False); overload;

    constructor Create(pSisConfig: ISisConfig; pDBMSConfig: IDBMSConfig;
      pProcessLog: IProcessLog; pOutput: IOutput);
    property VendorHome: string read GetVendorHome;
    property VendorLib: string read GetVendorLib;

    procedure DoBackupNow(pDtHBackup: TDateTime; pDatabasesSL: TStrings;
      pPastaComandos, pPastaBackup: string; pArqsCriadosSL: TStrings;
      pPastaComprime: string);
  end;

implementation

uses Sis.Win.Registry, System.Win.Registry, Winapi.Windows, System.SysUtils,
  Sis.Types.Bool_u, Sis.Debug, Sis.UI.IO.Factory,
  Sis.UI.IO.Output.ProcessLog.Factory,

  Vcl.Dialogs, Sis.Win.Factory, Sis.UI.IO.Files, Sis.Win.Utils_u;

{ TDBMSFirebird }

function TDBMSFirebird.DBMSInstalado(pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;
var
  sLog: string;
  Resultado: boolean;
begin
  pProcessLog.PegueLocal('TDBMSFirebird.DBMSInstalado');
  try
    sLog := 'TDBMSFirebird.BancoInstalado';
    Resultado := FileExists(FIsqlExe);
    Result := Resultado;
    sLog := sLog + ', ' + Iif(Result, 'instalado', 'nao instalado');
    pProcessLog.RegistreLog(sLog)
  finally
    pProcessLog.RetorneLocal;
  end;
end;

procedure TDBMSFirebird.DoBackupNow(pDtHBackup: TDateTime;
  pDatabasesSL: TStrings; pPastaComandos, pPastaBackup: string;
  pArqsCriadosSL: TStrings; pPastaComprime: string);
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;

  iShowMode: integer;
  sNomeArq: string;
  sNomeArqOrigem: string;
  sNomeArqDestino: string;
  sNomeArqSaida: string;
  sNomeArqErro: string;
  sNomeArqBat: string;
  sComandosBak: string;
  sLinhaDeComandoBak: string;

  sComandosRes: string;
  sLinhaDeComandoRes: string;

  sDtNomeArq: string;

  i: integer;

  sDriveBackupFBK: string;
  sPastaBackupFBK: string;
  sPastaBackupCSV: string;
  sDtPasta: string;
  sComandoComprime: string;
begin
  if pDtHBackup = 0 then
    pDtHBackup := Now;

  sDtNomeArq := DateTimeToNomeArq(pDtHBackup);
  sDtPasta := Copy(sDtNomeArq, 1, 10);
  sPastaBackupFBK := pPastaBackup + 'FBK\' + sDtPasta + '\';
  sPastaBackupCSV := pPastaBackup + 'CSV\' + sDtPasta + '\';

  sDriveBackupFBK := ExtractFileDrive(sPastaBackupFBK);

  sComandoComprime := '"' + pPastaComprime +
    '7za.exe" a -tzip "%s.zip" * -sdel -x!*.zip';

  GarantirPasta(sPastaBackupFBK);
  GarantirPasta(sPastaBackupCSV);

  GarantirPasta(pPastaComandos);

  pArqsCriadosSL.Clear;
  sComandosBak := sDriveBackupFBK + #13#10'CD "' + sPastaBackupFBK + '"' +
    #13#10#13#10;
  sComandosRes := '';
  for i := 0 to pDatabasesSL.Count - 1 do
  begin
    sNomeArqOrigem := pDatabasesSL[i];

    sNomeArq := ExtractFileName(sNomeArqOrigem);
    sNomeArq := ChangeFileExt(sNomeArq, '');

    sNomeArq := sDtNomeArq + ' ' + sNomeArq;

    sNomeArqDestino := sPastaBackupFBK + sNomeArq + '.fbk';
    sNomeArqSaida := sPastaBackupFBK + sNomeArq + '.Bak.Saida.txt';
    sNomeArqErro := sPastaBackupFBK + sNomeArq + '.Bak.Erro.txt';

    pArqsCriadosSL.Add(ChangeFileExt(sNomeArqDestino, '.zip'));

    sLinhaDeComandoBak := '"' + FFirebirdPath +
      'gbak.exe" -v -b -user SYSDBA -password masterkey "' + sNomeArqOrigem +
      '" "' + sNomeArqDestino + '" > "' + sNomeArqSaida + '" 2> "' +
      sNomeArqErro + '"';

    sComandosBak := sComandosBak + sLinhaDeComandoBak + #13#10;
    sComandosBak := sComandosBak + Format(sComandoComprime, [sNomeArq]) +
      #13#10#13#10;

  end;

  {
    "C:\Program Files (x86)\Firebird\Firebird_5_0\gbak.exe" -v -c -user SYSDBA -password masterkey "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.fbk" "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\Dados_Mercado_Terminal_001.fdb" > "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.Restore_Saida.txt" 2> "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.Restore_Erro.txt"

    // "C:\Program Files (x86)\Firebird\Firebird_5_0\gbak.exe" -v -c -user
    SYSDBA -password masterkey
    2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.fbk
    Dados_Mercado_Terminal_001.fdb" > "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.Restore_Saida.txt" 2> "C:\Pr\app\bantu\bantu-sis\Exe\Backup\FBK\2025-04-05_00h38m22s156\2025-04-05_00h38m22s156 Dados_Mercado_Terminal_001.Restore_Erro.txt"
  }
  sNomeArqBat := pPastaComandos + 'Backup\';
  ForceDirectories(sNomeArqBat);
  sNomeArqBat := sNomeArqBat + sDtNomeArq + ' execute backups.bat';
  EscreverArquivo(sComandosBak, sNomeArqBat);

  sExecFile := sNomeArqBat;
  sStartIn := pPastaComandos;
  sParam := '';
  bExecuteAoCriar := True;
  iShowMode := SW_SHOWMINNOACTIVE;

  // Iif(pJanelaVisivel, SW_SHOWNOACTIVATE, SW_HIDE);
  WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar,
    iShowMode);
  // WExec.EspereExecucao(pOutput);
end;

constructor TDBMSFirebird.Create(pSisConfig: ISisConfig;
  pDBMSConfig: IDBMSConfig; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FSisConfig := pSisConfig;
  FDBMSConfig := pDBMSConfig;
  FOutput := pOutput;
  PeguePaths(pProcessLog, pOutput);
end;

procedure TDBMSFirebird.ExecInstal;
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;
begin
  pProcessLog.PegueLocal('TDBMSFirebird.ExecInstal');
  try

    sStartIn := GetPastaDoArquivo(ParamStr(0));
    sStartIn := PastaAcima(sStartIn);
    sStartIn := sStartIn + 'Inst\inst-Firebird\';

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
      ' /COMPONENTS=SuperServerComponent,ClassicServerComponent,' +
      'ServerComponent,DevAdminComponent,ClientComponent';

    bExecuteAoCriar := True;

    pProcessLog.RegistreLog('ExecInstal inicio');
    pProcessLog.RegistreLog('sExecFile=' + sExecFile);
    pProcessLog.RegistreLog('sParam=' + sParam);
    pProcessLog.RegistreLog('sStartIn=' + sStartIn);

    pProcessLog.RegistreLog('vai executar');
    pOutput.Exibir('Instalando o firebird...');
    WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
    // s l e ep(10000);
    WExec.EspereExecucao(FOutput);

    PeguePaths(pProcessLog, pOutput);

    sStartIn := FFirebirdPath;
    sExecFile := sStartIn + 'instsvc.exe';
    sParam := 'start';

    WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar);
    // s l e e p(3000);
    WExec.EspereExecucao(FOutput);

    pOutput.Exibir('Execu��o terminada');
    pProcessLog.RegistreLog('Execu��o terminada');
    pProcessLog.RegistreLog('ExecIntall fim');
  finally
    pProcessLog.RetorneLocal;
  end;
end;

procedure TDBMSFirebird.ExecInterative(pAssunto: string; pSql: string;
  pNomeBanco: string; pPastaComandos: string; pProcessLog: IProcessLog;
  pOutput: IOutput; pJanelaVisivel: boolean);
var
  sStartIn: string;
  sExecFile: string;
  sParam: string;
  sNomeArqTmp: string;

  bExecuteAoCriar: boolean;

  WExec: IWinExecute;

  sLog: string;

  iShowMode: integer;

begin
  if not Assigned(pOutput) then
    pOutput := MudoOutputCreate;

  if not Assigned(pProcessLog) then
    pProcessLog := MudoProcessLogCreate;

  pProcessLog.PegueLocal('TDBMSFirebird.ExecInterative');
  try
    sLog := 'inicio';
    try
      if Trim(pSql) = '' then
      begin
        sLog := 'sql zerada, abortando';
        exit;
      end;

      GarantirPasta(pPastaComandos);

      sNomeArqTmp := pPastaComandos + DateTimeToNomeArq() + ' ' +
        Trim('SQL ' + pAssunto) + ' ' + pNomeBanco + '.sql';

      sLog := sLog + ',sNomeArqTmp=' + sNomeArqTmp;

      EscreverArquivo(pSql, sNomeArqTmp);

      if DBMSConfig.PausaAntesExec then
      begin
        ExecutarNotepadPlusPlus(sNomeArqTmp);
      end;

      sExecFile := FIsqlExe;
      sStartIn := FFirebirdPath;
      sParam := '-user sysdba -password masterkey -i "' + sNomeArqTmp + '"';
      // -ch WIN1252';

      bExecuteAoCriar := True;

      sLog := sLog + ',sExecFile=' + sExecFile + ',sParam=' + sParam +
        ',sStartIn=' + sStartIn;

      pOutput.Exibir('Executando via ISQL ' +
        ExtractFileName(sNomeArqTmp) + '...');
      iShowMode := Iif(pJanelaVisivel, SW_SHOWNOACTIVATE, SW_HIDE);
      WExec := WinExecuteCreate(sExecFile, sParam, sStartIn, bExecuteAoCriar,
        iShowMode);
      WExec.EspereExecucao(pOutput);

      pOutput.Exibir('Execu��o terminada');
      sLog := sLog + ',Execu��o terminada';
    finally
      pProcessLog.RegistreLog(sLog);
    end;
  finally
    pProcessLog.RetorneLocal;
  end;
end;

function TDBMSFirebird.GarantirDBMSInstalado(pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;
begin
  pProcessLog.PegueLocal('TDBMSFirebird.GarantirDBMSInstalado');
  try
    pProcessLog.RegistreLog('vai DBMSInstalado');
    Result := DBMSInstalado(pProcessLog, pOutput);

    if Result then
    begin
      pProcessLog.RegistreLog('retornou true');
      exit;
    end;
    pProcessLog.RegistreLog('retornou false, nao encontrou o Firebird');

    raise Exception.Create('Erro: Firebird n�o detectado');
    // ExecInstal(pProcessLog, pOutput);
  finally
    pProcessLog.RetorneLocal;
  end;
end;

{
  function TDBMSFirebird.GarantirDBServCriadoEAtualizado(pProcessLog: IProcessLog;
  pOutput: IOutput): boolean;
  var
  oUpdater: IDBUpdater;
  s: string;
  begin
  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado' +
  ',vai DBUpdaterFirebirdCreate';
  pProcessLog.Exibir(s);

  oUpdater := DBUpdaterFirebirdCreate(ldbServidor, self, FSisConfig,
  pProcessLog, pOutput);

  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado,vai updater.execute';
  pProcessLog.Exibir(s);

  Result := oUpdater.Execute;

  s := 'TDBMSFirebird.GarantirDBServCriadoEAtualizado' +
  ',updater.execute retornou,fim';
  pProcessLog.Exibir(s);
  end;
}
function TDBMSFirebird.GetFirebirdExePath(pWinVersionInfo: IWinVersionInfo;
  pProcessLog: IProcessLog; pOutput: IOutput): string;
var
  // lReg: TRegistry;
  // lStr : String;
  RegistryView: TRegistryView;
  sLog: string;
begin
  Result := 'C:\Program Files\Firebird\Firebird_5_0\';

  if not FileExists(Result + 'isql.exe') then
    Result := 'C:\Program Files (x86)\Firebird\Firebird_5_0\';

  // {$IFDEF DEBUG}
  // {$ELSE}
  // {$ENDIF}
  // exit;

  pProcessLog.PegueLocal('TDBMSFirebird.GetFirebirdExePath');
  try
    sLog := '';
    case pWinVersionInfo.WinPlatform of
      wplatNaoIndicado:
        begin
          RegistryView := rvDefault;
          sLog := sLog + 'rvDefault';
        end;
      wplatWin32:
        begin
          RegistryView := rvRegistry32;
          sLog := sLog + 'rvRegistry32';
        end;
    else // wplatWin64:
      begin
        RegistryView := rvRegistry64;
        sLog := sLog + 'rvRegistry64';
      end;
    end;

    {
      Result := ReadRegStr(HKEY_LOCAL_MACHINE,
      'SOFTWARE\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
      RegistryView);

    }

    // Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Firebird Project\Firebird Server\Instances

    Result := ReadRegStr(HKEY_LOCAL_MACHINE,
      'SOFTWARE\WOW6432Node\Firebird Project\Firebird Server\Instances',
      'DefaultInstance', RegistryView);


    // Result := ReadRegStr(HKEY_LOCAL_MACHINE,
    // 'SOFTWARE\WOW6432Node\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    // rvDefault);
    //
    // Result := ReadRegStr(HKEY_LOCAL_MACHINE,
    // 'SOFTWARE\WOW6432Node\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    // rvRegistry32);
    //
    // Result := ReadRegStr(HKEY_LOCAL_MACHINE,
    // 'SOFTWARE\WOW6432Node\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    // rvRegistry64);

    if Result <> '' then
      Result := IncludeTrailingPathDelimiter(Result);
    sLog := sLog + ', [' + Result + ']';
    pProcessLog.RegistreLog(sLog);
  finally
    pProcessLog.RetorneLocal;
  end;
end;

function TDBMSFirebird.GetVendorHome: string;
begin
  Result := FFirebirdPath;
end;

function TDBMSFirebird.GetVendorLib: string;
begin
  Result := 'fbclient.dll';
end;

{
  function TDBMSFirebird.LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB)
  : TDBConnectionParams;
  begin
  Result.Server := FSisConfig.ServerMachineId.GetIdent;
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

  sServ := FSisConfig.ServerMachineId.GetIdent;
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
}
procedure TDBMSFirebird.PeguePaths(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  pProcessLog.PegueLocal('TDBMSFirebird.PeguePaths');
  try
    pProcessLog.RegistreLog('inicio');

    FFirebirdPath := GetFirebirdExePath(FSisConfig.WinVersionInfo,
      pProcessLog, pOutput);
    pProcessLog.RegistreLog('FFirebirdPath=' + FFirebirdPath);

    FIsqlExe := FFirebirdPath + 'ISQL.exe';
    pProcessLog.RegistreLog('FIsqlExe=' + FIsqlExe);
  finally
    pProcessLog.RetorneLocal;
  end;
end;

end.
