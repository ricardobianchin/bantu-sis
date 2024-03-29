unit btu.lib.db.updater.firebird_u;

interface

uses
  btu.lib.db.updater_u, btu.lib.config, sis.ui.io.ProcessLog, sis.ui.io.output,
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
      pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput);
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
  pSisConfig: ISisConfig; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  pProcessLog.Exibir('TDBUpdaterFirebird.Create, inicio');
  FArq := pDBMS.LocalDoDBToNomeArq(pLocalDoDB);
  FDatabase := pDBMS.LocalDoDBToDatabase(pLocalDoDB);
  FNomeBanco := pDBMS.LocalDoDBToNomeBanco(pLocalDoDB);

  pProcessLog.Exibir('TDBUpdaterFirebird.Create,FArq=' + FArq + ',FDatabase=' +
    FDatabase + ',FNomeBanco=' + FNomeBanco);

  pProcessLog.Exibir
    ('TDBUpdaterFirebird.Create, vai chamar inherited,TDBUpdater.Create');
  inherited Create(pLocalDoDB, pDBMS, pSisConfig, pProcessLog, pOutput);
  pProcessLog.Exibir('TDBUpdaterFirebird.Create, voltou do inherited,fim');
end;

procedure TDBUpdaterFirebird.CrieDB;
var
  sAssunto: string;
  ComandosSQL: string;
begin
  ComandosSQL := 'CREATE DATABASE ''' + FArq + ''' page_size 8192 user ''' +
    'sysdba'' password ''masterkey'';';

  sAssunto := 'Cria';

  DBMS.ExecInterative(sAssunto, ComandosSQL, LocalDoDB, ProcessLog, output);
  sleep(200);
end;

function TDBUpdaterFirebird.GetDBExiste: boolean;
var
  sPastaInstDados, sNomeArq: string;
begin
  ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste ini');
  try
    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,vai testar se ' + FArq +
      ' existe');
    result := FileExists(FArq);

    if result then
    begin
      ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,existia, vai abortar');
      exit;
    end;

    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,nao existia');

    GarantaPastaDoArq(FArq);

    sPastaInstDados := SisConfig.PastaProduto +
      'Starter\inst\inst-Firebird\dados\';

    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,sPastaInstDados=' +
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
    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,vai copiar(' + sNomeArq +
      ',' + FArq + ')');
    CopyFile(PChar(sNomeArq), PChar(FArq), False);

    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,vai testar se existe');
    result := FileExists(FArq);
    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste,Result=' +
      BooleanToStr(result));
  finally
    ProcessLog.Exibir('TDBUpdaterFirebird.GetDBExiste fim');
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
