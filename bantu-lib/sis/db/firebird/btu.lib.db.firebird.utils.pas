unit btu.lib.db.firebird.utils;

interface

uses btu.lib.win.VersionInfo, btu.lib.config, btu.lib.db.types;

//function FirebirdExeExiste(pWinVersionInfo: IWinVersionInfo): boolean;
//function MachineIdToDatabase(pTipoDeLocalDB: TTipoDeLocalDB;
//  pSisConfig: ISisConfig): string;
//function LocalDbToNomeArq(pTipoDeLocalDB: TTipoDeLocalDB;
//  pSisConfig: ISisConfig): string;

implementation

uses btu.lib.db.firebird.types, System.win.Registry, classes, Winapi.Windows,
  sysutils, btu.lib.win.Registry, btu.lib.win.pastas, btu.lib.types.bool.utils;

function FirebirdVersionByWinVersion(pWinVersionInfo: IWinVersionInfo)
  : TFirebirdVersion;
begin
  if pWinVersionInfo.Version = 1 then
  begin
    result := 2.5
  end;
end;
{
function FirebirdExePath(pWinVersionInfo: IWinVersionInfo): string;
var
  lReg: TRegistry;
  // lStr : String;
  RegistryView: TRegistryView;
begin
  case pWinVersionInfo.WinPlatform of
    wplatNaoIndicado:
      RegistryView := rvDefault;
    wplatWin32:
      RegistryView := rvRegistry32;
    wplatWin64:
      RegistryView := rvRegistry64;
  end;

  result := ReadRegStr(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Firebird Project\Firebird Server\Instances', 'DefaultInstance',
    RegistryView);
end;

function FirebirdExeExiste(pWinVersionInfo: IWinVersionInfo): boolean;
var
  sPasta: string;
  sNomeArq: string;
begin
  sPasta := FirebirdExePath(pWinVersionInfo);
  result := sPasta <> '';
  if not result then
    exit;

  sNomeArq := 'ISQL.exe';
  result := FileExists(sPasta + sNomeArq);
end;
}
{
function LocalDbToNomeArq(pTipoDeLocalDB: TTipoDeLocalDB;
  pSisConfig: ISisConfig): string;
var
  sCaminho: string;
begin
  sCaminho := PastaAcima(PastaAtual) + 'dados\';

  ForceDirectories(sCaminho);

  result := sCaminho;

  if pTipoDeLocalDB = ldbServidor then
    result := result + 'retag.fdb';
end;
}
{
function MachineIdToDatabase(pTipoDeLocalDB: TTipoDeLocalDB;
  pSisConfig: ISisConfig): string;
var
  sNome, sIP, sArq, sServ: string;
begin
  sArq := LocalDbToNomeArq(pTipoDeLocalDB, pSisConfig);

  result := sArq;

  if pTipoDeLocalDB = ldbServidor then
  begin
    sNome := pSisConfig.ServerMachineId.Name;
    sIP := pSisConfig.ServerMachineId.IP;
    sServ := iif(sNome = '', sIP, sNome);
    if sServ <> '' then
      Result := sServ + ':' + Result;
  end;
end;
}
end.
