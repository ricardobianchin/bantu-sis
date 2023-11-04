unit btu.lib.db.updater.firebird_u;

interface

uses
  btu.lib.db.updater_u, btu.lib.config, sis.ui.io.LogProcess, sis.ui.io.output,
  btu.lib.db.types, btu.lib.db.DBMS;

// updates especivico para firebird, no pai, funcito q diz se existe o arq dados
type
  TDBUpdaterFirebird = class(TDBUpdater)
  private
    FDatabase: string;
    FArq: string;
    FNomeBanco: string;
  protected

    // procedure AtualizeBanco;virtual; abstract;
    function GetNomeBanco: string; override;
    function GetDBExiste: boolean; override;
    procedure CrieDB; override;
    // function GetSqlDbUpdateIns: string; override;
    // function GetSqlDbUpdateGetMax: string; override;
  public
    constructor Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
      pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput);
  end;

implementation

uses
  btu.lib.db.firebird.utils, System.SysUtils, sis.files, System.StrUtils,
  btu.sis.db.updater.utils, btu.lib.db.updater.firebird.GetSql_u,
  Winapi.Windows,
  System.Variants, sis.win.VersionInfo, sis.types.bool.utils, sis.win.pastas,
  dialogs;

{ TDBUpdaterFirebird }

constructor TDBUpdaterFirebird.Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pLogProcess: ILogProcess; pOutput: IOutput);
begin
  pLogProcess.Exibir('TDBUpdaterFirebird.Create, inicio');
  FArq := pDBMS.LocalDoDBToNomeArq(pLocalDoDB);
  FDatabase := pDBMS.LocalDoDBToDatabase(pLocalDoDB);
  FNomeBanco := pDBMS.LocalDoDBToNomeBanco(pLocalDoDB);

  pLogProcess.Exibir('TDBUpdaterFirebird.Create,FArq=' + FArq + ',FDatabase=' +
    FDatabase + ',FNomeBanco=' + FNomeBanco);

  pLogProcess.Exibir
    ('TDBUpdaterFirebird.Create, vai chamar inherited,TDBUpdater.Create');
  inherited Create(pLocalDoDB, pDBMS, pSisConfig, pLogProcess, pOutput);
  pLogProcess.Exibir('TDBUpdaterFirebird.Create, voltou do inherited,fim');
end;

procedure TDBUpdaterFirebird.CrieDB;
var
  sAssunto: string;
  ComandosSQL: string;
begin
  exit;
  ComandosSQL := 'CREATE DATABASE ''' + FArq + ''' page_size 8192 user ''' +
    'sysdba'' password ''masterkey'';';

  sAssunto := 'Cria';

  DBMS.ExecInterative(sAssunto, ComandosSQL, LocalDoDB, LogProcess, output);
  sleep(200);

end;

function TDBUpdaterFirebird.GetDBExiste: boolean;
var
  sPastaInstDados, sNomeArq: string;
begin
  result := true;
  exit;

  LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste ini');
  try
    showmessage('veja pasta ' + FArq);
    GarantaPastaDoArq(FArq);
    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,vai testar se ' + FArq +
      ' existe');
    result := FileExists(FArq);

    showmessage('vai testar se existe ' + FArq);
    if result then
    begin
      showmessage('nao existia');
      LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,existia, vai abortar');
      exit;
    end;

    showmessage('existia');
    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,nao existia');

    sPastaInstDados := SisConfig.PastaProduto +
      'Starter\inst\inst-Firebird\dados\';

    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,sPastaInstDados=' +
      sPastaInstDados);

    ForceDirectories(sPastaInstDados);
    sNomeArq := 'RETAG';
    if SisConfig.WinVersionInfo.Version <= 6.1 then
    begin

    end
    else
    begin
      sNomeArq := sNomeArq + '4';
      if SisConfig.WinVersionInfo.WinPlatform = wplatWin64 then
      begin
        sNomeArq := sNomeArq + '64';
      end
      else
      begin
        sNomeArq := sNomeArq + '32';
      end;
    end;
    sNomeArq := sNomeArq + '.fdb';
    sNomeArq := sPastaInstDados + sNomeArq;
    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,vai copiar(' + sNomeArq +
      ',' + FArq + ')');
    CopyFile(PChar(sNomeArq), PChar(FArq), False);

    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,vai testar se existe');
    result := FileExists(FArq);
    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste,Result=' +
      BooleanToStr(result));
  finally
    LogProcess.Exibir('TDBUpdaterFirebird.GetDBExiste fim');
  end;
end;

function TDBUpdaterFirebird.GetNomeBanco: string;
begin
  result := 'FIREBIRD';
end;

// function TDBUpdaterFirebird.GetSqlDbUpdateGetMax: string;
// begin
// Result := GetSqlDBUpdateGetMaxFirebird;
// end;

// function TDBUpdaterFirebird.GetSqlDbUpdateIns: string;
// begin
// Result := GetSqlDBUpdateInsFirebird;
// end;

end.
